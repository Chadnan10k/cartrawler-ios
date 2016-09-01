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
#import "CTVehicle.h"
#import "CTPaymentCard.h"
#import "CTCustomer.h"
#import "CTBooking.h"
#import "CTTermsAndConditions.h"
#import "CTExtraEquipment.h"
#import "CTMatchedLocation.h"
#import "CTVendor.h"
#import "CTGroundLocation.h"
#import "CTAirport.h"
#import "CTGroundAvailability.h"
#import "CTGroundBooking.h" 
#import "CTGroundCustomer.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
#error CartrawlerAPI supports iOS7 and upwards
#endif

/**
 *  Use the Cartrawler iOS Framework to:
 *
 *  Book & search for rental vehicles
 *
 *  Book & search for ground transportation
 */
@interface CartrawlerAPI : NSObject

typedef void (^LocationSearchCompletion)(CTLocationSearch *response, CTErrorResponse *error);
typedef void (^RequestAvailabilityCompletion)(CTVehicleAvailability*response, CTErrorResponse *error);
typedef void (^InsuranceQuoteCompletion)(CTInsurance *response, CTErrorResponse *error);
typedef void (^ReserveVehicleCompletion)(CTBooking *response, CTErrorResponse *error);
typedef void (^TermsAndConditionsCompletion)(CTTermsAndConditions *response, CTErrorResponse *error);
typedef void (^BookingCompletion)(CTBooking *response, CTErrorResponse *error);
typedef void (^ModifyCompletion)(BOOL success, CTErrorResponse *error);
typedef void (^GroundAvailCompletion)(CTGroundAvailability *response, CTErrorResponse *error);
typedef void (^GroundBookingCompletion)(CTGroundBooking *response, CTErrorResponse *error);

/**
 *  Initialize the Cartrawler framework with your client API key
 *
 *  @param clientKey Your client API key
 *  @param debug Enable or disable test endpoints
 *  @param language The language identifer eg. EN
 */
- (id)initWithClientKey:(NSString *)clientKey language:(NSString *)language debug:(BOOL)debug;

/**
 *  Shows API requests and responses
 */
- (void)enableLogging:(BOOL)enabled;

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
 *  @param distanceUnitIsMiles Set true if you are using miles, false for KM
 *  @param completion If successful you get a VehicleSearchResponse, If failure an ErrorResponse will be returned
 */
- (void)locationSearchWithCoordinates:(NSNumber *)latitude
                            longitude:(NSNumber *)longitude
                               radius:(NSNumber *)radius
                  distanceUnitIsMiles:(BOOL)distanceUnitIsMiles
                           completion:(LocationSearchCompletion)completion;

#pragma mark Vehicle Booking
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
- (void)requestCarAvailabilityForLocation:(NSString *)pickupLocationCode
                       returnLocationCode:(NSString *)returnLocationCode
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
 *  @param completion         Returns a Booking object if successful and an ErrorResponse on fail
 */
- (void)reserveVehicle:(NSDate *)pickupDateTime
        returnDateTime:(NSDate *)returnDateTime
    pickupLocationCode:(NSString *)pickupLocationCode
    returnLocationCode:(NSString *)returnLocationCode
          passengerQty:(NSNumber *)passengerQty
          flightNumber:(NSString *)flightNumber
              customer:(CTCustomer *)customer
                   car:(CTVehicle *)car
                extras:(NSArray<CTExtraEquipment *> *)extras
              currency:(NSString *)currency
                  card:(CTPaymentCard *)card
       insuranceObject:(CTInsurance *)insuranceObject
            completion:(ReserveVehicleCompletion)completion;

#pragma mark Vehicle Services
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
                              car:(CTVehicle *)car
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
 *                            If the cancel booking fails an error object is returned along with a NO bool value
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
 *                    If the email booking fails an error object is returned along with a NO bool value
 */
- (void)emailBooking:(NSString *)bookingRef
               email:(NSString *)email
          completion:(ModifyCompletion)completion;

#pragma mark Ground Transportation

/**
 *  Gets a list of ground transportation services for a user
 *
 *  @param airport         Populated CTAirport object
 *  @param pickupLocation  Populated CTGroundLocation object for pickup
 *  @param dropoffLocation Populated CTGroundLocation object for drop off
 *  @param adultQty        The amount of adults needing transportation
 *  @param childQty        The amount of children needing transportation
 *  @param infantQty       The amount of infants needing transportation
 *  @param currencyCode    The currency code eg. EUR, GBP, USD
 *  @param completion      On completion a CTGroundAvailability object containing an array of services will be returned,
 *                         if no services are available a CTErrorResponse will be returned.
 */
- (void)groundTransportationAvail:(CTAirport *)airport
                   pickupLocation:(CTGroundLocation *)pickupLocation
                  dropoffLocation:(CTGroundLocation *)dropoffLocation
                         adultQty:(NSNumber *)adultQty
                         childQty:(NSNumber *)childQty
                        infantQty:(NSNumber *)infantQty
                     currencyCode:(NSString *)currencyCode
                       completion:(GroundAvailCompletion)completion;

/**
 *  Creates a Ground Transportation booking
 *
 *  @param airport                       The populated CTAirport object
 *  @param service                       The choosen CTGroundService object
 *  @param pickupLocation                Populated CTGroundLocation object for pickup
 *  @param dropoffLocation               Populated CTGroundLocation object for drop off
 *  @param pickupLocationName            The name of your pickup location, eg. a company name
 *  @param customer                      Populated CTGroundCustomer Object
 *  @param specialInstructions           Any special instructions a customer may give to the driver.
 *  @param flightNumber                  Customers flight number
 *  @param additionalAdultQty            The amount of *Additional* adults, dont include the customer making the booking
 *  @param childrenQty                   The amount of children traveling
 *  @param infantQty                     The amount of infants traveling
 *  @param currencyCode                  The currency code eg. EUR, GBP, USD
 *  @param completion                    On completion a CTGroundBooking will be returned if successfull, on fail a CTErrorResponse will be returned.
 */
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
                         completion:(GroundBookingCompletion)completion;

@end
