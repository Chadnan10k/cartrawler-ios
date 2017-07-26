//
//  CTPaymentRequestGeneratorTests.m
//  CartrawlerSDK
//
//  Created by Alessandro Santos Pinto on 25/07/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CTPaymentRequestGenerator.h"
#import "CTSDKSettings.h"
#import "CTRentalSearch.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface CTPaymentRequestGeneratorTests : XCTestCase

@property (strong, nonatomic) CTRentalSearch *search;

@end

@implementation CTPaymentRequestGeneratorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
	
	
	CTVehicle *vehicle = [[CTVehicle alloc] initFromDictionary:@{@"":@""}];
	CTMatchedLocation *pLocation = [[CTMatchedLocation alloc] initWithDictionary:@{@"":@""}];
	self.search = [[CTRentalSearch alloc] init];
	self.search.pickupDate = [NSDate dateWithTimeIntervalSinceNow:186400];
	self.search.dropoffDate = [NSDate dateWithTimeIntervalSinceNow:186400];
	self.search.driverAge = @30;
	self.search.passengerQty = @1;
	self.search.flightNumber = @"AB123";
	self.search.firstName = @"Dsadsadsad";
	self.search.surname = @"Dsadsadasd";
	self.search.email = @"Dsadasdsa@dsadas.com";
	self.search.city = @"";
	self.search.postcode = @"";
	self.search.phone = @"2132321321";
	self.search.insurance = nil;
	self.search.isBuyingInsurance = NO;
}

- (void) testShouldFailWithInvalidParameters {

	NSString *req = [CTPaymentRequestGenerator requestFromSearch:self.search];
	
}

@end
