//
//  CTFileSystemAccess.m
//  CartrawlerSDK
//
//  Created by Alan on 06/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTFileSystemAccess.h"

@implementation CTFileSystemAccess

// MARK: Bundle Access

+ (NSData *)fetchJSONResource:(NSString *)filename fromBundle:(NSBundle *)bundle {
    NSString *filepath = [bundle pathForResource:filename ofType:@"json"];
    return [self resourceAtFilepath:filepath];
}

// MARK: Documents Directory Access

+ (NSData *)fetchJSONResourceFromDocumentDirectory:(NSString *)filename {
    NSString *filepath = [[self documentsFolderPath] stringByAppendingPathComponent:filename];
    filepath = [filepath stringByAppendingPathExtension:@"json"];
    return [self resourceAtFilepath:filepath];
}

+ (void)saveJSONResource:(NSData *)resource toDocumentDirectory:(NSString *)filename {
    NSString *documentsPath = [self documentsFolderPath];
    NSString *filepath = [documentsPath stringByAppendingPathComponent:filename];
    filepath = [filepath stringByAppendingPathExtension:@"json"];
    NSLog(@"%@", filepath);
    [resource writeToFile:filepath atomically:YES];
}

+ (NSString *)documentsFolderPath {
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *carTrawlerDocumentsPath = [documentsPath stringByAppendingPathComponent:@"/CarTrawler"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:carTrawlerDocumentsPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:carTrawlerDocumentsPath withIntermediateDirectories:NO
                                                   attributes:nil error:NULL];
    return carTrawlerDocumentsPath;
}

// MARK: Helpers

+ (NSData *)resourceAtFilepath:(NSString *)filepath {
    return [[NSData alloc] initWithContentsOfFile:filepath];
}

@end
