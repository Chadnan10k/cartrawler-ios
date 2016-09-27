//
//  GTPaymentRequest.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTPaymentRequest.h"

@implementation GTPaymentRequest

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
                  returnTrip:(BOOL)returnTrip
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
    
    NSString *returnDate = @"";
    
    if (returnTrip) {
        returnDate =  [NSString stringWithFormat:@""
                       @","
                       @"\"TPA_Extensions\": "
                       @"{ "
                       @"\"IncludeReturn\": {"
                       @"\"@PickupDateTime\": \"%@\" "
                       @"}"
                       @"}", dropOffdateTime];
    }
    
    NSString *payment = [NSString stringWithFormat:
                      @"\"Payments\": {\n"
                      @"\"Payment\": {\n"
                      @"\"PaymentCard\": { \n"
                      @"\"@CardCode\": \"%@\",\n"
                      @"\"@ExpireDate\": \"%@\",\n"
                      @"\"CardHolderName\": \"%@\",\n"
                      @"\"CardNumber\": {\n"
                      @"\"PlainText\": \"%@\"\n"
                      @"},\n"
                      @"\"SeriesCode\": {\n"
                      @"\"PlainText\": \"%@\"\n"
                      @"}\n"
                      @"}\n"
                      @"}\n"
                      @"}\n", @"[CARDCODE]", @"[EXPIREDATE]", @"[CARDHOLDERNAME]", @"[CARDNUMBER]", @"[SERIESCODE]"];
    
    NSString *flightNoInfo = @"";
    
    if (flightNo != nil && airlineId != nil) {
        flightNoInfo = [NSString stringWithFormat:
           @", \n"
           @"\"Airline\":{ \n"
           @"\"@CodeContext\": \"IATA\", \n"
           @"\"@Code\": \"%@\", \n"
           @"\"@FlightNumber\": \"%@\"    \n"
           @"} \n", airlineId, flightNo];
    }
    
    NSString *airportPickup = @"";
    NSString *airportDropoff = @"";

    NSString *airportInfo = [NSString stringWithFormat:
                             @",\n"
                             @"\"AirportInfo\": {\"%@\":{ \n"
                             @"\"@CodeContext\": \"IATA\", \n"
                             @"\"@LocationCode\": \"%@\",\n"
                             @"\"@Terminal\": \"%@\"  \n"
                             @"}} %@",
                             @"Arrival",
                             airportCode,
                             terminalNo,
                             flightNoInfo];
    
    if (airportIsPickup) {
        airportPickup = airportInfo;
    } else {
        airportDropoff = airportInfo;
    }
    
    if ([specialInstructions isEqualToString:@""] || specialInstructions == nil) {
        specialInstructions = @"No instructions stated";
    }
    
    NSString *tail = [[NSString alloc]initWithFormat:
                      
                      @"\"GroundReservation\":{ \n"
                      @"\"Location\":{   \n"
                      @"\"Pickup\":{   \n"
                      @"\"@DateTime\": \"%@\",\n"
                      @"\"Address\":{ \n"
                      @"\"@Latitude\": \"%@\",\n"
                      @"\"@Longitude\": \"%@\",\n"
                      @"\"AddressLine\":[\n"
                      @"%@\n"
                      @"],\n"
                      @"\"CityName\": \"%@\",\n"
                      @"\"PostalCode\": \"%@\",\n"
                      @"\"CountryName\":{ \n"
                      @"\"@Code\": \"%@\",\n"
                      @"\"#text\": \"%@\"\n"
                      @"}, \n"
                      @"\"LocationType\": \"%@\", \n"
                      @"\"LocationName\": \"%@\",   \n"
                      @"\"SpecialInstructions\": \"%@\" \n"
                      @"} %@ \n"
                      @"}, \n"
                      @"\"Dropoff\":       { \n"
                      @"\"@DateTime\": \"%@\",   \n"
                      @"\"Address\":{ \n"
                      @"\"@Latitude\": \"%@\", \n"
                      @"\"@Longitude\": \"%@\", \n"
                      @"\"LocationType\": \"%@\" \n"
                      @"} %@ \n"
                      @"} \n"
                      @"},\n"
                      @"\"Passenger\":{ \n"
                      @"\"Primary\":{  \n"
                      @"\"PersonName\":{ \n"
                      @"\"GivenName\": \"%@\", \n"
                      @"\"Surname\": \"%@\"\n"
                      @"},\n"
                      @"\"Telephone\":[\n"
                      @"{\n"
                      @"\"@PhoneTechType\": \"5\",\n"
                      @"\"@PhoneNumber\": \"%@\"\n"
                      @"}\n"
                      @"],\n"
                      @"\"Address\": {\"CountryName\": {\"@Code\": \"%@\"}},  \n"
                      @"\"Email\": \"%@\"\n"
                      @"},\n"
                      @"\"Additional\":[\n"
                      @"{\"AdditionalPersonType\":{ \n"
                      @"\"@Quantity\": \"%@\", \n"
                      @"\"@Code\": \"Adult\"  \n"
                      @"}},\n"
                      @"{\"AdditionalPersonType\":{ \n"
                      @"\"@Quantity\": \"%@\", \n"
                      @"\"@Code\": \"Child\"  \n"
                      @"}},\n"
                      @"{\"AdditionalPersonType\":{ \n"
                      @"\"@Quantity\": \"%@\", \n"
                      @"\"@Code\": \"Infant\" \n"
                      @"}}\n"
                      @"]\n"
                      @"},\n"
                      @"\"Service\": {\"@DisabilityVehicleInd\": \"false\"},  "
                      @"\"Reference\":     {  \n"
                      @"\"@Type\": \"16\",    \n"
                      @"\"@ID_Context\": \"CARTRAWLER\",  \n"
                      @"\"@ID\": \"%@\",   \n"
                      @"\"@URL\": \"%@\" \n"
                      @"} \n"
                      @"},\n"
                      @"%@ \n"
                      @"%@",
                      pickupDateTime,
                      pickupLatitude,
                      pickupLongitude,
                      address,
                      city,
                      postcode,
                      countryCode,
                      countryName,
                      pickupLocationType,
                      pickupLocationName,
                      specialInstructions,
                      airportPickup,
                      dropOffdateTime,
                      dropoffLatitude,
                      dropoffLongitude,
                      dropoffLocationType,
                      airportDropoff,
                      firstName,
                      surname,
                      phone,
                      passengerCountryCode,
                      passengerEmail,
                      additionalAdultQty,
                      childrenQty,
                      infantQty,
                      refId,
                      refUrl,
                      payment,
                      returnDate];
    
    return [NSString stringWithFormat:@"{%@%@}", [self groundTransportHeader:clientID target:target locale:locale currency:currencyCode], tail];
}

+ (NSString *)groundTransportHeader:(NSString *)clientID target:(NSString *)target locale:(NSString *)locale currency:(NSString *)currency
{
    return [NSString stringWithFormat:@"\"@xmlns\":\"http://www.opentravel.org/OTA/2003/05\",\"@Version\": \"2.000\",\"@Target\": \"%@\",\"@PrimaryLangID\": \"%@\",\"POS\": {\"Source\": { \"@ERSP_UserID\":\"KO\", \"@ISOCurrency\": \"%@\",\"RequestorID\": {\"@Type\": \"16\",\"@ID\": \"%@\",\"@ID_Context\": \"CARTRAWLER\"}}},", target, locale, currency, clientID];
}

@end
