//
//  CartrawlerAPI.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 11/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerAPI.h"
#import "CTPostRequest.h"
#import "CTConstants.h"
#import "CartrawlerAPI+NSDate.h"
#import "CTNetworkUtils.h"
#import "CTRequestBuilder.h"
#import "CT_IpToCountryRQ.h"

@interface CartrawlerAPI ()

@property (nonatomic, strong, nonnull) NSString *clientAPIKey;
@property (nonatomic, strong, nonnull) NSString *endPoint;
@property (nonatomic, strong, nonnull) NSString *groundTransportEndPoint;
@property (nonatomic, strong, nonnull) NSString *secureEndPoint;
@property (nonatomic, strong, nonnull) NSString *apiTarget;
@property (nonatomic, strong, nonnull) NSString *locale;
@property (nonatomic, strong, nonnull) NSString *ipAddress;
@property (nonatomic, strong, nonnull) NSURLSessionDataTask *currentTask;
@property (nonatomic, strong, nonnull) CTPostRequest *postRequest;
@property (nonatomic) BOOL loggingEnabled;

@end

@implementation CartrawlerAPI

- (instancetype)initWithClientKey:(NSString *)clientKey language:(NSString *)language debug:(BOOL)debug
{
    self = [super init];
    _clientAPIKey = [[NSString alloc] initWithString:clientKey];
    _locale = language;
    _postRequest = [[CTPostRequest alloc] init];
    _ipAddress = @"127.0.0.1";//initial value
    if (debug) {
        _endPoint = CTTestAPI;
        _secureEndPoint = CTTestAPISecure;
        _apiTarget = CTTestTarget;
        _groundTransportEndPoint = CTTestInternalAPI;
    } else {
        _groundTransportEndPoint = CTProductionAPI;
        _endPoint = CTProductionAPI;
        _secureEndPoint = CTProductionAPISecure;
        _apiTarget = CTProductionTarget;
    }

    return self;
}

- (void)cancelAllRequests
{
    [self.postRequest cancel];
}

- (void)changeLanguage:(NSString *)languageCode
{
    _locale = languageCode;
}

#pragma mark Get Engine Details

- (void)requestNewSession:(NSString *)currencyCode
             languageCode:(NSString *)languageCode
              countryCode:(NSString *)countryCode
               completion:(EngineDetailsCompletion)completion
{
    __weak typeof (self) weakSelf = self;\
    
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.endPoint, @"CT_IpToCountryRQ"];

    [CT_IpToCountryRQ performRequest:self.clientAPIKey
                            currency:currencyCode
                        languageCode:languageCode
                         countryCode:countryCode
                              target:self.apiTarget
                            endpoint:endPoint
                          completion:^(CT_IpToCountryRS *response, CTErrorResponse *error) {
                              weakSelf.ipAddress = response.ipAddress;
                              completion(response, error);
                          }];
}

#pragma mark Location Search

- (void)locationSearchWithPartialString:(NSString *)partialString
                       needsCoordinates:(BOOL)needsCoordinates
                             completion:(LocationSearchCompletion)completion
{
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.endPoint, @"CT_VehLocSearchRQ"];
    NSString *requestBody = [CTRequestBuilder CT_VehLocSearchRQPartial:partialString
                                                              clientID:self.clientAPIKey
                                                                target:self.apiTarget
                                                                locale:self.locale
                                                      needsCoordinates: needsCoordinates];
    
    [self.postRequest performRequestWithData:endPoint
                               jsonBody: requestBody
                         loggingEnabled: self.loggingEnabled
                             completion:^(NSDictionary *response,
                                          CTErrorResponse *error)
    {
        if (error == nil) {
            CTLocationSearch *searchResponse = [[CTLocationSearch alloc] initWithPartialTextDictionary: response];
            completion(searchResponse, nil);
        } else {
            completion(nil, error);
        }
    }];
}

- (void)enableLogging:(BOOL)enabled
{
    _loggingEnabled = enabled;
}

