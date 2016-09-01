//
//  GTTests.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 02/06/2016.
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

@interface GTTests : XCTestCase

@property (nonatomic, strong) CartrawlerAPI *api;
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSDateComponents *pickupComp;
@property (nonatomic, strong) NSDateComponents *dropoffComp;
@property (nonatomic, strong) CTMatchedLocation *pickupLocation;
@property (nonatomic, strong) CTMatchedLocation *dropoffLocation;

@end

@implementation GTTests

- (void)setUp
{
    
    _pickupComp = [[NSDateComponents alloc] init];
    [self.pickupComp setDay:14];
    [self.pickupComp  setMonth:8];
    [self.pickupComp  setYear:2016];
    [self.pickupComp  setHour:13];
    [self.pickupComp  setMinute:30];
    [self.pickupComp  setSecond:00];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _pickupDate = [gregorian dateFromComponents:self.pickupComp];
    
    _dropoffComp = [[NSDateComponents alloc] init];
    [self.dropoffComp setDay:14];
    [self.dropoffComp  setMonth:8];
    [self.dropoffComp  setYear:2016];
    [self.dropoffComp  setHour:14];
    [self.dropoffComp  setMinute:30];
    [self.dropoffComp  setSecond:00];
    
    _dropoffDate = [gregorian dateFromComponents: self.dropoffComp];
    
    _pickupLocation = [[CTMatchedLocation alloc] init];
    
    
    _api = [[CartrawlerAPI alloc] initWithClientKey:@"68622" language:@"EN" debug:YES];
    
    [self.api enableLogging:YES];
}

- (void)testGroundAvail
{
    
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"testGroundAvail"];
    
    CTAirport *airport = [[CTAirport alloc] initWithFlightType:FlightTypeDeparture IATACode:@"DUB" terminalNumber:@"2"];
    
    CTGroundLocation *pickup = [[CTGroundLocation alloc] initWithLatitude:@53.42600
                                                                longitude:@-6.2440
                                                             locationType:LocationTypeCompany
                                                                 dateTime:self.pickupDate];
    
    CTGroundLocation *dropoff = [[CTGroundLocation alloc] initWithLatitude:@53.28913
                                                                 longitude:@-6.24326
                                                              locationType:LocationTypeAirport
                                                                  dateTime:nil];
    [self.api groundTransportationAvail:airport
                         pickupLocation:pickup
                        dropoffLocation:dropoff
                airportIsPickupLocation:NO
                               adultQty:@1
                               childQty:@0
                              infantQty:@0
                           currencyCode:@"EUR"
                             completion:^(CTGroundAvailability *response, CTErrorResponse *error) {
                                 if (error == nil) {
                                     [expectation fulfill];
                                 } else {
                                     NSLog(@"%@", error.errorMessage);
                                 }
                                 XCTAssertNil(error);
                             }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testGroundAvailJson
{
    CTGroundAvailability *avail = [[CTGroundAvailability alloc] initWithDictionary:[GTTests dictionaryWithContentsOfJSONString:@"GroundAvailRSJSON.json"]];
    NSLog(@"%@", avail);
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

@end
