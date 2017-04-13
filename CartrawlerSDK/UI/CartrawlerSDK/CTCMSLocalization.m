//
//  CTCMSLocalization.m
//  CartrawlerSDK
//
//  Created by Alan on 05/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCMSLocalization.h"
#import "CTFileSystemAccess.h"
#import "CTCMSJSONParser.h"
#import "CTCMSCommunicator.h"

static NSString *CTCMSLocalizationIndex = @"versions";

@interface CTCMSLocalization ()
@property (nonatomic, strong) NSDictionary *cachedIndex;
@property (nonatomic, strong) NSDictionary *cmsIndex;

@property (nonatomic, strong) NSMutableDictionary *localizations;
@end

@implementation CTCMSLocalization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.localizations = [NSMutableDictionary new];
        [self loadIndex];
    }
    return self;
}

- (NSString *)localizedStringForKey:(NSString *)key bundle:(NSBundle *)bundle language:(NSString *)language {
    NSString *identifier = [self identifierForBundleIdentifier:bundle.bundleIdentifier];
    identifier = [identifier stringByAppendingPathComponent:language];
    
    if (!self.localizations[identifier]) {
        [self loadLocalizationsForIdentifier:identifier];
    }
    
    return self.localizations[identifier][key] ?: key;
}

- (NSString *)identifierForBundleIdentifier:(NSString *)bundleIdentifier {
    bundleIdentifier = [bundleIdentifier stringByReplacingOccurrencesOfString:@"com.cartrawler" withString:@"ios"];
    return [bundleIdentifier stringByReplacingOccurrencesOfString:@"." withString:@"_"];
}

// MARK: Versions File

- (void)loadIndex {
    [self loadCachedIndex];
    [self loadCMSIndex];
}

- (void)loadCachedIndex {
    NSData *data = [CTFileSystemAccess fetchJSONResourceFromDocumentDirectory:CTCMSLocalizationIndex];
    self.cachedIndex = [CTCMSJSONParser dictionaryFromJSON:data];
}

- (void)loadCMSIndex {
    [CTCMSCommunicator fetchFile:@"versions" withCompletionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (data) {
            [self cmsIndexDidLoad:data];
        }
    }];
}

- (void)cmsIndexDidLoad:(NSData *)index {
    [CTFileSystemAccess saveJSONResource:index toDocumentDirectory:CTCMSLocalizationIndex];
    self.cmsIndex = [CTCMSJSONParser dictionaryFromJSON:index];
    [self refreshLocalizations];
}

// MARK: Localizations Store

- (void)loadLocalizationsForIdentifier:(NSString *)identifier {
    [self loadCachedLocalizationsForIdentifier:identifier];
    [self checkRemoteLocalizationsForIdentifier:identifier];
}

- (void)loadCachedLocalizationsForIdentifier:(NSString *)identifier {
    NSDictionary *localizations;
    
    if (self.cachedIndex) {
        NSNumber *timestamp = [self timestampForIdentifier:identifier inIndex:self.cachedIndex];
        NSString *filename = [self filenameForIdentifier:identifier timestamp:timestamp];
        
        NSData *data = [CTFileSystemAccess fetchJSONResourceFromDocumentDirectory:filename];
        localizations = [CTCMSJSONParser localizationDictionaryFromLocalizationData:data];
    }
    
    self.localizations[identifier] = localizations ?: @{};
}

- (void)refreshLocalizations {
    for (NSString *identifier in self.localizations.allKeys) {
        [self checkRemoteLocalizationsForIdentifier:identifier];
    }
}

- (void)checkRemoteLocalizationsForIdentifier:(NSString *)identifier {
    NSNumber *cachedTimestamp = [self timestampForIdentifier:identifier inIndex:self.cachedIndex];
    NSNumber *timestamp = [self timestampForIdentifier:identifier inIndex:self.cmsIndex];
    
    BOOL newFileAvailable = timestamp && ![cachedTimestamp isEqual:timestamp];
    BOOL cacheEmpty = timestamp && [self.localizations[identifier] count] == 0;
    
    if (newFileAvailable || cacheEmpty) {
        NSString *filename = [self filenameForIdentifier:identifier timestamp:timestamp];
        
        [CTCMSCommunicator fetchFile:filename withCompletionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
            [CTFileSystemAccess saveJSONResource:data toDocumentDirectory:filename];
            self.localizations[identifier] = [CTCMSJSONParser localizationDictionaryFromLocalizationData:data];
        }];
    }
}

// MARK: Helpers

- (NSString *)timestampForIdentifier:(NSString *)identifier inIndex:(NSDictionary *)index {
    NSArray *products = index[@"products"];
    
    for (NSDictionary *product in products) {
        if ([product[@"product"] isEqualToString:identifier.pathComponents.firstObject]) {
            NSArray *index = product[@"versions"];
            for (NSDictionary *version in index) {
                if ([version[@"name"] isEqualToString:identifier.lastPathComponent]) {
                    return version[@"Timestamp"];
                }
            }
        }
    }
    return nil;
}

- (NSString *)filenameForIdentifier:(NSString *)identifier timestamp:(NSNumber *)timestamp {
    NSString *filename = [identifier stringByAppendingPathComponent:timestamp.stringValue];
    return [filename stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
}

@end