- (void)locationSearchWithCity:(NSString *)cityName
                   countryCode:(NSString *)countryCode
                    completion:(LocationSearchCompletion)completion;
{
    
    NSString *requestBody = [CTRequestBuilder OTA_VehLocSearchRQCity:cityName
                                                         countryName:countryCode
                                                            clientID:self.clientAPIKey
                                                              target:self.apiTarget
                                                              locale:self.locale];
    
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.endPoint, @"OTA_VehLocSearchRQ"];
    
    [self.postRequest performRequestWithData:endPoint
                               jsonBody: requestBody
                         loggingEnabled: self.loggingEnabled
                             completion:^(NSDictionary *response,
                                          CTErrorResponse *error)
    {
        if (error == nil) {
            CTLocationSearch *searchResponse = [[CTLocationSearch alloc] initWithDictionary:response];
            completion(searchResponse, nil);
        } else {
            completion(nil, error);
        }
    }];
}

- (void)locationSearchWithAirportCode:(NSString *)airportCode
                           completion:(LocationSearchCompletion)completion
{
    
    NSString *requestBody = [CTRequestBuilder OTA_VehLocSearchRQAirport:airportCode
                                                               clientID:self.clientAPIKey
                                                                 target:self.apiTarget
                                                                 locale:self.locale];
    
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.endPoint, @"OTA_VehLocSearchRQ"];
    
    [self.postRequest performRequestWithData:endPoint
                               jsonBody: requestBody
                         loggingEnabled: self.loggingEnabled
                             completion:^(NSDictionary *response,
                                          CTErrorResponse *error)
    {
        if (error == nil) {
            CTLocationSearch *searchResponse = [[CTLocationSearch alloc] initWithDictionary:response];
            completion(searchResponse, nil);
        } else {
            completion(nil, error);
        }
    }];
}

- (void)locationSearchWithCoordinates:(NSNumber *)latitude
                            longitude:(NSNumber *)longitude
                               radius:(NSNumber *)radius
                  distanceUnitIsMiles:(BOOL)distanceUnitIsMiles
                           completion:(LocationSearchCompletion)completion;
{
    
    NSString *requestBody = [CTRequestBuilder OTA_VehLocSearchRQCoordinates:[NSString stringWithFormat:@"%.2f", latitude.floatValue]
                                                                  longitude:[NSString stringWithFormat:@"%.2f", longitude.floatValue]
                                                                     radius:radius.stringValue
                                                               isUsingMiles:distanceUnitIsMiles
                                                                   clientID:self.clientAPIKey
                                                                     target:self.apiTarget
                                                                     locale:self.locale];
    
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.endPoint, @"OTA_VehLocSearchRQ"];
    
    [self.postRequest performRequestWithData:endPoint
                               jsonBody: requestBody
                         loggingEnabled: self.loggingEnabled
                             completion:^(NSDictionary *response,
                                          CTErrorResponse *error)
    {
        if (error == nil) {
            CTLocationSearch *searchResponse = [[CTLocationSearch alloc] initWithDictionary:response];
            completion(searchResponse, nil);
        } else {
            completion(nil, error);
        }
    }];
}

#pragma mark Request car availability

- (void)requestVehicleAvailabilityForLocation:(NSString *)pickupLocationCode
                           returnLocationCode:(NSString *)returnLocationCode
                          customerCountryCode:(NSString *)customerCountryCode
                                 passengerQty:(NSNumber *)passengerQty
                                    driverAge:(NSNumber *)driverAge
                               pickUpDateTime:(NSDate *)pickupDateTime
                               returnDateTime:(NSDate *)returnDateTime
                                 currencyCode:(NSString *)currencyCode
                                   completion:(RequestAvailabilityCompletion)completion
{
    
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.endPoint, @"OTA_VehAvailRateRQ"];
    
    NSString *requestBody = [CTRequestBuilder OTA_VehAvailRateRQ: [pickupDateTime stringFromDateWithFormat:CTAvailRequestDateFormat]
                                        returnDateTime: [returnDateTime stringFromDateWithFormat:CTAvailRequestDateFormat]
                                    pickUpLocationCode: pickupLocationCode
                                    returnLocationCode: returnLocationCode
                                             driverAge: driverAge.stringValue
                                          passengerQty: passengerQty.stringValue
                                       homeCountryCode: customerCountryCode
                                              clientID: self.clientAPIKey
                                                target: self.apiTarget
                                                locale: self.locale
                                              currency: currencyCode];
    
    
    [self.postRequest performRequestWithData:endPoint
                               jsonBody: requestBody
                         loggingEnabled: self.loggingEnabled
                             completion:^(NSDictionary *response,
                                          CTErrorResponse *error)
    {
        if (error == nil) {
            CTVehicleAvailability *vehAvailRSCore = [[CTVehicleAvailability alloc] initFromVehAvailRSCoreDictionary: response];
            completion(vehAvailRSCore, nil);
        } else {
            completion(nil, error);
        }
    }];

}

