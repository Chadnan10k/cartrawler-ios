//
//  CT_IpToCountryRQ.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 13/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTErrorResponse.h"
#import "CT_IpToCountryRS.h"

@interface CT_IpToCountryRQ : NSObject

typedef void (^CT_IpToCountryRQCompletion)(CT_IpToCountryRS *response, CTErrorResponse *error);

+ (void)performRequest:(NSString *)requestorID
              currency:(NSString *)currency
          languageCode:(NSString *)languageCode
           countryCode:(NSString *)countryCode
                target:(NSString *)target
              endpoint:(NSString *)endpoint
            completion:(CT_IpToCountryRQCompletion)completion;

@end
