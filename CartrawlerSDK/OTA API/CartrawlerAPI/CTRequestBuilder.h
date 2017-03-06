//
//  CTRequestBuilder.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 14/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTInsurance.h"

@interface CTRequestBuilder : NSObject

+ (NSString *)buildHeader:(NSString *)callType clientID:(NSString *)clientID target:(NSString *)target locale:(NSString *)locale;

+ (NSString *)OTA_VehLocSearchRQCity:(NSString *)cityName
                         countryName:(NSString *)countryName
                            clientID:(NSString *)clientID
                              target:(NSString *)target
                              locale:(NSString *)locale;

+ (NSString *)OTA_VehLocSearchRQAirport:(NSString *)airportCode
                               clientID:(NSString *)clientID
                                 target:(NSString *)target
                                 locale:(NSString *)locale;

+ (NSString *)OTA_VehLocSearchRQCoordinates:(NSString *)latitude
                                  longitude:(NSString *)longitude
                                     radius:(NSString *)radius
                               isUsingMiles:(BOOL)isUsingMiles
                                   clientID:(NSString *)clientID
                                     target:(NSString *)target
                                     locale:(NSString *)locale;

+ (NSString *) CT_VehLocSearchRQPartial:(NSString *)partialText
                               clientID:(NSString *)clientID
                                 target:(NSString *)target
                                 locale:(NSString *)locale
                       needsCoordinates:(BOOL)needsCoordinates;

+ (NSString *) CT_VehLocSearchRQ:(NSString *)pickupLocationCode
                        clientID:(NSString *)clientID
                          target:(NSString *)target
                          locale:(NSString *)locale;

+ (NSString *) OTA_VehAvailRateRQ:(NSString *)pickUpDateTime
                   returnDateTime:(NSString *)returnDateTime
               pickUpLocationCode:(NSString *)pickUpLoactionCode
               returnLocationCode:(NSString *)returnLocationCode
                        driverAge:(NSString *)driverAge
                     passengerQty:(NSString *)passengerQty
                  homeCountryCode:(NSString *)homeCountryCode
                         clientID:(NSString *)clientID
                           target:(NSString *)target
                           locale:(NSString *)locale
                         currency:(NSString *)currency;

+ (NSString *) OTA_VehResRQNoPayment:(NSString *)pickupDateTime
                      returnDateTime:(NSString *)returnDateTime
                  pickupLocationCode:(NSString *)pickupLocationCode
                 dropoffLocationCode:(NSString *)dropoffLocationCode
                         homeCountry:(NSString *)homeCountry
                           driverAge:(NSString *)driverAge
                       numPassengers:(NSString *)numPassengers
                        flightNumber:(NSString *)flightNumber
                               refID:(NSString *)refID
                        refTimeStamp:(NSString *)refTimeStamp
                              refURL:(NSString *)refURL
                         extrasArray:(NSArray *)extrasArray
                          namePrefix:(NSString *)namePrefix
                           givenName:(NSString *)givenName
                             surName:(NSString *)surName
                        emailAddress:(NSString *)emailAddress
                             address:(NSString *)address
                         phoneNumber:(NSString *)phoneNumber
                            clientID:(NSString *)clientID
                              target:(NSString *)target
                              locale:(NSString *)locale;

+ (NSString *) OTA_VehResRQ:(NSString *)pickupDateTime
             returnDateTime:(NSString *)returnDateTime
         pickupLocationCode:(NSString *)pickupLocationCode
        dropoffLocationCode:(NSString *)dropoffLocationCode
                homeCountry:(NSString *)homeCountry
                  driverAge:(NSString *)driverAge
              numPassengers:(NSString *)numPassengers
               flightNumber:(NSString *)flightNumber
                      refID:(NSString *)refID
               refTimeStamp:(NSString *)refTimeStamp
                     refURL:(NSString *)refURL
                extrasArray:(NSArray *)extrasArray
                  givenName:(NSString *)givenName
                    surName:(NSString *)surName
               emailAddress:(NSString *)emailAddress
                    address:(NSString *)address
                phoneNumber:(NSString *)phoneNumber
                   cardType:(NSString *)cardType
                 cardNumber:(NSString *)cardNumber
             cardExpireDate:(NSString *)cardExpireDate
             cardHolderName:(NSString *)cardHolderName
              cardCCVNumber:(NSString *)cardCCVNumber
            insuranceObject:(CTInsurance *)ins
          isBuyingInsurance:(BOOL)isBuyingInsurance
                   clientID:(NSString *)clientID
                     target:(NSString *)target
                     locale:(NSString *)locale
                   currency:(NSString *)currency;