#pragma mark Insurance quote

- (void)requestInsuranceQuoteForVehicle:(NSString *)homeCountry
                               currency:(NSString *)currency
                              totalCost:(NSString *)totalCost
                         pickupDateTime:(NSDate *)pickupDateTime
                         returnDateTime:(NSDate *)returnDateTime
                 destinationCountryCode:(NSString *)destinationCountryCode
                        selectedVehicle:(CTAvailabilityItem *)selectedVehicle
                             completion:(InsuranceQuoteCompletion)completion
{
    
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.endPoint, @"OTA_InsuranceQuoteRQ"];

    NSString *requestBody = [CTRequestBuilder OTA_InsuranceDetailsRQ:totalCost
                                                         homeCountry:homeCountry
                                                      activeCurrency:currency
                                                      pickupDateTime:pickupDateTime
                                                     dropOffDateTime:returnDateTime
                                              destinationCountryCode:destinationCountryCode
                                                            clientID:self.clientAPIKey
                                                              target:self.apiTarget
                                                              locale:self.locale
                                                               refID:selectedVehicle.vehicle.refID
                                                              refURL:selectedVehicle.vehicle.refURL
                                                        refTimeStamp:selectedVehicle.vehicle.refTimeStamp];
    
    [self.postRequest performRequestWithData:endPoint
                               jsonBody: requestBody
                         loggingEnabled: self.loggingEnabled
                             completion:^(NSDictionary *response,
                                          CTErrorResponse *error)
    {
        if (error == nil) {
            if (response[@"Success"]) {
                CTInsurance *insurance = [[CTInsurance alloc] initFromDict:response];
                completion(insurance, nil);
            } else {
                completion(nil, [CTErrorResponse new]);
            }
        } else {
            completion(nil, error);
        }
    }];
}

#pragma mark Reserve Vehicle

- (void)reserveVehicle:(NSDate *)pickupDateTime
        returnDateTime:(NSDate *)returnDateTime
    pickupLocationCode:(NSString *)pickupLocationCode
    returnLocationCode:(NSString *)returnLocationCode
          passengerQty:(NSNumber *)passengerQty
          flightNumber:(NSString *)flightNumber
              customer:(CTCustomer *)customer
                   car:(CTVehicle *)car
                extras:(NSArray *)extras
              currency:(NSString *)currency
                  card:(CTPaymentCard *)card
       insuranceObject:(CTInsurance *)insuranceObject
            completion:(ReserveVehicleCompletion)completion
{
    
    BOOL isBuyingInsurance = (insuranceObject != nil);

    NSString *requestBody = [CTRequestBuilder OTA_VehResRQ:[pickupDateTime stringFromDateWithFormat:CTAvailRequestDateFormat]
                                            returnDateTime:[returnDateTime stringFromDateWithFormat:CTAvailRequestDateFormat]
                                        pickupLocationCode:pickupLocationCode
                                       dropoffLocationCode:returnLocationCode
                                               homeCountry:customer.homeCountry
                                                 driverAge:customer.age.stringValue
                                             numPassengers:passengerQty.stringValue
                                              flightNumber:flightNumber
                                                     refID:car.refID
                                              refTimeStamp:car.refTimeStamp
                                                    refURL:car.refURL
                                               extrasArray:extras
                                                 givenName:customer.firstName
                                                   surName:customer.lastName
                                              emailAddress:customer.email
                                                   address:customer.address
                                               phoneNumber:customer.phone
                                                  cardType:card.type
                                                cardNumber:card.number
                                            cardExpireDate:card.expiry
                                            cardHolderName:card.holderName
                                             cardCCVNumber:card.cvc
                                           insuranceObject:insuranceObject
                                         isBuyingInsurance:isBuyingInsurance
                                                  clientID:self.clientAPIKey
                                                    target:self.apiTarget
                                                    locale:self.locale
                                                  currency: currency];
    
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.secureEndPoint, @"OTA_VehResRQ"];
    [self.postRequest performRequestWithData:endPoint
                               jsonBody: requestBody
                         loggingEnabled: self.loggingEnabled
                             completion:^(NSDictionary *response,
                                          CTErrorResponse *error)
    {
        if (error == nil) {
            CTBooking *booking = [[CTBooking alloc] initFromVehReservationDictionary: response];
            completion(booking, nil);
        } else {
            completion(nil, error);
        }
    }];
    
}

