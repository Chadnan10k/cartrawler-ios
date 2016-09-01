//
//  CartrawlerAPI.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 11/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTErrorResponse.h"
#import "CTLocationSearch.h"
#import "CTVehicleAvailability.h"
#import "CTInsurance.h"
#import "CTCar.h"
#import "CTPaymentCard.h"
#import "CTCustomer.h"
#import "CTBooking.h"
#import "CTTermsAndConditions.h"
#import "CTExtraEquipment.h"
#import "CTMatchedLocation.h"
#import "CTVendor.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
#error CartrawlerAPI supports iOS7 and upwards
#endif

@interface CartrawlerAPI : NSObject

typedef void (^LocationSearchCompletion)(CTLocationSearch *response, CTErrorResponse *error);
typedef void (^RequestAvailabilityCompletion)(CTVehicleAvailability*response, CTErrorResponse *error);
typedef void (^InsuranceQuoteCompletion)(CTInsurance *response, CTErrorResponse *error);
typedef void (^ReserveVehicleCompletion)(CTBooking *response, CTErrorResponse *error);
typedef void (^TermsAndConditionsCompletion)(CTTermsAndConditions *response, CTErrorResponse *error);
typedef void (^BookingCompletion)(CTBooking *response, CTErrorResponse *error);
typedef void (^ModifyCompletion)(BOOL success, CTErrorResponse *error);

typedef NS_ENUM(NSInteger, DistanceUnit) {
    KM
};

/**
 *  Initialize the Cartrawler framework with your client API key
 *
 *  @param clientKey Your client API key
 *  @param debug Enable or disable test endpoints
 */
- (id)initWithClientKey:(NSString *)clientKey debug:(BOOL)debug;

/**
 *  Set the locale, returns API messages in desired language
 *  This is set to EN if left untouched
 *  @param locale The locale identifer eg. EN
 */
- (void)setLocale:(NSString *)locale;

#pragma mark Location Search

/**
 *  Search for locations using a partial string
 *
 *  @param partialString The partial string
 *  @param completion If successful you get a VehicleSearchResponse, If failure an ErrorResponse will be returned
 */
- (void)locationSearchWithPartialString:(NSString *)partialString completion:(LocationSearchCompletion)completion;

/**
 *  Search for supplier location by city / country
 *
 *  @param cityName    The city name eg. Dublin
 *  @param countryCode The 2-letter country code to search eg. IE
 *  @param completion If successful you get a VehicleSearchResponse, If failure an ErrorResponse will be returned

 */
- (void)locationSearchWithCity:(NSString *)cityName
                   countryCode:(NSString *)countryCode
                    completion:(LocationSearchCompletion)completion;

/**
 *  Search for supplier location by IATA airport code
 *
 *  @param airportCode IATA Airport code
 *  @param completion If successful you get a VehicleSearchResponse, If failure an ErrorResponse will be returned
 */
- (void)locationSearchWithAirportCode:(NSString *)airportCode
                           completion:(LocationSearchCompletion)completion;

/**
 *  Search for supplier location by coordinates and radius
 *
 *  @param latitude     The latitude eg. 53.35
 *  @param longitude    The longitude eg. -6.23
 *  @param radius       The radius eg. 10
 *  @param distanceUnit The measurement units are KM
 *  @param completion If successful you get a VehicleSearchResponse, If failure an ErrorResponse will be returned
 */
- (void)locationSearchWithCoordinates:(NSNumber *)latitude
                            longitude:(NSNumber *)longitude
                               radius:(NSNumber *)radius
                         distanceUnit:(DistanceUnit)distanceUnit
                           completion:(LocationSearchCompletion)completion;


/**
 *  Requests car availability for a given time and location
 *
 *  @param pickupLocationCode  The pickup location code eg.71
 *  @param returnLocationCode  The return location code eg.71
 *  @param customerCountryCode Customers country code eg IE
 *  @param passengerQty        Number of passengers
 *  @param driverAge           The drivers age
 *  @param pickupDateTime      The pickup date and time
 *  @param returnDateTime      The return date and time
 *  @param currencyCode        The currency code eg EUR
 *  @param completion          If successful you get a VehicleAvailabilityResponse, If failure an ErrorResponse will be returned
 */
- (void)requestCarAvailabilityForLocation:(CTMatchedLocation *)pickupLocation
                       returnLocationCode:(CTMatchedLocation *)returnLocation
                      customerCountryCode:(NSString *)customerCountryCode
                             passengerQty:(NSNumber *)passengerQty
                                driverAge:(NSNumber *)driverAge
                           pickUpDateTime:(NSDate *)pickupDateTime
                           returnDateTime:(NSDate *)returnDateTime
                             currencyCode:(NSString *)currencyCode
                               completion:(RequestAvailabilityCompletion)completion;

