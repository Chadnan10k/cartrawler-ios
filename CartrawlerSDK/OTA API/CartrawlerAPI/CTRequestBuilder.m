//
//  CTRequestBuilder.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 14/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTRequestBuilder.h"
#import "Constants.h"
#import "NSDateUtils.h"
#import "NSDataUtils.h"
#import "CTExtraEquipment.h"
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>

@implementation CTRequestBuilder

+ (NSString *)buildHeader:(NSString *)callType clientID:(NSString *)clientID target:(NSString *)target locale:(NSString *)locale {
        
    if ([callType isEqualToString:CTHeader]) {
        
        return [NSString stringWithFormat:@"\"@xmlns\":\"http://www.opentravel.org/OTA/2003/05\",\"@xmlns:xsi\": \"http://www.w3.org/2001/XMLSchema-instance\",\"@Version\": \"1.005\",\"@Target\": \"%@\",\"@PrimaryLangID\": \"%@\",\"POS\": {\"Source\": {\"RequestorID\": {\"@Type\": \"16\",\"@ID\": \"%@\",\"@ID_Context\": \"CARTRAWLER\"}}},", target, locale, clientID];
        
    } else if ([callType isEqualToString:CTMobileHeader]) {
        
        return [NSString stringWithFormat:@"\"@xmlns\":\"http://www.opentravel.org/OTA/2003/05\",\"@xmlns:xsi\": \"http://www.w3.org/2001/XMLSchema-instance\",\"@Version\": \"1.005\",\"@Target\": \"%@\",\"POS\": {\"Source\": {\"@ERSP_UserID\": \"MO\",\"RequestorID\": {\"@Type\": \"16\",\"@ID\": \"%@\",\"@ID_Context\": \"CARTRAWLER\"}}},", target, clientID];
        
    } else if ([callType isEqualToString:CTInsuranceHeader]) {
        
        return [NSString stringWithFormat:@"\"@xmlns\":\"http://www.opentravel.org/OTA/2003/05\",\"@Version\": \"1.002\",\"@Target\": \"%@\",\"@PrimaryLangID\": \"EN\",\"POS\": {\"Source\": {\"@ISOCurrency\": \"GBP\",\"RequestorID\": {\"@Type\": \"16\",\"@ID\": \"%@\",\"@ID_Context\": \"CARTRAWLER\"}}},", target, clientID];
        
    } else if ([callType isEqualToString:CTCancelHeader]) {
        
        return [NSString stringWithFormat:@"\"@xmlns\":\"http://www.opentravel.org/OTA/2003/05\",\"@xmlns:xsi\": \"http://www.w3.org/2001/XMLSchema-instance\",\"@Version\": \"1.007\",\"@Target\": \"%@\",\"POS\": {\"Source\": {\"@ERSP_UserID\": \"MO\",\"RequestorID\": {\"@Type\": \"16\",\"@ID\": \"%@\",\"@ID_Context\": \"CARTRAWLER\"}}},", target, clientID];
        
    } else if ([callType isEqualToString:CTRentalReqHeader]) {
        
        return [NSString stringWithFormat:@"\"@xmlns\":\"http://www.opentravel.org/OTA/2003/05\",\"@xmlns:xsi\": \"http://www.w3.org/2001/XMLSchema-instance\",\"@Version\": \"1.000\",\"@Target\": \"%@\",\"POS\": {\"Source\": {\"@ERSP_UserID\": \"MO\",\"RequestorID\": {\"@Type\": \"16\",\"@ID\": \"%@\",\"@ID_Context\": \"CARTRAWLER\"}}},", target, clientID];
        
    } else if ([callType isEqualToString:CTGetExistingBookingHeader]) {
        
        return [NSString stringWithFormat:@"\"@xmlns\":\"http://www.opentravel.org/OTA/2003/05\",\"@xmlns:xsi\": \"http://www.w3.org/2001/XMLSchema-instance\",\"@Version\": \"1.002\",\"@Target\": \"%@\",\"@PrimaryLangID\": \"EN\",\"POS\": {\"Source\": {\"RequestorID\": {\"@Type\": \"16\",\"@ID\": \"%@\",\"@ID_Context\": \"CARTRAWLER\"}}},", target, clientID];
        
    } else if ([callType isEqualToString:CTLocationSearchHeader]) {
        return [NSString stringWithFormat:@"\"@xmlns\":\"http://www.cartrawler.com/\",\"@Version\": \"1.000\",\"@Target\": \"%@\",\"@PrimaryLangID\": \"%@\",\"POS\": {\"Source\": { \"RequestorID\": {\"@Type\": \"16\",\"@ID\": \"%@\",\"@ID_Context\": \"CARTRAWLER\"}}},", target, locale, clientID];
        
    } else if ([callType isEqualToString:CTLocationGTSearchHeader]) {
        return [NSString stringWithFormat:@"\"@xmlns\":\"http://www.cartrawler.com/\",\"@Version\": \"1.000\",\"@Target\": \"%@\",\"@PrimaryLangID\": \"%@\",\"POS\": {\"Source\": { \"@ERSP_UserID\" : \"MP\", \"RequestorID\": {\"@Type\": \"16\",\"@ID\": \"%@\",\"@ID_Context\": \"CARTRAWLER\"}}},", target, locale, clientID];
        
    } else {
        return @"";
    }
}

