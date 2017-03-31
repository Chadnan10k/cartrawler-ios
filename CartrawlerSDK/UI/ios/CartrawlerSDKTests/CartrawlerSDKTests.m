//
//  CartrawlerSDKTests.m
//  CartrawlerSDKTests
//
//  Created by Lee Maguire on 30/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CTPassenger.h"

@interface CartrawlerSDKTests : XCTestCase

@end

@implementation CartrawlerSDKTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)test_CTPassenger
{
    CTPassenger *passenger = [CTPassenger passengerWithFirstName:@"Lee"
                                                        lastName:@"Maguire"
                                                    addressLine1:@"123 Cartrawler St"
                                                    addressLine2:nil
                                                            city:@"Dundrum"
                                                        postcode:@"D18"
                                                     countryCode:@"IE"
                                                             age:@21
                                                           email:nil
                                                           phone:nil
                                                 isPrimaryDriver:YES];
    
    XCTAssertTrue([passenger.firstName isEqualToString:@"Lee"]);
    XCTAssertTrue([passenger.lastName isEqualToString:@"Maguire"]);
    XCTAssertTrue([passenger.addressLine1 isEqualToString:@"123 Cartrawler St"]);
    XCTAssertTrue([passenger.addressLine2 isEqualToString:@""]);
    XCTAssertTrue([passenger.city isEqualToString:@"Dundrum"]);
    XCTAssertTrue([passenger.postcode isEqualToString:@"D18"]);
    XCTAssertTrue([passenger.countryCode isEqualToString:@"IE"]);
    XCTAssertTrue(passenger.age.intValue == 21);
    XCTAssertTrue(passenger.isPrimaryDriver);
    XCTAssertTrue([passenger.email isEqualToString:@""]);
    XCTAssertTrue([passenger.phone isEqualToString:@""]);

}

@end