/**
 *  Requests an insurance quote or a vehicle
 *
 *  @param homeCountry            The users home country eg. IE
 *  @param currency               The currency code eg. EUR
 *  @param totalCost              The total cost as string value eg 200.00
 *  @param pickupDateTime         The pickup date and time
 *  @param returnDateTime         The return date and time
 *  @param destinationCountryCode The destination country code eg. ES
 *  @param completion             Returns an Insurance object on successfull completion and ErrorResponse on fail
 */
- (void)requestInsuranceQuoteForVehicle:(NSString *)homeCountry
                               currency:(NSString *)currency
                              totalCost:(NSString *)totalCost
                         pickupDateTime:(NSDate *)pickupDateTime
                         returnDateTime:(NSDate *)returnDateTime
                 destinationCountryCode:(NSString *)destinationCountryCode
                             completion:(InsuranceQuoteCompletion)completion;


/**
 *  Requests to reserve a vehicle
 *
 *  @param pickupDateTime     The pickup date and time
 *  @param returnDateTime     The return date and time
 *  @param pickupLocationCode Pickup location code eg. 71
 *  @param returnLocationCode Return location code eg.71
 *  @param passengerQty       Passenger Qty
 *  @param flightNumber       The customer flight number, this is optional
 *  @param customer           Customer object
 *  @param car                Car Object
 *  @param extras             Car extras, this is optional. takes an array of ExtraEquipment objects
 *  @param card               PaymentCard object
 *  @param insuranceObject    InsuranceObject object, this is optional
 *  @param isBuyingInsurance  Bool stating if user is buying insurance
 *  @param completion         Returns a Booking object if successful and an ErrorResponse on fail
 */
- (void)reserveVehicle:(NSDate *)pickupDateTime
        returnDateTime:(NSDate *)returnDateTime
    pickupLocationCode:(NSString *)pickupLocationCode
    returnLocationCode:(NSString *)returnLocationCode
          passengerQty:(NSNumber *)passengerQty
          flightNumber:(NSString *)flightNumber
              customer:(CTCustomer *)customer
                   car:(CTCar *)car
                extras:(NSArray<CTExtraEquipment *> *)extras
              currency:(NSString *)currency
                  card:(CTPaymentCard *)card
       insuranceObject:(CTInsurance *)insuranceObject
     isBuyingInsurance:(BOOL)isBuyingInsurance
            completion:(ReserveVehicleCompletion)completion;

/**
 *  Requests the details for a booking
 *
 *  @param bookingEmailAddress The booking email address
 *  @param bookingRefID        The booking ref ID
 *  @param completion          Returns a Booking object if successful and an ErrorResponse on fail
 */
- (void)requestBookedVehicle:(NSString *)bookingEmailAddress
                bookingRefID:(NSString *)bookingRefID
                  completion:(BookingCompletion)completion;

/**
 *  Requests the terms and conditions for a vehicle rental
 *
 *  @param pickupDateTime     The pickup time and date
 *  @param returnDateTime     The return time and date
 *  @param pickupLocationCode The pickup location code eg. 71
 *  @param returnLocationCode The return location code eg. 71
 *  @param homeCountry        The customer home country code eg. IE
 *  @param car                The car object
 *  @param completion         Returns TermsAndConditions object on completion if successful and ErrorResponse if fail
 */
- (void)requestTermsAndConditions:(NSDate *)pickupDateTime
                   returnDateTime:(NSDate *)returnDateTime
               pickupLocationCode:(NSString *)pickupLocationCode
               returnLocationCode:(NSString *)returnLocationCode
                      homeCountry:(NSString *)homeCountry
                              car:(CTCar *)car
                       completion:(TermsAndConditionsCompletion)completion;

/**
 *  Cancel a booking
 *
 *  @param bookingRef         The booking reference ID
 *  @param title              The users name title eg. Mr.
 *  @param firstName          The users firstname
 *  @param surname            the users surname
 *  @param pickupDateTime     The pickup time and date
 *  @param dropoffDateTime    The drop off time and date
 *  @param pickupLocationCode The pickup location code eg. 71
 *  @param returnLocationCode The return location code eg. 71
 *  @param completion         If the booking is successfully canceled a YES bool value will be returned
                              If the cancel booking fails an error object is returned along with a NO bool value
 */
- (void)cancelBooking:(NSString *)bookingRef
                title:(NSString *)title
            firstName:(NSString *)firstName
              surname:(NSString *)surname
       pickupDateTime:(NSDate *)pickupDateTime
      dropoffDateTime:(NSDate *)dropoffDateTime
   pickupLocationCode:(NSString *)pickupLocationCode
   returnLocationCode:(NSString *)returnLocationCode
           completion:(ModifyCompletion)completion;

/**
 *  Email a booking
 *
 *  @param bookingRef Users booking reference
 *  @param email      Users email
 *  @param completion If the booking is successfully emailed a YES bool value will be returned
                      If the email booking fails an error object is returned along with a NO bool value */
- (void)emailBooking:(NSString *)bookingRef
               email:(NSString *)email
          completion:(ModifyCompletion)completion;

@end