+ (NSString *) CT_VehEmailRQ:(NSString *)bookingRef
                emailAddress:(NSString *)emailAddress
                    clientID:(NSString *)clientID
                      target:(NSString *)target
                      locale:(NSString *)locale;

+ (NSString *) OTA_InsuranceDetailsRQ:(NSString *)totalCost
                          homeCountry:(NSString *)homeCountry
                       activeCurrency:(NSString *)activeCurrency
                       pickupDateTime:(NSDate *)pickupDateTime
                      dropOffDateTime:(NSDate *)dropOffDateTime
               destinationCountryCode:(NSString *)destinationCountryCode
                             clientID:(NSString *)clientID
                               target:(NSString *)target
                               locale:(NSString *)locale
                                refID:(NSString *)refID
                               refURL:(NSString *)refURL
                         refTimeStamp:(NSString *)refTimeStamp;

+ (NSString *) OTA_VehRetResRQ:(NSString *)bookingEmailAddress
                  bookingRefID:(NSString *)bookingRefID
                      clientID:(NSString *)clientID
                        target:(NSString *)target
                        locale:(NSString *)locale;

+ (NSString *) CT_RentalConditionsRQ:(NSString *)puDateTime
                          doDateTime:(NSString *)doDateTime
                      puLocationCode:(NSString *)puLocationCode
                      doLocationCode:(NSString *)doLocationCode
                         homeCountry:(NSString *)homeCountry
                             refType:(NSString *)refType
                               refID:(NSString *)refID
                        refIDContext:(NSString *)refIDContext
                              refURL:(NSString *)refURL
                            clientID:(NSString *)clientID
                              target:(NSString *)target
                              locale:(NSString *)locale;


+ (NSString *) CT_VehCancelRQ:(NSString *)bookingRef
                        title:(NSString *)title
                    firstName:(NSString *)firstName
                      surname:(NSString *)surname
                   puDateTime:(NSString *)puDateTime
                   doDateTime:(NSString *)doDateTime
               puLocationCode:(NSString *)puLocationCode
               doLocationCode:(NSString *)doLocationCode
                     clientID:(NSString *)clientID
                       target:(NSString *)target
                       locale:(NSString *)locale;

+ (NSString *) CT_GroundAvail:(NSString *)puDateTime
                   doDateTime:(NSString *)doDateTime
                        puLat:(NSString *)puLat
                       puLong:(NSString *)puLong
                        doLat:(NSString *)doLat
                       doLong:(NSString *)doLong
               puLocationType:(NSString *)puLocationType
               doLocationType:(NSString *)doLocationType
      airportIsPickupLocation:(BOOL)airportIsPickupLocation
                   flightType:(NSString *)flightType
                  airportCode:(NSString *)airportCode
                   terminalNo:(NSString *)terminalNo
                       adults:(NSString *)adults
                     children:(NSString *)children
                      infants:(NSString *)infants
                      seniors:(NSString *)seniors
                 currencyCode:(NSString *)currencyCode
                     clientID:(NSString *)clientID
                       target:(NSString *)target
                       locale:(NSString *)locale
                    ipaddress:(NSString *)ipaddress
                  countryCode:(NSString *)countryCode;

+ (NSString *) CT_GroundBook:(NSString *)pickupDateTime
              pickupLatitude:(NSString *)pickupLatitude
             pickupLongitude:(NSString *)pickupLongitude
                addressLine1:(NSString *)addressLine1
                addressLine2:(NSString *)addressLine2
                        town:(NSString *)town
                        city:(NSString *)city
                    postcode:(NSString *)postcode
              stateProvience:(NSString *)stateProvience
                 countryCode:(NSString *)countryCode
                 countryName:(NSString *)countryName
          pickupLocationType:(NSString *)pickupLocationType
          pickupLocationName:(NSString *)pickupLocationName
         specialInstructions:(NSString *)specialInstructions
             dropOffdateTime:(NSString *)dropOffdateTime
             dropoffLatitude:(NSString *)dropoffLatitude
            dropoffLongitude:(NSString *)dropoffLongitude
         dropoffLocationType:(NSString *)dropoffLocationType
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
