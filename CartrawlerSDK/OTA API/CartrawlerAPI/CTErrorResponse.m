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
    //TODO: this is a bit rough, clean up
    if (dict[@"Errors"] != nil) {
        
        if ([dict[@"Errors"][@"Error"] isKindOfClass:[NSArray class]]) {
            NSDictionary *err = dict[@"Errors"][@"Error"];
            
            if ([err isKindOfClass:[NSArray class]]) {
                NSArray *errors = dict[@"Errors"][@"Error"];
                NSDictionary *firstError = errors.firstObject;
                _errorMessage = firstError[@"@ShortText"];
            }

        } else {
            _errorMessage = dict[@"Errors"][@"Error"][@"@ShortText"];
        }

    } else if (dict[@"@ErrorMessage"] != nil) {
        _errorMessage = dict[@"@ErrorMessage"];
    } else {
        _errorMessage = NSLocalizedString(@"Bad Request", @"Bad Request");//fail safe
    }

    return self;

}

@end
