//
//  PaymentRequest.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentRequest.h"

@implementation PaymentRequest

+ (NSString *)currencyHeader:(NSString *)clientID target:(NSString *)target locale:(NSString *)locale currency:(NSString *)currency
{
    return [NSString stringWithFormat:@"\"@xmlns\":\"http://www.opentravel.org/OTA/2003/05\",\"@Version\": \"1.002\",\"@Target\": \"%@\",\"@PrimaryLangID\": \"%@\",\"POS\": {\"Source\": {\"@ISOCurrency\": \"%@\",\"RequestorID\": {\"@Type\": \"16\",\"@ID\": \"%@\",\"@ID_Context\": \"CARTRAWLER\"}}},", target, locale, currency, clientID];
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
                extrasString = [extrasString stringByAppendingString:[NSString stringWithFormat:@"{\"@EquipType\":\"%@\",\"@Quantity\":\"%li\"}",e.equipType, (long)e.qty]];
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
    
    NSString *paymentExtension = [NSString stringWithFormat:@"\"RentalPaymentPref\":{\"PaymentCard\":{\"@CardType\":\"1\",\"@CardCode\":\"%@\",\"@CardNumber\":\"%@\",\"@ExpireDate\":\"%@\",\"@SeriesCode\":\"%@\",\"CardHolderName\":\"%@\"}},", @"[CARDCODE]", @"[CARDNUMBER]", @"[EXPIREDATE]", @"[SERIESCODE]", @"[CARDHOLDERNAME]"];
    
    if (flightNumber != nil && flightNumber.length > 2) {
        NSString *flightNumberPrefixString = [flightNumber substringToIndex:2];
        NSString *flightNumberString = [flightNumber substringFromIndex:2];
        
        if (isBuyingInsurance) {
            // Tested, this works.
            tail = [NSString stringWithFormat:@"\"VehResRQCore\":{\"@Status\":\"All\",\"VehRentalCore\":{\"@PickUpDateTime\":\"%@\",\"@ReturnDateTime\":\"%@\",\"PickUpLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"},\"ReturnLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"}},\"Customer\":{\"Primary\":{\"PersonName\":{\"GivenName\":\"%@\",\"Surname\":\"%@\"},\"Telephone\":{\"@PhoneTechType\":\"1\",\"@PhoneNumber\":\"%@\"},\"Email\":{\"@EmailType\":\"2\",\"#text\":\"%@\"},\"Address\":{\"@Type\":\"2\",\"AddressLine\":\"%@\",\"CountryName\":{\"@Code\":\"%@\"}},\"CitizenCountryName\":{\"@Code\":\"%@\"}}},\"DriverType\":{\"@Age\":\"%@\"}%@},\"VehResRQInfo\":{\"@PassengerQty\":\"%@\",\"ArrivalDetails\":{\"@TransportationCode\":\"14\",\"@Number\":\"%@\",\"OperatingCompany\":\"%@\"},%@\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"CARTRAWLER\",\"@DateTime\":\"%@\",\"@URL\":\"%@\"},\"TPA_Extensions\":{\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"INSURANCE\",\"@Amount\":\"%@\",\"@CurrencyCode\":\"%@\",\"@URL\":\"%@\"}}}" ,pickupDateTime, returnDateTime, pickupLocationCode, dropoffLocationCode, givenName, surName, phoneNumber, emailAddress, address, homeCountry, homeCountry, driverAge, extrasString, numPassengers, flightNumberString, flightNumberPrefixString, paymentExtension, refID, refTimeStamp, refURL, ins.planID, ins.premiumAmount, ins.premiumCurrencyCode, ins.termsAndConditionsURL];
        }
        else {
            // Tested this works.
            tail = [NSString stringWithFormat:@"\"VehResRQCore\":{\"@Status\":\"All\",\"VehRentalCore\":{\"@PickUpDateTime\":\"%@\",\"@ReturnDateTime\":\"%@\",\"PickUpLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"},\"ReturnLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"}},\"Customer\":{\"Primary\":{\"PersonName\":{\"GivenName\":\"%@\",\"Surname\":\"%@\"},\"Telephone\":{\"@PhoneTechType\":\"1\",\"@PhoneNumber\":\"%@\"},\"Email\":{\"@EmailType\":\"2\",\"#text\":\"%@\"},\"Address\":{\"@Type\":\"2\",\"CountryName\":{\"@Code\":\"%@\"}},\"CitizenCountryName\":{\"@Code\":\"%@\"}}},\"DriverType\":{\"@Age\":\"%@\"}%@},\"VehResRQInfo\":{\"@PassengerQty\":\"%@\",\"ArrivalDetails\":{\"@TransportationCode\":\"14\",\"@Number\":\"%@\",\"OperatingCompany\":\"%@\"},%@\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"CARTRAWLER\",\"@DateTime\":\"%@\",\"@URL\":\"%@\"}}" ,pickupDateTime, returnDateTime, pickupLocationCode, dropoffLocationCode, givenName, surName, phoneNumber, emailAddress, homeCountry, homeCountry, driverAge, extrasString, numPassengers, flightNumberString, flightNumberPrefixString, paymentExtension, refID, refTimeStamp, refURL];
        }
    } else {
        // There isn't a flight number
        if (isBuyingInsurance) {
            // Tested, this works.
            tail = [NSString stringWithFormat:@"\"VehResRQCore\":{\"@Status\":\"All\",\"VehRentalCore\":{\"@PickUpDateTime\":\"%@\",\"@ReturnDateTime\":\"%@\",\"PickUpLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"},\"ReturnLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"}},\"Customer\":{\"Primary\":{\"PersonName\":{\"GivenName\":\"%@\",\"Surname\":\"%@\"},\"Telephone\":{\"@PhoneTechType\":\"1\",\"@PhoneNumber\":\"%@\"},\"Email\":{\"@EmailType\":\"2\",\"#text\":\"%@\"},\"Address\":{\"@Type\":\"2\",\"AddressLine\":\"%@\",\"CountryName\":{\"@Code\":\"%@\"}},\"CitizenCountryName\":{\"@Code\":\"%@\"}}},\"DriverType\":{\"@Age\":\"%@\"}%@},\"VehResRQInfo\":{\"@PassengerQty\":\"%@\",%@\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"CARTRAWLER\",\"@DateTime\":\"%@\",\"@URL\":\"%@\"},\"TPA_Extensions\":{\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"INSURANCE\",\"@Amount\":\"%@\",\"@CurrencyCode\":\"%@\",\"@URL\":\"%@\"}}}" ,pickupDateTime, returnDateTime, pickupLocationCode, dropoffLocationCode, givenName, surName, phoneNumber, emailAddress, address, homeCountry, homeCountry, driverAge, extrasString, numPassengers, paymentExtension, refID, refTimeStamp, refURL, ins.planID, ins.premiumAmount, ins.premiumCurrencyCode, ins.termsAndConditionsURL];
        } else {
            // Tested, this works.
            tail = [NSString stringWithFormat:@"\"VehResRQCore\":{\"@Status\":\"All\",\"VehRentalCore\":{\"@PickUpDateTime\":\"%@\",\"@ReturnDateTime\":\"%@\",\"PickUpLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"},\"ReturnLocation\":{\"@CodeContext\":\"CARTRAWLER\",\"@LocationCode\":\"%@\"}},\"Customer\":{\"Primary\":{\"PersonName\":{\"GivenName\":\"%@\",\"Surname\":\"%@\"},\"Telephone\":{\"@PhoneTechType\":\"1\",\"@PhoneNumber\":\"%@\"},\"Email\":{\"@EmailType\":\"2\",\"#text\":\"%@\"},\"Address\":{\"@Type\":\"2\",\"CountryName\":{\"@Code\":\"%@\"}},\"CitizenCountryName\":{\"@Code\":\"%@\"}}},\"DriverType\":{\"@Age\":\"%@\"}%@},\"VehResRQInfo\":{\"@PassengerQty\":\"%@\",%@\"Reference\":{\"@Type\":\"16\",\"@ID\":\"%@\",\"@ID_Context\":\"CARTRAWLER\",\"@DateTime\":\"%@\",\"@URL\":\"%@\"}}" ,pickupDateTime, returnDateTime, pickupLocationCode, dropoffLocationCode, givenName, surName, phoneNumber, emailAddress, homeCountry, homeCountry, driverAge, extrasString, numPassengers, paymentExtension, refID, refTimeStamp, refURL];
        }
    }
    
    return [NSString stringWithFormat:@"{%@%@}", [self currencyHeader:clientID target:target locale:locale currency:currency], tail];
}

@end