#pragma mark Get Booking

- (void)requestBookedVehicle:(NSString *)bookingEmailAddress
                bookingRefID:(NSString *)bookingRefID
                  completion:(BookingCompletion)completion
{
    NSString *requestBody = [CTRequestBuilder OTA_VehRetResRQ:bookingEmailAddress
                                                 bookingRefID:bookingRefID
                                                     clientID: self.clientAPIKey
                                                       target: self.apiTarget
                                                       locale:self.locale];
    
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.endPoint, @"OTA_VehRetResRQ"];

    [self.postRequest performRequestWithData:endPoint
                               jsonBody: requestBody
                         loggingEnabled: self.loggingEnabled
                             completion:^(NSDictionary *response, CTErrorResponse *error)
     {
        if (error == nil) {
            CTBooking *booking = [[CTBooking alloc] initFromRetrievedBookingDictionary:response];
            completion(booking, nil);
        } else {
            completion(nil, error);
        }
    }];    
}

#pragma mark Terms and Conditions

- (void)requestTermsAndConditions:(NSDate *)pickupDateTime
                   returnDateTime:(NSDate *)returnDateTime
               pickupLocationCode:(NSString *)pickupLocationCode
               returnLocationCode:(NSString *)returnLocationCode
                      homeCountry:(NSString *)homeCountry
                              car:(CTVehicle *)car
                       completion:(TermsAndConditionsCompletion)completion
{
    NSString *requestBody = [CTRequestBuilder CT_RentalConditionsRQ:[pickupDateTime stringFromDateWithFormat:CTAvailRequestDateFormat]
                                                         doDateTime:[returnDateTime stringFromDateWithFormat:CTAvailRequestDateFormat]
                                                     puLocationCode:pickupLocationCode
                                                     doLocationCode:returnLocationCode
                                                        homeCountry:homeCountry
                                                            refType:car.refType
                                                              refID:car.refID
                                                       refIDContext:car.refIDContext
                                                             refURL:car.refURL
                                                           clientID:self.clientAPIKey
                                                             target:self.apiTarget
                                                             locale:self.locale];
    
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.endPoint, @"CT_RentalConditionsRQ"];
    
    [self.postRequest performRequestWithData:endPoint
                               jsonBody: requestBody
                         loggingEnabled: self.loggingEnabled
                             completion:^(NSDictionary *response,
                                          CTErrorResponse *error)
    {
        if (error == nil) {
            CTTermsAndConditions *terms = [[CTTermsAndConditions alloc] initFromAPIResponse:response];
            completion(terms, nil);
        } else {
            completion(nil, error);
        }
    }];
}

#pragma mark Cancel Booking

