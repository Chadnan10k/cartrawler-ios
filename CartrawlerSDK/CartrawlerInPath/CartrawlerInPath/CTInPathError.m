//
//  CTInPathError.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 20/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTInPathError.h"

NSString *const CTInPathErrorDomain = @"com.cartrawler.inpath";
NSString *const CTInPathErrorKey = @"CartrawlerError";

@implementation CTInPathError

+ (NSError *)errorWithType:(CTInPathErrorType)type
{
    switch (type) {
        case CTInPathErrorTypeUnknown:
            return [NSError errorWithDomain:CTInPathErrorDomain
                                             code:1
                                         userInfo:@{CTInPathErrorKey : @"Unknown error, contact Cartrawler developers"}];
        case CTInPathErrorTypeNoPrimaryPassenger:
            return [NSError errorWithDomain:CTInPathErrorDomain
                                             code:1
                                         userInfo:@{CTInPathErrorKey : @"No primary passenger was sent to the In Path library, to fix this at least one CTPassenger must have 'isPrimaryDriver' set to true"}];
    }
}

@end
