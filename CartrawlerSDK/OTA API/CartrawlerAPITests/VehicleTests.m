//
//  VehicleBookingTests.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 01/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "CartrawlerAPI.h"
#import "CTRequestBuilder.h"
#import "CTInsurance.h"
#import "CTVendor.h"
#import "CTPaymentCard.h"
#import "CTAvailabilityItem.h"

@interface VehicleTests : XCTestCase

@property (nonatomic, strong) CartrawlerAPI *api;
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSDateComponents *pickupComp;
@property (nonatomic, strong) NSDateComponents *dropoffComp;

@end

@implementation VehicleTests

- (void)setUp
{
    
    _pickupComp = [[NSDateComponents alloc] init];
    [self.pickupComp setDay:4];
    [self.pickupComp  setMonth:9];
    [self.pickupComp  setYear:2017];
    [self.pickupComp  setHour:13];
    [self.pickupComp  setMinute:30];
    [self.pickupComp  setSecond:00];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _pickupDate = [gregorian dateFromComponents:self.pickupComp];
    
    _dropoffComp = [[NSDateComponents alloc] init];
    [self.dropoffComp setDay:6];
    [self.dropoffComp  setMonth:9];
    [self.dropoffComp  setYear:2017];
    [self.dropoffComp  setHour:13];
    [self.dropoffComp  setMinute:30];
    [self.dropoffComp  setSecond:00];
    
    _dropoffDate = [gregorian dateFromComponents: self.dropoffComp];
    
    _api = [[CartrawlerAPI alloc] initWithClientKey:@"642619" language:@"EN" debug:YES];
    
    [self.api enableLogging:YES];
}

