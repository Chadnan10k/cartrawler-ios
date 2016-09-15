//
//  GTPaymentRequest.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTPaymentRequest : NSObject

+ (NSString *) CT_GroundBook:(NSString *)pickupDateTime
              pickupLatitude:(NSString *)pickupLatitude
             pickupLongitude:(NSString *)pickupLongitude
                addressLine1:(NSString *)addressLine1
                addressLine2:(NSString *)addressLine2
                        town:(NSString *)town
                        city:(NSString *)city
                    postcode:(NSString *)postcode
                 countryCode:(NSString *)countryCode
                 countryName:(NSString *)countryName
          pickupLocationType:(NSString *)pickupLocationType
          pickupLocationName:(NSString *)pickupLocationName
         specialInstructions:(NSString *)specialInstructions
             dropOffdateTime:(NSString *)dropOffdateTime
             dropoffLatitude:(NSString *)dropoffLatitude
            dropoffLongitude:(NSString *)dropoffLongitude
         dropoffLocationType:(NSString *)dropoffLocationType
             airportIsPickup:(BOOL)airportIsPickup
                 airportCode:(NSString *)airportCode
                  terminalNo:(NSString *)terminalNo
                   airlineId:(NSString *)airlineId
                  flightType:(NSString *)flightType
                    flightNo:(NSString *)flightNo
                   firstName:(NSString *)firstName
                     surname:(NSString *)surname
                       phone:(NSString *)phone
        passengerCountryCode:(NSString *)passengerCountryCode
              passengerEmail:(NSString *)passengerEmail
          additionalAdultQty:(NSString *)additionalAdultQty
                 childrenQty:(NSString *)childrenQty
                   infantQty:(NSString *)infantQty
                       refId:(NSString *)refId
                      refUrl:(NSString *)refUrl
                currencyCode:(NSString *)currencyCode
                    clientID:(NSString *)clientID
                      target:(NSString *)target
                      locale:(NSString *)locale
                   ipaddress:(NSString *)ipaddress;

@end
