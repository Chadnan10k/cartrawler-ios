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
#import "Constants.h"
#import "CTInsurance.h"
#import "CTVendor.h"
#import "ImageResizeURL.h"
#import "NSDateUtils.h"
#import "CTPaymentCard.h"
#import "NetworkUtils.h"
#import "CTAvailabilityItem.h"

@interface VehicleBookingTests : XCTestCase

@property (nonatomic, strong) CartrawlerAPI *api;
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSDateComponents *pickupComp;
@property (nonatomic, strong) NSDateComponents *dropoffComp;
@property (nonatomic, strong) CTMatchedLocation *pickupLocation;
@property (nonatomic, strong) CTMatchedLocation *dropoffLocation;

@end

@implementation VehicleBookingTests

- (void)setUp
{
    
    _pickupComp = [[NSDateComponents alloc] init];
    [self.pickupComp setDay:4];
    [self.pickupComp  setMonth:9];
    [self.pickupComp  setYear:2016];
    [self.pickupComp  setHour:13];
    [self.pickupComp  setMinute:30];
    [self.pickupComp  setSecond:00];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _pickupDate = [gregorian dateFromComponents:self.pickupComp];
    
    _dropoffComp = [[NSDateComponents alloc] init];
    [self.dropoffComp setDay:6];
    [self.dropoffComp  setMonth:9];
    [self.dropoffComp  setYear:2016];
    [self.dropoffComp  setHour:13];
    [self.dropoffComp  setMinute:30];
    [self.dropoffComp  setSecond:00];
    
    _dropoffDate = [gregorian dateFromComponents: self.dropoffComp];
    
    _pickupLocation = [[CTMatchedLocation alloc] init];
    
    
    _api = [[CartrawlerAPI alloc] initWithClientKey:@"643826" language:@"EN" debug:YES];
    
    [self.api enableLogging:YES];
}

- (void)testIPAddress
{
    NSString *ipAddr = [NetworkUtils IPAddress];
    XCTAssertNotNil(ipAddr);
}