+ (NSString *)currencyHeader:(NSString *)clientID target:(NSString *)target locale:(NSString *)locale currency:(NSString *)currency
{
    return [NSString stringWithFormat:@"\"@xmlns\":\"http://www.opentravel.org/OTA/2003/05\",\"@Version\": \"1.002\",\"@Target\": \"%@\",\"@PrimaryLangID\": \"%@\",\"POS\": {\"Source\": {\"@ISOCurrency\": \"%@\",\"RequestorID\": {\"@Type\": \"16\",\"@ID\": \"%@\",\"@ID_Context\": \"CARTRAWLER\"}}},", target, locale, currency, clientID];
}

+ (NSString *)groundTransportHeader:(NSString *)clientID target:(NSString *)target locale:(NSString *)locale currency:(NSString *)currency
{
    return [NSString stringWithFormat:@"\"@xmlns\":\"http://www.opentravel.org/OTA/2003/05\",\"@Version\": \"1.002\",\"@Target\": \"%@\",\"@PrimaryLangID\": \"%@\",\"POS\": {\"Source\": {\"@ISOCurrency\": \"%@\",\"RequestorID\": {\"@Type\": \"16\",\"@ID\": \"%@\",\"@ID_Context\": \"CARTRAWLER\"}}},", target, locale, currency, clientID];
}

+ (NSString *) stringToSha1:(NSString *)str {
    NSData *dataToHash = [str dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char hashBytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(dataToHash.bytes, (CC_LONG)dataToHash.length, hashBytes);
    NSData *encodedData = [NSData dataWithBytes:hashBytes length:CC_SHA1_DIGEST_LENGTH];
    return [NSDataUtils hexadecimalString: encodedData];
}

+ (NSString *)tpaExtenstionContruct:(NSString *)clientID {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyyMMddHHmmss";
    NSDate *now = [NSDate date];
    NSString *dateString = [format stringFromDate:now];
        
    NSString *stringTobeHashed = [NSString stringWithFormat:@"%@.%@.%@", [self stringToSha1:[UIDevice currentDevice].identifierForVendor.UUIDString], dateString, clientID];
    NSString *stringTwo = [NSString stringWithFormat:@"%@.cartrawler", [self stringToSha1:stringTobeHashed]];
    
    return [NSString stringWithFormat:@"\"TPA_Extensions\": {\"ConsumerSignature\":{\"@ID\": \"%@\",\"@Hash\": \"%@\",\"@Stamp\": \"%@\"}}}", [self stringToSha1:[UIDevice currentDevice].identifierForVendor.UUIDString], [self stringToSha1:stringTwo], dateString];
}

+ (NSString *)OTA_VehLocSearchRQCity:(NSString *)cityName
                         countryName:(NSString *)countryName
                            clientID:(NSString *)clientID
                              target:(NSString *)target
                              locale:(NSString *)locale
{
    NSString *tail = [NSString stringWithFormat: @"\"VehLocSearchCriterion\": { \n"
                   " \"@ExactMatch\": \"true\", \n"
                   " \"@ImportanceType\": \"Mandatory\", \n"
                   " \"Address\": {  \n"
                      "  \"CityName\": \"%@\", \n"
                      "  \"CountryName\": {\"@Code\": \"%@\"} \n"
                      "  } \n"
                   "  } ", cityName, countryName];
    
    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder buildHeader:CTHeader clientID:clientID target:target locale:locale], tail];
}

+ (NSString *)OTA_VehLocSearchRQAirport:(NSString *)airportCode
                               clientID:(NSString *)clientID
                                 target:(NSString *)target
                                 locale:(NSString *)locale
{
    NSString *tail = [NSString stringWithFormat: @"  \"VehLocSearchCriterion\": { \n"
                       " \"@ExactMatch\": \"true\", \n"
                       " \"@ImportanceType\": \"Mandatory\", \n"
                       "  \"RefPoint\": \"%@\" \n"
                       " } ", airportCode];
    
    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder buildHeader:CTHeader clientID:clientID target:target locale:locale], tail];
}

+ (NSString *)OTA_VehLocSearchRQCoordinates:(NSString *)latitude
                                  longitude:(NSString *)longitude
                                     radius:(NSString *)radius
                               isUsingMiles:(BOOL)isUsingMiles
                                   clientID:(NSString *)clientID
                                     target:(NSString *)target
                                     locale:(NSString *)locale
{
    
    NSString *distanceUnit;
    
    if (isUsingMiles) {
        distanceUnit = @"miles";
    } else {
        distanceUnit = @"km";
    }

    NSString *tail = [NSString stringWithFormat: @" \"VehLocSearchCriterion\": { \n"
                  "      \"@ExactMatch\": \"true\", \n"
                  "  \"@ImportanceType\": \"Mandatory\", \n"
                  "      \"Position\": { \n"
                  "      \"@Latitude\": \"%@\", \n"
                 "       \"@Longitude\": \"%@\" \n"
                 "   }, \n"
                 "   \"Radius\": { \n"
                 "       \"@Distance\": \"%@\", \n"
                 "       \"@DistanceMeasure\": \"%@\" \n"
                 "   } \n"
              "  } ", latitude, longitude, radius, distanceUnit];

    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder buildHeader:CTHeader clientID:clientID target:target locale:locale], tail];
}

