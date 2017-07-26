//
//  CTPassengerTests.m
//  CartrawlerSDK
//
//  Created by Alessandro Santos Pinto on 20/07/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CTPassenger.h"

@interface CTPassengerTests : XCTestCase

@end

@implementation CTPassengerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)testCreatePassenger {
	CTPassenger *passenger = [CTPassenger passengerWithFirstName:@"John"
														lastName:@"Smith"
													addressLine1:@"123 Cartrawler St"
													addressLine2:nil
															city:@"Dundrum"
														postcode:@"D18"
													 countryCode:@"IE"
															 age:@30
														   email:nil
														   phone:nil
												 isPrimaryDriver:NO];
	
	XCTAssertNotNil(passenger, @"");
	XCTAssertEqual(passenger.firstName, @"John");
	XCTAssertEqual(passenger.lastName, @"Smith");
	XCTAssertEqual(passenger.addressLine1, @"123 Cartrawler St");
	XCTAssertTrue([passenger.addressLine2 isEqualToString:@""], @"");
	XCTAssertEqual(passenger.city, @"Dundrum");
	XCTAssertEqual(passenger.postcode, @"D18");
	XCTAssertEqual(passenger.countryCode, @"IE");
	XCTAssertEqual(passenger.age, @30);
	XCTAssertTrue([passenger.phone isEqualToString:@""], @"");
	XCTAssertTrue([passenger.addressLine2 isEqualToString:@""], @"");
	XCTAssertEqual(passenger.isPrimaryDriver, NO, @"");
}

@end