- (void)cancelBooking:(NSString *)bookingRef
                title:(NSString *)title
            firstName:(NSString *)firstName
              surname:(NSString *)surname
       pickupDateTime:(NSDate *)pickupDateTime
      dropoffDateTime:(NSDate *)dropoffDateTime
   pickupLocationCode:(NSString *)pickupLocationCode
   returnLocationCode:(NSString *)returnLocationCode
           completion:(ModifyCompletion)completion
{
    NSString *requestBody = [CTRequestBuilder CT_VehCancelRQ:bookingRef
                                                       title:title
                                                   firstName:firstName
                                                     surname:surname
                                                  puDateTime:[pickupDateTime stringFromDateWithFormat:CTAvailRequestDateFormat]
                                                  doDateTime:[dropoffDateTime stringFromDateWithFormat:CTAvailRequestDateFormat]
                                              puLocationCode:pickupLocationCode
                                              doLocationCode:returnLocationCode
                                                    clientID:self.clientAPIKey
                                                      target:self.apiTarget
                                                      locale:self.locale];
    
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.endPoint, @"OTA_VehCancelRQ"];
    
    [self.postRequest performRequestWithData:endPoint
                               jsonBody: requestBody
                         loggingEnabled: self.loggingEnabled
                             completion:^(NSDictionary *response,
                                          CTErrorResponse *error)
    {
        if (error == nil) {
            completion(YES, nil);
        } else {
            completion(NO, error);
        }
    }];
}

#pragma mark Email Booking

- (void)emailBooking:(NSString *)bookingRef
               email:(NSString *)email
          completion:(ModifyCompletion)completion
{
    NSString *requestBody = [CTRequestBuilder CT_VehEmailRQ:bookingRef
                                               emailAddress:email
                                                   clientID:self.clientAPIKey
                                                     target:self.apiTarget
                                                     locale:self.locale];
    
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.endPoint, @"OTA_VehModifyRQ"];
    
    [self.postRequest performRequestWithData:endPoint
                               jsonBody: requestBody
                         loggingEnabled: self.loggingEnabled
                             completion:^(NSDictionary *response,
                                          CTErrorResponse *error)
    {
        if (error == nil) {
            completion(YES, nil);
        } else {
            completion(NO, error);
        }
    }];
}

#pragma mark Ground Transportation

- (void)groundTransportationAvail:(CTAirport *)airport
                   pickupLocation:(CTGroundLocation *)pickupLocation
                  dropoffLocation:(CTGroundLocation *)dropoffLocation
          airportIsPickupLocation:(BOOL)airportIsPickupLocation
                         adultQty:(NSNumber *)adultQty
                         childQty:(NSNumber *)childQty
                        infantQty:(NSNumber *)infantQty
                        seniorQty:(NSNumber *)seniorQty
                     currencyCode:(NSString *)currencyCode
                      countryCode:(NSString *)countryCode
                       completion:(GroundAvailCompletion)completion
{
    NSString *requestBody = [CTRequestBuilder CT_GroundAvail:[pickupLocation.dateTime  stringFromDateWithFormat:CTAvailRequestDateFormat]
                                                  doDateTime:[dropoffLocation.dateTime stringFromDateWithFormat:CTAvailRequestDateFormat]
                                                       puLat:[NSString stringWithFormat:@"%.5f", pickupLocation.latitude.floatValue]
                                                      puLong:[NSString stringWithFormat:@"%.5f", pickupLocation.longitude.floatValue]
                                                       doLat:[NSString stringWithFormat:@"%.5f", dropoffLocation.latitude.floatValue]
                                                      doLong:[NSString stringWithFormat:@"%.5f", dropoffLocation.longitude.floatValue]
                                              puLocationType:pickupLocation.locationTypeDescription
                                              doLocationType:dropoffLocation.locationTypeDescription
                                     airportIsPickupLocation:airportIsPickupLocation
                                                  flightType:airport.flightType
                                                 airportCode:airport.IATACode
                                                  terminalNo:airport.terminalNumber
                                                      adults:adultQty.stringValue
                                                    children:childQty.stringValue
                                                     infants:infantQty.stringValue
                                                     seniors:seniorQty.stringValue
                                                currencyCode:currencyCode
                                                    clientID:self.clientAPIKey
                                                      target:self.apiTarget
                                                      locale:self.locale
                                                   ipaddress:self.ipAddress
                                                 countryCode:countryCode];
    
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.groundTransportEndPoint, @"OTA_GroundAvailRQ"];
    
    [self.postRequest performRequestWithData:endPoint
                               jsonBody: requestBody
                         loggingEnabled: self.loggingEnabled
                             completion:^(NSDictionary *response,
                                          CTErrorResponse *error)
     {
         if (error == nil) {
             CTGroundAvailability *groundAvail = [[CTGroundAvailability alloc] initWithDictionary: response];
             completion(groundAvail, nil);
         } else {
             completion(nil, error);
         }
     }];

}