+ (NSString *) CT_VehLocSearchRQ:(NSString *)pickupLocationCode
                        clientID:(NSString *)clientID
                          target:(NSString *)target
                          locale:(NSString *)locale
{
    NSString *tail = [NSString stringWithFormat:@"\"VehLocSearchCriterion\":{\"@ExactMatch\":\"true\",\"@ImportanceType\":\"Mandatory\",\"PickupLocation\":{\"@ID\":\"%@\",\"@ID_Context\":\"CARTRAWLER\"}}", pickupLocationCode];
    
    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder buildHeader:CTHeader clientID:clientID target:target locale:locale], tail];

}

+ (NSString *) CT_VehLocSearchRQPartial:(NSString *)partialText
                               clientID:(NSString *)clientID
                                 target:(NSString *)target
                                 locale:(NSString *)locale
                       needsCoordinates:(BOOL)needsCoordinates
{
    NSString *tail = [NSString stringWithFormat:@"\"VehLocSearchCriterion\":{\"@ExactMatch\":\"true\",\"@ImportanceType\":\"Mandatory\",\"PartialText\":{\"@Size\":\"10\",\"#text\":\"%@\"}}", partialText];
    
    if (needsCoordinates) {
        return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder buildHeader:CTLocationGTSearchHeader clientID:clientID target:target locale:locale], tail];
    } else {
        return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder buildHeader:CTLocationSearchHeader clientID:clientID target:target locale:locale], tail];
    }
}

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
                         currency:(NSString *)currency
{
    
    NSString *tail = [NSString stringWithFormat:@"\"VehAvailRQCore\":{\"@Status\":\"Available\",\"VehRentalCore\":{\"@PickUpDateTime\":\"%@\",\"@ReturnDateTime\":\"%@\",\"PickUpLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"},\"ReturnLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"}},\"DriverType\":{\"@Age\":\"%@\"}},\"VehAvailRQInfo\":{\"@PassengerQty\":\"%@\",\"Customer\":{\"Primary\":{\"CitizenCountryName\":{\"@Code\":\"%@\"}}},%@", pickUpDateTime, returnDateTime, pickUpLoactionCode, returnLocationCode, driverAge, passengerQty, homeCountryCode, [CTRequestBuilder tpaExtenstionContruct:clientID]];
    
    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder currencyHeader:clientID target:target locale:locale currency:currency], tail];
}

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
                   currency:(NSString *)currency

