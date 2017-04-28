//
//  CTCMSJSONParser.h
//  CartrawlerSDK
//
//  Created by Alan on 06/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCMSJSONParser : NSObject

+ (NSDictionary *)dictionaryFromJSON:(NSData *)data;

+ (NSDictionary *)localizationDictionaryFromLocalizationData:(NSData *)data;

@end
