//
//  CTBundleLocalization.m
//  CartrawlerSDK
//
//  Created by Alan on 05/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTBundleLocalization.h"
#import "CTFileSystemAccess.h"
#import "CTCMSJSONParser.h"

@interface CTBundleLocalization ()
@property NSMutableDictionary *bundleDictionary;
@end

@implementation CTBundleLocalization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.bundleDictionary = [NSMutableDictionary new];
    }
    return self;
}

- (NSString *)localizedStringForKey:(NSString *)key bundle:(NSBundle *)bundle language:(NSString *)language {
    NSString *identifier = [language stringByAppendingString:[bundle bundleIdentifier]];
    NSDictionary *cache = self.bundleDictionary[identifier];
    if (!cache) {
        cache = [self fetchLocalizationsForLanguage:language fromBundle:bundle];
        [self.bundleDictionary setObject:cache forKey:identifier];
    }
    return cache[key] ?: key;
}

- (NSDictionary *)fetchLocalizationsForLanguage:(NSString *)language fromBundle:(NSBundle *)bundle {
    NSData *data = [CTFileSystemAccess fetchJSONResource:language fromBundle:bundle];
    return [CTCMSJSONParser localizationDictionaryFromLocalizationData:data];
}

@end