{
    
    NSString *extrasString = @"";
    NSString *tail = @"";
    NSMutableArray *validExtras = [[NSMutableArray alloc] init];
    
    for (CTExtraEquipment *e in extrasArray) {
        if (e.qty > 0) {
            [validExtras addObject:e];
        }
    }

    if (validExtras.count > 0) {

        extrasString = [extrasString stringByAppendingString:@",\"SpecialEquipPrefs\":{\"SpecialEquipPref\":["];
        for (int i = 0; i < validExtras.count; i++) {
            CTExtraEquipment *e = (CTExtraEquipment *)validExtras[i];
            if (e.qty != 0) {
                extrasString = [extrasString stringByAppendingString:[NSString stringWithFormat:@"{\"@EquipType\":\"%li\",\"@Quantity\":\"%li\"}", (long)(e.equipType).integerValue, (long)e.qty]];
                if (validExtras.count > 1) {
                    if ((i + 1) != (validExtras.count)) {
                        extrasString = [extrasString stringByAppendingString:@","];
                    }
                }
            }
        }
        extrasString = [extrasString stringByAppendingString:@"]}"];
    } else {
        extrasString = @"";
    }
    
    NSString *paymentExtension = @"";
    
    if (![cardNumber isEqualToString:@""]) {
       paymentExtension  = [NSString stringWithFormat:@"\"RentalPaymentPref\":{\"PaymentCard\":{\"@CardType\":\"1\",\"@CardCode\":\"%@\",\"@CardNumber\":\"%@\",\"@ExpireDate\":\"%@\",\"@SeriesCode\":\"%@\",\"CardHolderName\":\"%@\"}},", cardType, cardNumber, cardExpireDate, cardCCVNumber, cardHolderName];
    }

    if (flightNumber != nil && flightNumber.length > 2) {
        NSString *flightNumberPrefixString = [flightNumber substringToIndex:2];
        NSString *flightNumberString = [flightNumber substringFromIndex:2];
        
        if (isBuyingInsurance) {
            // Tested, this works.
            tail = [NSString stringWithFormat:@"\"VehResRQCore\":{\"@Status\":\"All\",\"VehRentalCore\":{\"@PickUpDateTime\":\"%@\",\"@ReturnDateTime\":\"%@\",\"PickUpLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"},\"ReturnLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"}},\"Customer\":{\"Primary\":{\"PersonName\":{\"GivenName\":\"%@\",\"Surname\":\"%@\"},\"Telephone\":{\"@PhoneTechType\":\"1\",\"@PhoneNumber\":\"%@\"},\"Email\":{\"@EmailType\":\"2\",\"#text\":\"%@\"},\"Address\":{\"@Type\":\"2\",\"AddressLine\":\"%@\",\"CountryName\":{\"@Code\":\"%@\"}},\"CitizenCountryName\":{\"@Code\":\"%@\"}}},\"DriverType\":{\"@Age\":\"%@\"}%@},\"VehResRQInfo\":{\"@PassengerQty\":\"%@\",\"ArrivalDetails\":{\"@TransportationCode\":\"14\",\"@Number\":\"%@\",\"OperatingCompany\":\"%@\"},%@\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"CARTRAWLER\",\"@DateTime\":\"%@\",\"@URL\":\"%@\"},\"TPA_Extensions\":{\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"INSURANCE\",\"@Amount\":\"%@\",\"@CurrencyCode\":\"%@\",\"@URL\":\"%@\"}}}" ,pickupDateTime, returnDateTime, pickupLocationCode, dropoffLocationCode, givenName, surName, phoneNumber, emailAddress, address, homeCountry, homeCountry, driverAge, extrasString, numPassengers, flightNumberString, flightNumberPrefixString, paymentExtension, refID, refTimeStamp, refURL, ins.planID, ins.premiumAmount, ins.premiumCurrencyCode, ins.termsAndConditionsURL];
        }
        else {
            // Tested this works.
            tail = [NSString stringWithFormat:@"\"VehResRQCore\":{\"@Status\":\"All\",\"VehRentalCore\":{\"@PickUpDateTime\":\"%@\",\"@ReturnDateTime\":\"%@\",\"PickUpLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"},\"ReturnLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"}},\"Customer\":{\"Primary\":{\"PersonName\":{\"GivenName\":\"%@\",\"Surname\":\"%@\"},\"Telephone\":{\"@PhoneTechType\":\"1\",\"@PhoneNumber\":\"%@\"},\"Email\":{\"@EmailType\":\"2\",\"#text\":\"%@\"},\"Address\":{\"@Type\":\"2\",\"AddressLine\":\"%@\",\"CountryName\":{\"@Code\":\"%@\"}},\"CitizenCountryName\":{\"@Code\":\"%@\"}}},\"DriverType\":{\"@Age\":\"%@\"}%@},\"VehResRQInfo\":{\"@PassengerQty\":\"%@\",\"ArrivalDetails\":{\"@TransportationCode\":\"14\",\"@Number\":\"%@\",\"OperatingCompany\":\"%@\"},%@\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"CARTRAWLER\",\"@DateTime\":\"%@\",\"@URL\":\"%@\"}}" ,pickupDateTime, returnDateTime, pickupLocationCode, dropoffLocationCode, givenName, surName, phoneNumber, emailAddress, address, homeCountry, homeCountry, driverAge, extrasString, numPassengers, flightNumberString, flightNumberPrefixString, paymentExtension, refID, refTimeStamp, refURL];
        }
    } else {
        // There isn't a flight number
        if (isBuyingInsurance) {
            // Tested, this works.
            tail = [NSString stringWithFormat:@"\"VehResRQCore\":{\"@Status\":\"All\",\"VehRentalCore\":{\"@PickUpDateTime\":\"%@\",\"@ReturnDateTime\":\"%@\",\"PickUpLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"},\"ReturnLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"}},\"Customer\":{\"Primary\":{\"PersonName\":{\"GivenName\":\"%@\",\"Surname\":\"%@\"},\"Telephone\":{\"@PhoneTechType\":\"1\",\"@PhoneNumber\":\"%@\"},\"Email\":{\"@EmailType\":\"2\",\"#text\":\"%@\"},\"Address\":{\"@Type\":\"2\",\"AddressLine\":\"%@\",\"CountryName\":{\"@Code\":\"%@\"}},\"CitizenCountryName\":{\"@Code\":\"%@\"}}},\"DriverType\":{\"@Age\":\"%@\"}%@},\"VehResRQInfo\":{\"@PassengerQty\":\"%@\",%@\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"CARTRAWLER\",\"@DateTime\":\"%@\",\"@URL\":\"%@\"},\"TPA_Extensions\":{\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"INSURANCE\",\"@Amount\":\"%@\",\"@CurrencyCode\":\"%@\",\"@URL\":\"%@\"}}}" ,pickupDateTime, returnDateTime, pickupLocationCode, dropoffLocationCode, givenName, surName, phoneNumber, emailAddress, address, homeCountry, homeCountry, driverAge, extrasString, numPassengers, paymentExtension, refID, refTimeStamp, refURL, ins.planID, ins.premiumAmount, ins.premiumCurrencyCode, ins.termsAndConditionsURL];
        } else {
            // Tested, this works.
            tail = [NSString stringWithFormat:@"\"VehResRQCore\":{\"@Status\":\"All\",\"VehRentalCore\":{\"@PickUpDateTime\":\"%@\",\"@ReturnDateTime\":\"%@\",\"PickUpLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"},\"ReturnLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"}},\"Customer\":{\"Primary\":{\"PersonName\":{\"GivenName\":\"%@\",\"Surname\":\"%@\"},\"Telephone\":{\"@PhoneTechType\":\"1\",\"@PhoneNumber\":\"%@\"},\"Email\":{\"@EmailType\":\"2\",\"#text\":\"%@\"},\"Address\":{\"@Type\":\"2\",\"AddressLine\":\"%@\",\"CountryName\":{\"@Code\":\"%@\"}},\"CitizenCountryName\":{\"@Code\":\"%@\"}}},\"DriverType\":{\"@Age\":\"%@\"}%@},\"VehResRQInfo\":{\"@PassengerQty\":\"%@\",%@\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"CARTRAWLER\",\"@DateTime\":\"%@\",\"@URL\":\"%@\"}}" ,pickupDateTime, returnDateTime, pickupLocationCode, dropoffLocationCode, givenName, surName, phoneNumber, emailAddress, address, homeCountry, homeCountry, driverAge, extrasString, numPassengers, paymentExtension, refID, refTimeStamp, refURL];
        }
    }
    
    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder currencyHeader:clientID target:target locale:locale currency:currency], tail];
}

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
                              locale:(NSString *)locale
{
    NSString *extrasString = @"";
    NSString *tail = @"";
    NSMutableArray *validExtras = [[NSMutableArray alloc] init];
    
    for (CTExtraEquipment *e in extrasArray) {
        if (e.qty > 0) {
            [validExtras addObject:e];
        }
    }
    
    if (validExtras.count > 0) {
        extrasString = [extrasString stringByAppendingString:@",\"SpecialEquipPrefs\":{\"SpecialEquipPref\":["];
        for (int i = 0; i < validExtras.count; i++) {
            CTExtraEquipment *e = (CTExtraEquipment *)validExtras[i];
            if (e.qty != 0) {
                extrasString = [extrasString stringByAppendingString:[NSString stringWithFormat:@"{\"@EquipType\":\"%li\",\"@Quantity\":\"%li\"}", (long)(e.equipType).integerValue, (long)e.qty]];
                if (validExtras.count > 1) {
                    if ((i + 1) != (validExtras.count)) {
                        extrasString = [extrasString stringByAppendingString:@","];
                    }
                }
            }
        }
        extrasString = [extrasString stringByAppendingString:@"]}"];
    } else {
        extrasString = @"";
    }
    
    if (flightNumber != nil && flightNumber.length > 2) {
        
        NSString *flightNumberPrefixString = [flightNumber substringToIndex:2];
        NSString *flightNumberString = [flightNumber substringFromIndex:2];
        // Tested, this works.
        tail = [NSString stringWithFormat:@"\"VehResRQCore\":{\"@Status\":\"All\",\"VehRentalCore\":{\"@PickUpDateTime\":\"%@\",\"@ReturnDateTime\":\"%@\",\"PickUpLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"},\"ReturnLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"}},\"Customer\":{\"Primary\":{\"PersonName\":{\"NamePrefix\":\"%@\",\"GivenName\":\"%@\",\"Surname\":\"%@\"},\"Telephone\":{\"@PhoneTechType\":\"1\",\"@AreaCityCode\":\"0\",\"@PhoneNumber\":\"%@\"},\"Email\":{\"@EmailType\":\"2\",\"#text\":\"%@\"},\"Address\":{\"@Type\":\"2\",\"AddressLine\":\"%@\",\"CountryName\":{\"@Code\":\"%@\"}},\"CitizenCountryName\":{\"@Code\":\"%@\"}}},\"DriverType\":{\"@Age\":\"%@\"}%@},\"VehResRQInfo\":{\"@PassengerQty\":\"%@\",\"ArrivalDetails\":{\"@TransportationCode\":\"14\",\"@Number\":\"%@\",\"OperatingCompany\":\"%@\"},\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"CARTRAWLER\",\"@DateTime\":\"%@\",\"@URL\":\"%@\"}}" ,pickupDateTime, returnDateTime, pickupLocationCode, dropoffLocationCode, namePrefix, givenName, surName, phoneNumber, emailAddress, address, homeCountry, homeCountry, driverAge, extrasString, numPassengers, flightNumberString, flightNumberPrefixString, refID, refTimeStamp, refURL];
    } else {
        // Tested, this works.
        tail = [NSString stringWithFormat:@"\"VehResRQCore\":{\"@Status\":\"All\",\"VehRentalCore\":{\"@PickUpDateTime\":\"%@\",\"@ReturnDateTime\":\"%@\",\"PickUpLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"},\"ReturnLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"}},\"Customer\":{\"Primary\":{\"PersonName\":{\"NamePrefix\":\"%@\",\"GivenName\":\"%@\",\"Surname\":\"%@\"},\"Telephone\":{\"@PhoneTechType\":\"1\",\"@AreaCityCode\":\"0\",\"@PhoneNumber\":\"%@\"},\"Email\":{\"@EmailType\":\"2\",\"#text\":\"%@\"},\"Address\":{\"@Type\":\"2\",\"AddressLine\":\"%@\",\"CountryName\":{\"@Code\":\"%@\"}},\"CitizenCountryName\":{\"@Code\":\"%@\"}}},\"DriverType\":{\"@Age\":\"%@\"}%@},\"VehResRQInfo\":{\"@PassengerQty\":\"%@\",\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"CARTRAWLER\",\"@DateTime\":\"%@\",\"@URL\":\"%@\"}}",pickupDateTime, returnDateTime, pickupLocationCode, dropoffLocationCode, namePrefix, givenName, surName, phoneNumber, emailAddress, address, homeCountry, homeCountry, driverAge, extrasString, numPassengers, refID, refTimeStamp, refURL];
    }
    
    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder buildHeader:CTHeader clientID:clientID target:target locale:locale], tail];
}

