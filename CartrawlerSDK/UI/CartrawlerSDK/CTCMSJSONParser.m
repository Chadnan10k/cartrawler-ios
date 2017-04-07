//
//  CTCMSJSONParser.m
//  CartrawlerSDK
//
//  Created by Alan on 06/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCMSJSONParser.h"

static NSString *CTCMSJSONParserLanguageKey = @"languageItems";
static NSString *CTCMSJSONParserIndexKey = @"i";
static NSString *CTCMSJSONParserValueKey = @"v";

@implementation CTCMSJSONParser

+ (NSDictionary *)dictionaryFromJSON:(NSData *)data {
    if (!data) {
        return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}

+ (NSDictionary *)localizationDictionaryFromLocalizationData:(NSData *)data {
    NSDictionary *parsedJSON = [self dictionaryFromJSON:data];
    if (parsedJSON) {
        NSMutableDictionary *mutableLocalizations = [NSMutableDictionary new];
        NSArray *languageItems = parsedJSON[CTCMSJSONParserLanguageKey];
        for (NSDictionary *dict in languageItems) {
            [mutableLocalizations setObject:dict[CTCMSJSONParserValueKey] forKey:dict[CTCMSJSONParserIndexKey]];
        }
        return mutableLocalizations.copy;
    }
    return @{};
}

@end
