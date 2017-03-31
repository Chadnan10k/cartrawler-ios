//
//  CTFlightNumberValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 05/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTFlightNumberValidation.h"

@implementation CTFlightNumberValidation

+ (BOOL)isValid:(NSString *)flightNumber
{
    
    if (![self isAlphaNumeric:flightNumber]) {
        return NO;
    }
    
    NSString *flightNo = [[flightNumber componentsSeparatedByCharactersInSet:
                           [NSCharacterSet decimalDigitCharacterSet].invertedSet]
                          componentsJoinedByString:@""];
    
    NSString *airline = [[flightNumber componentsSeparatedByCharactersInSet:
                          [NSCharacterSet letterCharacterSet].invertedSet]
                         componentsJoinedByString:@""];
    
    if ([flightNo length] > 4) {
        return NO;
    }
    
    if (![flightNo isEqualToString:@""] && ![airline isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isAlphaNumeric:(NSString *)str
{
    NSCharacterSet *unwantedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([str rangeOfCharacterFromSet:unwantedCharacters].location == NSNotFound);
}

@end