+ (NSString *) CT_VehEmailRQ:(NSString *)bookingRef
                 emailAddress:(NSString *)emailAddress
                     clientID:(NSString *)clientID
                       target:(NSString *)target
                       locale:(NSString *)locale
{
    NSString * tail = [NSString stringWithFormat:@"\"VehModifyRQCore\": {\"@ModifyType\": \"Modify\",\"@Status\": \"Available\",\"UniqueID\": {\"@Type\": \"15\",\"@ID\": \"%@\",\"@ID_Context\": \"CARTRAWLER\"},\"TPA_Extensions\": {\"Email\": {\"@To\": \"%@\"},\"Action\": {\"@Value\": \"SendCustomerVoucher\"}}}", bookingRef, emailAddress];
    
    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder buildHeader:CTCancelHeader clientID:clientID target:target locale:locale], tail];
    
}

+ (NSString *) OTA_InsuranceDetailsRQ:(NSString *)totalCost
                          homeCountry:(NSString *)homeCountry
                       activeCurrency:(NSString *)activeCurrency
                       pickupDateTime:(NSDate *)pickupDateTime
                      dropOffDateTime:(NSDate *)dropOffDateTime
               destinationCountryCode:(NSString *)destinationCountryCode
                             clientID:(NSString *)clientID
                               target:(NSString *)target
                               locale:(NSString *)locale
{    //we don't know their name or the amount of passengers
    NSString *tail = [NSString stringWithFormat:@"\"PlanForQuoteRQ\":{\"@PlanID\":\"ACME\",\"@Type\":\"Protection\",\"CoveredTravelers\":{\"CoveredTraveler\":{\"CoveredPerson\":{\"@Relation\":\"Traveler 1\",\"GivenName\":\"Test\",\"Surname\":\"Test\"},\"CitizenCountryName\":{\"@Code\":\"%@\"}}},\"InsCoverageDetail\":{\"@Type\":\"SingleTrip\",\"TotalTripCost\":{\"@CurrencyCode\":\"%@\",\"@Amount\":\"%@\"},\"CoveredTrips\":{\"CoveredTrip\":{\"@Start\": \"%@\",\"@End\":\"%@\",\"Destinations\":{\"Destination\":{\"CountryName\":\"%@\"}}}}}}", homeCountry, activeCurrency, totalCost, [NSDateUtils stringFromDateWithFormat:pickupDateTime format:CTAvailRequestDateFormat], [NSDateUtils stringFromDateWithFormat:dropOffDateTime format:CTAvailRequestDateFormat], destinationCountryCode];
    
    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder currencyHeader:clientID target:target locale:locale currency:activeCurrency], tail];

}