- (void)test_newSession
{
    
    NSDictionary *sessionDict = [self dictionaryWithContentsOfJSONString:@"CT_IPToCountry_RS.json"];
    
    CT_IpToCountryRS *session = [[CT_IpToCountryRS alloc] initFromDictionary:sessionDict];
    
    XCTAssertTrue([session.ipAddress isEqualToString:@"192.168.105.111"]);
    XCTAssertTrue([session.customerID isEqualToString:@"601487838120441"]);
    XCTAssertTrue([session.engineLoadID isEqualToString:@"601487838120441"]);

    
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"testNewSession"];
    
    [self.api requestNewSession:@"EUR"
                   languageCode:@"EN"
                    countryCode:@"IE"
                     completion:^(CT_IpToCountryRS *response, CTErrorResponse *error) {
                         if (response) {
                             
                             XCTAssertTrue(![response.ipAddress isEqualToString:@""]);
                             XCTAssertTrue(![response.customerID isEqualToString:@""]);
                             XCTAssertTrue(![response.engineLoadID isEqualToString:@""]);

                             [expectation fulfill];
                         } 
                     }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)test_vehicleAvailability_jsonInit
{
    
    NSDictionary *availDict = [self dictionaryWithContentsOfJSONString:@"VehAvailJSON.json"];
    
    CTVehicleAvailability *avail = [[CTVehicleAvailability alloc] initFromVehAvailRSCoreDictionary:availDict];
    
    XCTAssertTrue([avail.puLocationCode isEqualToString:@"191"]);
    XCTAssertTrue([avail.doLocationCode isEqualToString:@"191"]);
    XCTAssertTrue([avail.puDate isEqualToString:@"2017-02-28T11:42:44Z"]);
    XCTAssertTrue([avail.doDate isEqualToString:@"2017-03-03T11:42:44Z"]);
    XCTAssertTrue([avail.puLocationName isEqualToString:@"London - Airport - Gatwick"]);
    XCTAssertTrue([avail.doLocationName isEqualToString:@"London - Airport - Gatwick"]);

    CTAvailabilityItem *item = avail.items.firstObject;
    
    XCTAssertTrue([item.engineInfo.engineLoadID isEqualToString:@"601487947145524"]);
    XCTAssertTrue([item.engineInfo.queryID isEqualToString:@"601487947145531"]);
    XCTAssertTrue([item.engineInfo.uniqueID isEqualToString:@"601487947145523"]);
    
    XCTAssertTrue([item.vendor.code isEqualToString:@"2686"]);
    XCTAssertTrue([item.vendor.division isEqualToString:@"GREEN MOTION"]);
    XCTAssertTrue([item.vendor.logoURL.absoluteString isEqualToString:@"https://cdn.cartrawler.com/otaimages/vendor/large/Green_Motion.jpg"]);
    
    XCTAssertTrue(item.vendor.rating.averageWaitTime.integerValue == 16);
    XCTAssertTrue(item.vendor.rating.carReview.integerValue == 76);
    XCTAssertTrue(item.vendor.rating.deskReview.integerValue == 63);
    XCTAssertTrue(item.vendor.rating.locationCode.integerValue == 638006);
    XCTAssertTrue([item.vendor.rating.vendorName isEqualToString:@"Green Motion Corporate "]);
    XCTAssertTrue(item.vendor.rating.overallScore.doubleValue == 3.24);
    XCTAssertTrue(item.vendor.rating.pickupScore.integerValue == 64);
    XCTAssertTrue(item.vendor.rating.priceScore.integerValue == 52);
    XCTAssertTrue(item.vendor.rating.totalScore.integerValue == 68);
    XCTAssertTrue(item.vendor.rating.totalReviews.integerValue == 5482);
    XCTAssertTrue(item.vendor.rating.waitTime.integerValue == 1);
    XCTAssertTrue(item.vendor.pickupLocation.atAirport);

    XCTAssertTrue(item.vendor.pickupLocation.pickupType == PickupTypeShuttleBus);
    XCTAssertTrue(item.vendor.pickupLocation.locationType == VendorLocationTypeTerminal);
    XCTAssertTrue([item.vendor.pickupLocation.locationCode isEqualToString:@"191"]);
    XCTAssertTrue([item.vendor.pickupLocation.locationName isEqualToString:@"London - Airport - Gatwick"]);
    XCTAssertTrue([item.vendor.pickupLocation.address isEqualToString:@"Gatwick Business Park, Kennel Lane, Hookwood, Horley, RH6 OAY"]);
    XCTAssertTrue([item.vendor.pickupLocation.countryCode isEqualToString:@"GB"]);
    XCTAssertTrue([item.vendor.pickupLocation.phone isEqualToString:@"+44 01293 855100 /+44 (0) 333 888 4000 option 1"]);
    
    

    
    
    
//    
//    @property (nonatomic, nonnull, readonly) NSNumber *orderIndex;
//    /**
//     *  Bool value if vehicle requires payment card information or not
//     */
//    @property (nonatomic, readonly) BOOL needCCInfo;
//    /**
//     *  Bool value showing if insurance is available for this vehicle
//     */
//    @property (nonatomic, readonly) BOOL insuranceAvailable;
//    /**
//     *  Bool value stating if vehicle is available or not
//     */
//    @property (nonatomic, readonly) BOOL isAvailable;
//    /**
//     *  Bool value stating if vehicle is air conditioned or not
//     */
//    @property (nonatomic, readonly) BOOL isAirConditioned;
//    /**
//     *  Passenger quantity vehicle can take
//     */
//    @property (nonatomic, nonnull, readonly) NSNumber *passengerQty;
//    /**
//     *  Int value representing the vehicle class size
//     */
//    @property (nonatomic, readonly) NSInteger classSize;
//    /**
//     *  The total base price for this vehicle
//     */
//    @property (nonatomic, nonnull, readonly) NSNumber *totalPriceForThisVehicle;
//    /**
//     *  The transmission type of the vehicle
//     */
//    @property (nonatomic, nonnull, readonly) NSString *transmissionType;
//    /**
//     *  The fuel type of the vehicle
//     */
//    @property (nonatomic, nonnull, readonly) NSString *fuelType;
//    /**
//     *  The vehicles fuel policy description
//     */
//    @property (nonatomic, nonnull, readonly) NSString *fuelPolicyDescription;
//    /**
//     *  Fuel policy enum
//     */
//    @property (nonatomic) FuelPolicy fuelPolicy;
//    /**
//     *  The vehicles drive type
//     */
//    @property (nonatomic, nonnull, readonly) NSString *driveType;
//    /**
//     *  The quantity of the amount of baggage the vehicle can hold
//     */
//    @property (nonatomic, nonnull, readonly) NSNumber *baggageQty;
//    /**
//     *  The vehicles ID code
//     */
//    @property (nonatomic, nonnull, readonly) NSString *code;
//    /**
//     *  The vehicle code context
//     */
//    @property (nonatomic, nonnull, readonly) NSString *codeContext;
//    /**
//     *  The vehicle category description
//     */
//    @property (nonatomic, readonly) VehicleSize size;
//    /**
//     *  Vehicle category code
//     */
//    @property (nonatomic, nonnull, readonly) NSString *sizeCode;
//    /**
//     *  The number of doors the vehicle has
//     */
//    @property (nonatomic, nonnull, readonly) NSNumber *doorCount;
//    /**
//     *  The make / model name of the vehicle
//     */
//    @property (nonatomic, nonnull, readonly) NSString *makeModelName;
//    /**
//     *  Trailing 'or similar' text of vehicle name
//     */
//    @property (nonatomic, nullable, readonly) NSString *orSimilar;
//    
//    /**
//     *  The make / model code of the vehicle
//     */
//    @property (nonatomic, nonnull, readonly) NSString *makeModelCode;
//    /**
//     *  Picture url for the vehicle
//     */
//    @property (nonatomic, nonnull, readonly) NSURL *pictureURL;
//    /**
//     *  Vehicle asset number
//     */
//    @property (nonatomic, nonnull, readonly) NSString *vehicleAssetNumber;
//    /**
//     *  Rate qualifier
//     */
//    @property (nonatomic, nonnull, readonly) NSString *rateQualifier;
//    /**
//     *  Rate total amount
//     */
//    @property (nonatomic, nonnull, readonly) NSString *rateTotalAmount;
//    /**
//     *  Estimated total amount for vehicle
//     */
//    @property (nonatomic, nonnull, readonly) NSNumber *estimatedTotalAmount;
//    /**
//     *  Currency code for vehicle cost
//     */
//    @property (nonatomic, nonnull, readonly) NSString *currencyCode;
//    /**
//     *  Vehicle reference type
//     */
//    @property (nonatomic, nonnull, readonly) NSString *refType;
//    /**
//     *  Vehicle reference ID
//     */
//    @property (nonatomic, nonnull, readonly) NSString *refID;
//    /**
//     *  Vehicle reference ID context
//     */
//    @property (nonatomic, nonnull, readonly) NSString *refIDContext;
//    /**
//     *  Vehicle reference time tamp
//     */
//    @property (nonatomic, nonnull, readonly) NSString *refTimeStamp;
//    /**
//     *  Vehicle reference URL
//     */
//    @property (nonatomic, nonnull, readonly) NSString *refURL;
//    /**
//     *  Rental duration
//     */
//    @property (nonatomic, nonnull, readonly) NSString *rentalDuration;
//    /**
//     *  Currency exchanage rate
//     */
//    @property (nonatomic, nonnull, readonly) NSString *currencyExchangeRate;
//    /**
//     *  Currency exchange rate
//     */
//    @property (nonatomic, nonnull, readonly) NSString *currencyExchangeRate23;
//    /**
//     *  Array of available equipment for vehicle
//     */
//    @property (nonatomic, nonnull, readonly) NSArray<CTExtraEquipment *> *extraEquipment;
//    /**
//     *  Array of fees for vehicle
//     */
//    @property (nonatomic, nonnull, readonly) NSArray<CTFee *> *fees;
//    /**
//     *  Array of charges for vehicle
//     */
//    @property (nonatomic, nonnull, readonly) NSArray<CTVehicleCharge *> *vehicleCharges;
//    /**
//     *  Array of priced coverages for vehicle
//     */
//    @property (nonatomic, nonnull, readonly) NSArray<CTPricedCoverage *> *pricedCoverages;
//    
//    @property (nonatomic, nonnull, readonly) CTVehicleIndexation *indexation;
//    
//    @property (nonatomic, nonnull, readonly) NSArray <CTSpecialOffer *> *specialOffers;
//    
//    @property (nonatomic, nonnull, readonly) CTVehicleConfig *config;
//    
//    
//    
    
    
    
    
    
    NSLog(@"%@", avail);
    
}


- (void)test_VehicleAvailRQ
{
    
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"testVehicleAvail"];
    
    [self.api requestVehicleAvailabilityForLocation:@"480"
                             returnLocationCode:@"480"
                            customerCountryCode:@"IE"
                                   passengerQty:@3
                                      driverAge:@30
                                 pickUpDateTime:self.pickupDate
                                 returnDateTime:self.dropoffDate
                                   currencyCode:@"EUR"
                                     completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                         if (error == nil) {
                                             XCTAssertTrue(response.items.count > 0);

                                             for (CTAvailabilityItem *v in response.items) {
                                                 XCTAssertNotNil(v.vendor.pickupLocation);
                                                 XCTAssertNotNil(v.vendor.dropoffLocation);
                                                 XCTAssertNotNil(v.vehicle.sizeCode);
                                             }
                                             
                                             [expectation fulfill];
                                         } else {
                                             NSLog(@"%@", error.errorMessage);
                                             XCTAssertTrue(error == nil);
                                         }
                                     }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileName{
    NSString *filePath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:fileName];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end
