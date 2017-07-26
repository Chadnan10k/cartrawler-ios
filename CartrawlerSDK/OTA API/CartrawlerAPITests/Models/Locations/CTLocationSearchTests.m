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

@interface CTLocationSearchTests : XCTestCase

@property (nonatomic, strong) CartrawlerAPI *api;
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSDateComponents *pickupComp;
@property (nonatomic, strong) NSDateComponents *dropoffComp;
@property (nonatomic, strong) CTMatchedLocation *pickupLocation;
@property (nonatomic, strong) CTMatchedLocation *dropoffLocation;

@end

@implementation CTLocationSearchTests
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

- (void)test_CTLocationSearch_jsonInit
{
    NSDictionary *valueDictA = [self dictionaryWithContentsOfJSONString:@"PartialTextRS.json"];
    CTLocationSearch *partialTextSearchA = [[CTLocationSearch alloc] initWithPartialTextDictionary:valueDictA];
    
    XCTAssertNotNil(partialTextSearchA.matchedLocations);
    XCTAssert(partialTextSearchA.matchedLocations.count > 0);
    
    NSDictionary *valueDictB = [self dictionaryWithContentsOfJSONString:@"CitySearchRS.json"];
    CTLocationSearch *partialTextSearchB = [[CTLocationSearch alloc] initWithDictionary:valueDictB];
    
    XCTAssertNotNil(partialTextSearchB.matchedLocations);
    XCTAssert(partialTextSearchB.matchedLocations.count > 0);
    
    NSDictionary *valueDictC = [self dictionaryWithContentsOfJSONString:@"IATALocationSearchRS.json"];
    CTLocationSearch *partialTextSearchC = [[CTLocationSearch alloc] initWithDictionary:valueDictC];
    
    XCTAssertNotNil(partialTextSearchC.matchedLocations);
    XCTAssert(partialTextSearchC.matchedLocations.count > 0);
}

- (void)test_CTMatchedLocation_jsonInit
{
    NSDictionary *valueDictA = [self dictionaryWithContentsOfJSONString:@"LocationResult.json"];

    CTMatchedLocation *matchedLocationA = [[CTMatchedLocation alloc] initWithDictionary:valueDictA];
    
    XCTAssertTrue(matchedLocationA.isAtAirport);
    XCTAssertTrue([matchedLocationA.airportCode isEqualToString:@""]);
    XCTAssertTrue([matchedLocationA.code isEqualToString:@"338"]);
    XCTAssertTrue([matchedLocationA.name isEqualToString:@"Orlando - Airport (Florida)"]);
    XCTAssertTrue([matchedLocationA.countryCode isEqualToString:@"US"]);
    XCTAssertTrue([matchedLocationA.addressLine isEqualToString:@""]);
    XCTAssertTrue(matchedLocationA.latitude.doubleValue == 0.0);
    XCTAssertTrue(matchedLocationA.longitude.doubleValue == 0.0);
    XCTAssertTrue(matchedLocationA.distance.doubleValue == 0.0);
    XCTAssertTrue([matchedLocationA.distanceUnit isEqualToString:@""]);
    
    NSDictionary *valueDictB = [self dictionaryWithContentsOfJSONString:@"PartialTextLocationResult.json"];
    
    CTMatchedLocation *matchedLocationB = [[CTMatchedLocation alloc] initWithPartialStringDictionary:valueDictB];
    
    XCTAssertTrue(matchedLocationB.isAtAirport);
    XCTAssertTrue([matchedLocationB.airportCode isEqualToString:@"DUB"]);
    XCTAssertTrue([matchedLocationB.code isEqualToString:@"11"]);
    XCTAssertTrue([matchedLocationB.name isEqualToString:@"Dublin - Airport"]);
    XCTAssertTrue([matchedLocationB.countryCode isEqualToString:@"IE"]);
    XCTAssertTrue([matchedLocationB.addressLine isEqualToString:@""]);
    XCTAssertTrue(matchedLocationB.latitude.doubleValue == 0.0);
    XCTAssertTrue(matchedLocationB.longitude.doubleValue == 0.0);
    XCTAssertTrue(matchedLocationB.distance.doubleValue == 0.0);
    XCTAssertTrue([matchedLocationB.distanceUnit isEqualToString:@""]);
    
    XCTAssertNotNil(matchedLocationA.airportCode);
    XCTAssertNotNil(matchedLocationA.code);
    XCTAssertNotNil(matchedLocationA.name);
    XCTAssertNotNil(matchedLocationA.countryCode);
    XCTAssertNotNil(matchedLocationA.addressLine);
    XCTAssertNotNil(matchedLocationA.addressStateCode);
    XCTAssertNotNil(matchedLocationA.latitude);
    XCTAssertNotNil(matchedLocationA.longitude);
    XCTAssertNotNil(matchedLocationA.distance);
    XCTAssertNotNil(matchedLocationA.distanceUnit);
    
    XCTAssertNotNil(matchedLocationB.airportCode);
    XCTAssertNotNil(matchedLocationB.code);
    XCTAssertNotNil(matchedLocationB.name);
    XCTAssertNotNil(matchedLocationB.countryCode);
    XCTAssertNotNil(matchedLocationB.addressLine);
    XCTAssertNotNil(matchedLocationB.addressStateCode);
    XCTAssertNotNil(matchedLocationB.latitude);
    XCTAssertNotNil(matchedLocationB.longitude);
    XCTAssertNotNil(matchedLocationB.distance);
    XCTAssertNotNil(matchedLocationB.distanceUnit);

}

- (NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileName
{
    NSString *filePath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:fileName];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}


@end