+ (NSString *) OTA_VehRetResRQ:(NSString *)bookingEmailAddress
                  bookingRefID:(NSString *)bookingRefID
                      clientID:(NSString *)clientID
                        target:(NSString *)target
                        locale:(NSString *)locale
{
    NSString *tail = [NSString stringWithFormat:@"\"VehRetResRQCore\": {\"UniqueID\": {\"@Type\": \"15\",\"@ID\": \"%@\"},\"TPA_Extensions\": {\"Email\": \"%@\"}}}", bookingRefID, bookingEmailAddress];
    
    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder buildHeader:CTHeader clientID:clientID target:target locale:locale], tail];
}

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
                              locale:(NSString *)locale
{
    NSString *tail = [NSString stringWithFormat:@"\"VehResRQCore\":{\"@Status\":\"All\",\"VehRentalCore\":{\"@PickUpDateTime\":\"%@\",\"@ReturnDateTime\":\"%@\",\"PickUpLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"},\"ReturnLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"}},\"Customer\":{\"Primary\":{\"CitizenCountryName\":{\"@Code\":\"%@\"}}}},\"VehResRQInfo\":{\"Reference\":{\"@Type\":\"%@\",\"@ID\":\"%@\",\"@ID_Context\":\"%@\",\"@URL\":\"%@\"}}", puDateTime, doDateTime, puLocationCode, doLocationCode, homeCountry, refType, refID, refIDContext, refURL];
    
    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder buildHeader:CTHeader clientID:clientID target:target locale:locale], tail];
}

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
                       locale:(NSString *)locale
{
    
    NSString *tail =[NSString stringWithFormat: @"  \"VehCancelRQCore\":   { \n"
                                 "      \"@CancelType\": \"Book\", \n"
                                 "      \"UniqueID\":     { \n"
                                 "          \"@Type\": \"15\", \n"
                                 "          \"@ID\": \"%@\" \n"
                                 "      },                 \n"
                                 "      \"PersonName\":     { \n"
                                 "          \"NamePrefix\": \"%@\", \n"
                                 "          \"GivenName\": \"%@\", \n"
                                 "          \"Surname\": \"%@\" \n"
                                 "      } \n "
                                 "  }, \n"
                                 " \"VehCancelRQInfo\":   { \n "
                                   "     \"RentalInfo\":     {\n "
                                   "     \"@PickUpDateTime\": \"%@\", \n"
                                   "     \"@ReturnDateTime\": \"%@\", \n"
                                   "     \"PickUpLocation\":       {                   \n"
                                   "        \"@CodeContext\": \"CARTRAWLER\",          \n"
                                   "        \"@LocationCode\": \"%@\"                  \n"
                                   "    },                                             \n"
                                   "      \"ReturnLocation\":       {                  \n"
                                   "         \"@CodeContext\": \"CARTRAWLER\",         \n"
                                   "         \"@LocationCode\": \"%@\"                 \n"
                                   "     }                                             \n"
                                   " },                                                \n"
                                   " \"TPA_Extensions\": {\"Refund\": {\"@Type\": \"FULL\"}} \n"
                                "}",bookingRef, title, firstName, surname, puDateTime, doDateTime, puLocationCode, doLocationCode];
    
    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder buildHeader:CTCancelHeader clientID:clientID target:target locale:locale], tail];
}

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
                 currencyCode:(NSString *)currencyCode
                     clientID:(NSString *)clientID
                       target:(NSString *)target
                       locale:(NSString *)locale
                    ipaddress:(NSString *)ipaddress
{
    
    NSString *dropoffTime = @"";
    if (doDateTime) {
        dropoffTime = [NSString stringWithFormat:@"         \"@DateTime\": \"%@\", \n", doDateTime];
    }
    
    NSString *airportDropoff = @"";
    NSString *airportPickup = @"";

    
    NSString *airportInfo = [NSString stringWithFormat:
                             @"         ,\"AirportInfo\": {\"%@\":       { \n"
                             @"             \"@CodeContext\": \"IATA\", \n"
                             @"             \"@LocationCode\": \"%@\", \n"
                             @"             \"@Terminal\": \"%@\" \n"
                             @"         }}",
                             flightType,
                             airportCode,
                             terminalNo];
    
    if (airportIsPickupLocation) {
        airportPickup = airportInfo;
    } else {
        airportDropoff = airportInfo;
    }

   NSString *tail = [[NSString alloc]initWithFormat:
                   @" \"Service\":   { \n"
                   @"     \"Pickup\":     { \n"
                   @"         \"@DateTime\": \"%@\", \n"
                   @"         \"Address\":       {  \n"
                   @"             \"@Latitude\": \"%@\", \n"
                   @"             \"@Longitude\": \"%@\", \n"
                   @"             \"LocationType\": \"%@\" \n"
                   @"         } "
                   @"       %@"
                   @"     }, "
                   @"     \"Dropoff\":     { \n"
                   @"         %@"
                   @"         \"Address\":       { \n"
                   @"             \"@Latitude\": \"%@\", \n"
                   @"             \"@Longitude\": \"%@\", \n"
                   @"             \"LocationType\": \"%@\" \n"
                   @"         }"
                   @"    %@ "
                   @"    }"
                   @" }, "
                   @" \"Passengers\":   [ \n"
                                     @"{ "
                                     @"    \"@Quantity\": \"%@\", \n"
                                     @"    \"Category\": \"Adult\" \n"
                                     @"},"
                                     @"{"
                                     @"    \"@Quantity\": \"%@\", \n"
                                     @"    \"Category\": \"Child\" \n"
                                     @"},"
                                     @"{"
                                     @"    \"@Quantity\": \"%@\", \n"
                                     @"    \"Category\": \"Infant\" \n"
                                     @"}"
                                     @"],\"TPA_Extensions\":%@",
                     puDateTime,
                     puLat,
                     puLong,
                     puLocationType,
                     airportPickup,
                     dropoffTime,
                     doLat,
                     doLong,
                     doLocationType,
                     airportDropoff,
                     adults,
                     children,
                     infants,
                     [NSString stringWithFormat:@"{\"ConsumerIP\": \"%@\"}", ipaddress]];

    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder currencyHeader:clientID target:target locale:locale currency:currencyCode], tail];
}

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
                   ipaddress:(NSString *)ipaddress
{
    
    
    NSString *address;
    
    if ([addressLine2 isEqualToString:@""]) {
        address = [NSString stringWithFormat:@"\"%@\",\n\"%@\"\n", addressLine1, city];
    } else {
        address = [NSString stringWithFormat:@"\"%@\",\n\"%@\",\n\"%@\"\n", addressLine1, addressLine2, city];
    }
    
    
    NSString *tail = [[NSString alloc]initWithFormat:
    
    @"    \"GroundReservation\":   { \n"
    @"        \"Location\":     {   \n"
    @"            \"Pickup\":       {   \n"
    @"                \"@DateTime\": \"%@\",   \n"
    @"                \"Address\":         { \n"
    @"                    \"@Latitude\": \"%@\",  \n"
    @"                    \"@Longitude\": \"%@\", \n"
    @"                    \"AddressLine\":           [  \n"
    @"                                              %@  \n"
    @"                                              ],  \n"
    @"                    \"CityName\": \"%@\", \n"
    @"                    \"PostalCode\": \"%@\", \n"
    @"                    \"StateProv\": \"%@\", \n"
    @"                    \"CountryName\":           { \n"
    @"                        \"@Code\": \"%@\", \n"
    @"                        \"#text\": \"%@\" \n"
    @"                    }, \n"
    @"                    \"LocationType\": \"%@\", \n"
    @"                    \"LocationName\": \"%@\",   \n"
    @"                    \"SpecialInstructions\": \"%@\" \n"
    @"                } \n"
    @"            }, \n"
    @"            \"Dropoff\":       { \n"
    @"                \"@DateTime\": \"%@\", \n"
    @"                \"Address\":         { \n"
    @"                    \"@Latitude\": \"%@\", \n"
    @"                    \"@Longitude\": \"%@\", \n"
    @"                    \"LocationType\": \"%@\" \n"
    @"                },    \n"
    @"                \"AirportInfo\": {\"%@\":         { \n"
    @"                    \"@CodeContext\": \"IATA\", \n"
    @"                    \"@LocationCode\": \"%@\",   \n"
    @"                    \"@Terminal\": \"%@\"  \n"
    @"                }}, \n"
    @"                \"Airline\":         { \n"
    @"                    \"@CodeContext\": \"IATA\", \n"
    @"                    \"@Code\": \"%@\", \n"
    @"                    \"@FlightNumber\": \"%@\"    \n"
    @"                } \n"
    @"            } \n"
    @"        },    \n"
    @"        \"Passenger\":     { \n"
    @"            \"Primary\":       {  \n"
    @"                \"PersonName\":         { \n"
    @"                    \"GivenName\": \"%@\", \n"
    @"                    \"Surname\": \"%@\"    \n"
    @"                },    \n"
    @"                \"Telephone\":         [  \n"
    @"                                      {   \n"
    @"                                          \"@PhoneTechType\": \"5\",  \n"
//    @"                                          \"@CountryAccessCode\": \"%@\",    \n"
//    @"                                          \"@AreaCityCode\": \"%@\",  \n"
    @"                                          \"@PhoneNumber\": \"%@\"   \n"
    @"                                      }                              \n"
//    @"                                      },  \n"
//    @"                                      {   \n"
//    @"                                          \"@PhoneTechType\": \"1\",  \n"
//    @"                                          \"@CountryAccessCode\": \"353\",    \n"
//    @"                                          \"@AreaCityCode\": \"1\",   \n"
//    @"                                          \"@PhoneNumber\": \"0000000\"   \n"
//    @"                                      }   \n"
    @"                                      ],  \n"
    @"                \"Address\": {\"CountryName\": {\"@Code\": \"%@\"}},  \n"
    @"                \"Email\": \"%@\"   \n"
    @"            },    \n"
    @"            \"Additional\":       [   \n"
      @"                                 {\"AdditionalPersonType\":         { \n"
      @"                \"@Quantity\": \"%@\", \n"
      @"                \"@Code\": \"Adult\"  \n"
      @"            }},   \n"
    @"                                 {\"AdditionalPersonType\":         { \n"
    @"                \"@Quantity\": \"%@\", \n"
    @"                \"@Code\": \"Child\"  \n"
    @"            }},   \n"
    @"                                 {\"AdditionalPersonType\":         { \n"
    @"                \"@Quantity\": \"%@\", \n"
    @"                \"@Code\": \"Infant\" \n"
    @"            }}    \n"
    @"                                 ]    \n"
    @"        },    \n"
    @"        \"Service\": {\"@DisabilityVehicleInd\": \"false\"},  "
    @"        \"Reference\":     {  \n"
    @"            \"@Type\": \"16\",    \n"
    @"            \"@ID_Context\": \"CARTRAWLER\",  \n"
    @"            \"@ID\": \"%@\",   \n"
    @"            \"@URL\": \"%@\" \n"
    @"        } \n"
    @"    },    \n"
    @"    \"TPA_Extensions\": %@   ",
                      pickupDateTime,
                      pickupLatitude,
                      pickupLongitude,
                      address,
                      city,
                      postcode,
                      stateProvience,
                      countryCode,
                      countryName,
                      pickupLocationType,
                      pickupLocationName,
                      specialInstructions,
                      dropOffdateTime,
                      dropoffLatitude,
                      dropoffLongitude,
                      dropoffLocationType,
                      flightType,
                      airportCode,
                      terminalNo,
                      airlineId,
                      flightNo,
                      firstName,
                      surname,
//                      phoneCountryCode,
//                      phoneVendorPrefix,
                      phone,
                      passengerCountryCode,
                      passengerEmail,
                      additionalAdultQty,
                      childrenQty,
                      infantQty,
                      refId,
                      refUrl,
                      [NSString stringWithFormat:@"{\"ConsumerIP\": \"%@\"}", ipaddress]];
    
    return [NSString stringWithFormat:@"{%@%@}", [CTRequestBuilder groundTransportHeader:clientID target:target locale:locale currency:currencyCode], tail];

}

@end