- (void)groundTransportationBooking:(CTAirport *)airport
                            service:(CTGroundService *)service
                     pickupLocation:(CTGroundLocation *)pickupLocation
                    dropoffLocation:(CTGroundLocation *)dropoffLocation
                 pickupLocationName:(NSString *)pickupLocationName
                           customer:(CTGroundCustomer *)customer
                specialInstructions:(NSString *)specialInstructions
                       flightNumber:(NSString *)flightNumber
                 additionalAdultQty:(NSNumber *)additionalAdultQty
                        childrenQty:(NSNumber *)childrenQty
                          infantQty:(NSNumber *)infantQty
                       currencyCode:(NSString *)currencyCode
                         completion:(GroundBookingCompletion)completion
{
    //parse flight number
    NSString *flightNo = [[flightNumber componentsSeparatedByCharactersInSet:
                            [NSCharacterSet decimalDigitCharacterSet].invertedSet]
                           componentsJoinedByString:@""];
    
    NSString *airline = [[flightNumber componentsSeparatedByCharactersInSet:
                          [NSCharacterSet letterCharacterSet].invertedSet]
                         componentsJoinedByString:@""];
    
    NSString *requestBody = [CTRequestBuilder CT_GroundBook:[pickupLocation.dateTime stringFromDateWithFormat:CTAvailRequestDateFormat]
                                             pickupLatitude:[NSString stringWithFormat:@"%.5f", pickupLocation.latitude.floatValue]
                                            pickupLongitude:[NSString stringWithFormat:@"%.5f", pickupLocation.longitude.floatValue]
                                               addressLine1:customer.addressLine1
                                               addressLine2:customer.addressLine2
                                                       town:customer.addressTown
                                                       city:customer.addressCity
                                                   postcode:customer.addressPostCode
                                             stateProvience:customer.addressStateProvince
                                                countryCode:customer.countryCode
                                                countryName:customer.countryName
                                         pickupLocationType:pickupLocation.locationTypeDescription
                                         pickupLocationName:pickupLocationName
                                        specialInstructions:specialInstructions
                                            dropOffdateTime:[dropoffLocation.dateTime stringFromDateWithFormat:CTAvailRequestDateFormat]
                                            dropoffLatitude:[NSString stringWithFormat:@"%.5f",dropoffLocation.latitude.floatValue]
                                           dropoffLongitude:[NSString stringWithFormat:@"%.5f",dropoffLocation.longitude.floatValue]
                                        dropoffLocationType:dropoffLocation.locationTypeDescription
                                                airportCode:airport.IATACode
                                                 terminalNo:airport.terminalNumber
                                                  airlineId:airline
                                                 flightType:airport.flightType
                                                   flightNo:flightNo
                                                  firstName:customer.firstName
                                                    surname:customer.surname
                                                      phone:customer.phone
                                       passengerCountryCode:customer.countryCode
                                             passengerEmail:customer.email
                                         additionalAdultQty:additionalAdultQty.stringValue
                                                childrenQty:childrenQty.stringValue
                                                  infantQty:infantQty.stringValue
                                                      refId:service.refId
                                                     refUrl:service.refUrl
                                               currencyCode:currencyCode
                                                   clientID:self.clientAPIKey
                                                     target:self.apiTarget
                                                     locale:self.locale
                                                  ipaddress:self.ipAddress];
    
    
    NSString *endPoint = [NSString stringWithFormat:@"%@%@", self.groundTransportEndPoint, @"OTA_GroundBookRQ"];
    
    [self.postRequest performRequestWithData:endPoint
                               jsonBody: requestBody
                         loggingEnabled: self.loggingEnabled
                             completion:^(NSDictionary *response,
                                          CTErrorResponse *error)
     {
         if (error == nil) {
             CTGroundBooking *booking = [[CTGroundBooking alloc] initWithDictionary:response];
             completion(booking, nil);
         } else {
             completion(nil, error);
         }
     }];

    
    NSLog(@"%@", requestBody);
}



@end