+(NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileName{
    NSString *filePath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:fileName];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

- (void)testCTInsuranceJSON
{
    CTInsurance *insurance = [[CTInsurance alloc] initFromDict:[VehicleBookingTests dictionaryWithContentsOfJSONString:@"InsuranceQuoteJSON.json"]];
    XCTAssertTrue([insurance.premiumCurrencyCode isEqualToString:@"EUR"]);
    XCTAssertTrue([insurance.costCurrencyCode isEqualToString:@"EUR"]);
    
    NSLog(@"%@", insurance.links[0].code);
    
    CTInsurance *USinsurance = [[CTInsurance alloc] initFromDict:[VehicleBookingTests dictionaryWithContentsOfJSONString:@"USInsurance.json"]];
    XCTAssertTrue([USinsurance.premiumCurrencyCode isEqualToString:@"USD"]);
    XCTAssertTrue([USinsurance.costCurrencyCode isEqualToString:@"USD"]);
}

- (void)testVehicleInsuranceQuote
{
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"testVehicleInsuranceQuote"];
    
    [self.api requestInsuranceQuoteForVehicle:@"IE"
                                     currency:@"EUR"
                                    totalCost:@"200.00"
                               pickupDateTime:self.pickupDate
                               returnDateTime:self.dropoffDate
                       destinationCountryCode:@"ES"
                                   completion:^(CTInsurance *response, CTErrorResponse *error) {
                                       if (error == nil) {
                                           XCTAssertTrue(![response.name isEqualToString:@""]);
                                           XCTAssertTrue([response.premiumCurrencyCode isEqualToString:@"EUR"]);
                                           XCTAssertTrue([response.costCurrencyCode isEqualToString:@"EUR"]);

                                           [expectation fulfill];
                                       } else {
                                           XCTAssertThrows(@"Error Present");
                                       }
                                   }
     ];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testReserveVehicle
{
    //This is dead for now
//    XCTestExpectation *expectation =
//    [self expectationWithDescription:@"testReserveVehicle"];
//    
//    [self.api requestVehicleAvailabilityForLocation:@"480"
//                                 returnLocationCode:@"480"
//                                customerCountryCode:@"IE"
//                                       passengerQty:@3
//                                          driverAge:@30
//                                     pickUpDateTime:self.pickupDate
//                                     returnDateTime:self.dropoffDate
//                                       currencyCode:@"EUR"
//                                         completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
//                                             if (error == nil) {
//
//                                                 [self.api reserveVehicle:self.pickupDate
//                                                           returnDateTime:self.dropoffDate
//                                                       pickupLocationCode:@"480"
//                                                       returnLocationCode:@"480"
//                                                             passengerQty:@3
//                                                             flightNumber:@"FR7777"
//                                                                 customer:[[CTCustomer alloc] initWithHomeCountry:@"IE"
//                                                                                                              age:@30
//                                                                                                        firstName:@"Lee"
//                                                                                                         lastName:@"M"
//                                                                                                            email:@"blah@burger.com"
//                                                                                                          address:@"23432, gfds"
//                                                                                                            phone:@"1234567"]
//                                                                      car:response.allVehicles.firstObject
//                                                                   extras:nil
//                                                                 currency:@"EUR"
//                                                                     card:[[CTPaymentCard alloc] initWithCardType:CardTypeVisa
//                                                                                                       cardNumber:@"4111111111111111"
//                                                                                                       cardExpiry:@"0822"
//                                                                                                   cardHolderName:@"Lee M"
//                                                                                                          cardCvc:@"333"]
//                                                          insuranceObject:nil
//                                                               completion:^(CTBooking *response, CTErrorResponse *error) {
//                                                                   if (error) {
//                                                                       NSLog(@"FAIL");
//                                                                   }
//                                                                   
//                                                                   if (response) {
//                                                                       NSLog(@"SUCCESS");
//                                                                   }
//                                                                   [expectation fulfill];
//
//                                                               }];
//    
//                                             } else {
//                                                 NSLog(@"%@", error.errorMessage);
//                                                 XCTAssertTrue(error != nil);
//                                             }
//                                         }];
//    
//    [self waitForExpectationsWithTimeout:20.0 handler:^(NSError *error) {
//        if (error) {
//            NSLog(@"Timeout Error: %@", error);
//        }
//    }];
}

- (void)testVehicleAvail
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

- (void)testVehicleAvailJson
{
    CTVehicleAvailability *avail = [[CTVehicleAvailability alloc] initFromVehAvailRSCoreDictionary:[VehicleBookingTests dictionaryWithContentsOfJSONString:@"VehAvailJSON.json"]];
//    CTVendor *vendor = avail.availableVendors.firstObject;
//    CTVehicle *vehicle = vendor.availableCars.firstObject;
//    CTVendorRating *rating = vehicle.vendor.rating;
    
//    XCTAssertTrue(avail.availableVendors > 0);
//    XCTAssertTrue(rating.totalReviews.intValue == 3614);
//    XCTAssertTrue([rating.vendorName isEqualToString:@"EUROPCAR Corporate"]);
}

- (void)testVehicleBookingJSON
{
    CTBooking *booking = [[CTBooking alloc] initFromVehReservationDictionary:[VehicleBookingTests dictionaryWithContentsOfJSONString:@"BookVehicleJSON.json"]];
    XCTAssertTrue([booking.tpaConfID isEqualToString:@"CT-Test1464791167621"]);
    
    CTBooking *retRestBooking = [[CTBooking alloc] initFromRetrievedBookingDictionary:[VehicleBookingTests dictionaryWithContentsOfJSONString:@"RetRes.json"]];
    XCTAssertTrue([retRestBooking.customerEmail isEqualToString:@"HHHH@BBBB.NJNN"]);
}

- (void)testTermsAndConditions
{
    CTTermsAndConditions *terms = [[CTTermsAndConditions alloc] initFromAPIResponse:[VehicleBookingTests dictionaryWithContentsOfJSONString:@"TermsAndCond.json"]];
    XCTAssertTrue(terms.termsAndConditions.count > 0);
    XCTAssertTrue([terms.termsAndConditions[0].titleText isEqualToString:@"Included in the Price"]);
}
@end
