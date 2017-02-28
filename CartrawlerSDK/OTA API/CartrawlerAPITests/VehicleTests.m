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

    //XCTAssertTrue([item.vendor.uniqueID isEqualToString:@"601487947145523"]);

    
    
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
