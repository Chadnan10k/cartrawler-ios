//
//  CTFileSystemAccess.h
//  CartrawlerSDK
//
//  Created by Alan on 06/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFileSystemAccess : NSObject

+ (NSData *)fetchJSONResource:(NSString *)filename fromBundle:(NSBundle *)bundle;

+ (NSData *)fetchJSONResourceFromDocumentDirectory:(NSString *)filename;

+ (void)saveJSONResource:(NSData *)resource toDocumentDirectory:(NSString *)filename;

@end
