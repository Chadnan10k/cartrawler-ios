//
//  PaymentRequest.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentRequest.h"

@implementation PaymentRequest

+ (NSString *)payload
{
    
    NSString *json =
    
     @"     \"@xmlns\":\"http://www.opentravel.org/OTA/2003/05\",   "
     @"      \"@Target\":\"Test\",                                  "
     @"      \"@Version\":\"1.000\",                                "
     @"      \"POS\":{                                              "
     @"             \"Source\":{                                    "
     @"                    \"@ISOCurrency\":\"GBP\",                "
     @"                    \"RequestorID\":{                        "
     @"                           \"@Type\":\"16\",                 "
     @"                           \"@ID\":\"502726\",               "
     @"                           \"@ID_Context\":\"CARTRAWLER\"    "
     @"                        }                                    "
     @"                 }                                           "
     @"          },                                                 "
     @"      \"VehResRQCore\":{                                     "
     @"             \"@Status\":\"All\","
     @"             \"VehRentalCore\":{"
     @"                    \"@PickUpDateTime\":\"2016-10-28T08:40:00Z\","
     @"                    \"@ReturnDateTime\":\"2016-11-01T09:35:00Z\","
     @"                    \"PickUpLocation\":{"
     @"                           \"@CodeContext\":\"IATA\","
     @"                           \"@LocationCode\":\"IST\""
     @"                        },"
     @"                    \"ReturnLocation\":{"
     @"                           \"@CodeContext\":\"IATA\","
     @"                           \"@LocationCode\":\"IST\""
     @"                        }"
     @"                 },"
     @"             \"Customer\":{"
     @"                    \"Primary\":{"
     @"                           \"PersonName\":{"
     @"                                  \"NamePrefix\":\"Mr.\","
     @"                                  \"GivenName\":\"Jim\","
     @"                                  \"Surname\":\"Carr\""
     @"                               },"
     @"                           \"Telephone\":{"
     @"                                  \"@PhoneTechType\":\"1\","
     @"                                  \"@PhoneNumber\":\"3537788581828\""
     @"                               },"
     @"                           \"Email\":{"
     @"                                  \"@EmailType\":\"2\","
     @"                                  \"#text\":\"jcarr@cartrawler.com\""
     @"                               },"
     @"                           \"Address\":{"
     @"                                  \"@Type\":\"2\","
     @"                                  \"AddressLine\":\"Classon Hse, Dublin 14\","
     @"                                  \"CountryName\":{"
     @"                                         \"@Code\":\"GB\""
     @"                                      }"
     @"                               },"
     @"                           \"CitizenCountryName\":{"
     @"                                  \"@Code\":\"GB\""
     @"                               }"
     @"                        }"
     @"                 },"
     @"             \"DriverType\":{"
     @"                    \"@Age\":\"50\""
     @"                 }"
     @"          },"
     @"      \"VehResRQInfo\":{"
     @"             \"ArrivalDetails\":{"
     @"                    \"@TransportationCode\":\"14\","
     @"                    \"@Number\":\"711\","
     @"                    \"OperatingCompany\":\"PS\""
     @"                 },"
     @"             \"RentalPaymentPref\":{"
     @"                    \"PaymentCard\":{"
     @"                           \"@CardType\":\"1\","
     @"                           \"@CardCode\":\"CARD_TYPE\","
     @"                           \"@CardNumber\":\"CARD_NUMBER\","
     @"                           \"@ExpireDate\":\"EXPIRE_DATE\","
     @"                           \"@SeriesCode\":\"SERIES_CODE\","
     @"                           \"CardHolderName\":\"CARD_HOLDER\""
     @"                        }"
     @"                 },"
     @"             \"Reference\":{"
     @"                    \"@Type\":\"16\","
     @"                    \"@ID\":\"303:1395:24042:5384\","
     @"                    \"@ID_Context\":\"CARTRAWLER\""
     @"                 }"
     @"   }"
     @"   }";
    
    return json;
}

@end
