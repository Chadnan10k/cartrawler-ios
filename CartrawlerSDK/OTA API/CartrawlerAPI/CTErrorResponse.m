//
//  ErrorResponse.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 12/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTErrorResponse.h"

@implementation CTErrorResponse

- (instancetype)initWithDictionary:(nullable NSDictionary *)dict;
{
    self = [super init];

    if (dict[@"Errors"] != nil) {

        if ([dict[@"Errors"] isKindOfClass:[NSArray class]]) {
            NSArray *errors = dict[@"Errors"];
            NSDictionary *firstError = errors.firstObject;
            _errorMessage = firstError[@"@ShortText"];
        } else if (dict[@"Errors"][@"Error"]) {
            
            if ([dict[@"Errors"][@"Error"] isKindOfClass:[NSArray class]]) {
                NSArray *errors = dict[@"Errors"][@"Error"];
                NSDictionary *firstError = errors.firstObject;
                _errorMessage = firstError[@"@ShortText"];

            } else {
                
                if (dict[@"Errors"][@"Error"][@"#text"]) {
                    _errorMessage = dict[@"Errors"][@"Error"][@"#text"];
                    _errorMessage = [self.errorMessage stringByReplacingOccurrencesOfString:@"+" withString:@" "];
                } else {
                    _errorMessage = NSLocalizedString(@"Bad Request", @"Bad Request");
                }
            }
        } else {
            _errorMessage = NSLocalizedString(@"Bad Request", @"Bad Request");
        }

    } else if (dict[@"@ErrorMessage"] != nil) {
        _errorMessage = dict[@"@ErrorMessage"];
    } else {
        _errorMessage = NSLocalizedString(@"Bad Request", @"Bad Request");//fail safe
    }

    return self;

}

@end
