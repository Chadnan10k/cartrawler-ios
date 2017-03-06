//
//  CT_IpToCountryRQ.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 13/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CT_IpToCountryRQ.h"
#import "CTPostRequest.h"

@implementation CT_IpToCountryRQ

+ (void)performRequest:(NSString *)requestorID
                currency:(NSString *)currency
            languageCode:(NSString *)languageCode
             countryCode:(NSString *)countryCode
                  target:(NSString *)target
                endpoint:(NSString *)endpoint
              completion:(CT_IpToCountryRQCompletion)completion
{
    NSString *json = [NSString stringWithFormat:
    @"{ \r"
    @"    \"@Target\":\"%@\", \r"
    @"    \"@PrimaryLangID\":\"%@\", \r"
    @"    \"POS\":{ \r"
    @"        \"Source\":[ \r"
    @"                  { \r"
    @"                      \"@ERSP_UserID\":\"MO\", \r"
    @"                      \"@ISOCurrency\":\"%@\", \r"
    @"                      \"RequestorID\":{ \r"
    @"                          \"@Type\":\"16\", \r"
    @"                          \"@ID\":\"%@\",\r "
    @"                          \"@ID_Context\":\"CARTRAWLER\" \r"
    @"                      } \r"
    @"                  } \r"
    @"                  ]\r "
    @"    }, \r"
    @"    \"@xmlns\":\"http://www.cartrawler.com/\",\r "
    @"    \"@Version\":\"1.000\", \r"
    @"    \"DefaultCountry\":\"%@\", \r"
    @"    \"Window\":{ \r"
    @"        \"@name\":\"iOS-V3\",\r "
    @"        \"@engine\":\"iOS-V3\" \r"
    @"    } "
    @"}", target, languageCode, currency, requestorID, countryCode];
    
    CTPostRequest *post = [CTPostRequest new];
    
    [post performRequestWithData:endpoint
                        jsonBody:json
                  loggingEnabled:NO
                      completion:^(NSDictionary *response, CTErrorResponse *error) {
                          CT_IpToCountryRS *res = [[CT_IpToCountryRS alloc] initFromDictionary:response];
                          completion(res, error);
                      }];
}


@end
