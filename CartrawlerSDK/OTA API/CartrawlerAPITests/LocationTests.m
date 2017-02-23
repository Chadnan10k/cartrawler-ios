//
//  LocationTests.m
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

@interface LocationTests : XCTestCase

@property (nonatomic, strong) CartrawlerAPI *api;
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSDateComponents *pickupComp;
@property (nonatomic, strong) NSDateComponents *dropoffComp;
@property (nonatomic, strong) CTMatchedLocation *pickupLocation;
@property (nonatomic, strong) CTMatchedLocation *dropoffLocation;

@end

@implementation LocationTests
- (void)setUp
{
    _pickupComp = [[NSDateComponents alloc] init];
    [self.pickupComp setDay:1];
    [self.pickupComp  setMonth:6];
    [self.pickupComp  setYear:2016];
    [self.pickupComp  setHour:13];
    [self.pickupComp  setMinute:30];
    [self.pickupComp  setSecond:00];

    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _pickupDate = [gregorian dateFromComponents:self.pickupComp];

    _dropoffComp = [[NSDateComponents alloc] init];
    [self.dropoffComp setDay:6];
    [self.dropoffComp  setMonth:7];
    [self.dropoffComp  setYear:2016];
    [self.dropoffComp  setHour:13];
    [self.dropoffComp  setMinute:30];
    [self.dropoffComp  setSecond:00];

    _dropoffDate = [gregorian dateFromComponents: self.dropoffComp];

    _pickupLocation = [[CTMatchedLocation alloc] init];


    _api = [[CartrawlerAPI alloc] initWithClientKey:@"68622" language:@"EN" debug:YES];

    [self.api enableLogging:YES];
}


- (void)testLocationSearchWithPartialString
{
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"LocationSearchWithPartialString"];
    
    [self.api locationSearchWithPartialString:@"Dubl"
                             needsCoordinates:NO
                                   completion:^(CTLocationSearch *response, CTErrorResponse *error) {
                                       if (error == nil) {
                                           XCTAssert(response.matchedLocations.count > 0);
                                           [expectation fulfill];
                                       }
                                   }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testLocationSearchWithCity
{
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"LocationSearchWithCity"];
    
    [self.api locationSearchWithCity:@"Dublin"
                         countryCode:@"IE"
                          completion:^(CTLocationSearch *response, CTErrorResponse *error) {
                              XCTAssert(response.matchedLocations.count > 0);
                              [expectation fulfill];
                          }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testLocationSearchWithAirport
{
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"LocationSearchWithAirport"];
    
    [self.api locationSearchWithAirportCode:@"MCO" completion:^(CTLocationSearch *response, CTErrorResponse *error) {
        XCTAssert(response.matchedLocations.count > 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testLocationSearchWithCoordinates
{
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"LocationSearchWithCoordinates"];
    
    [self.api locationSearchWithCoordinates:@53.35
                                  longitude:@-6.23
                                     radius:@100
                        distanceUnitIsMiles:YES
                                 completion:^(CTLocationSearch *response, CTErrorResponse *error) {
                                     XCTAssert(response.matchedLocations.count > 0);
                                     [expectation fulfill];
                                 }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}


@end
