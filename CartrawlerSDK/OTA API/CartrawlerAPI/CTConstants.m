//
//  Constants.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 11/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTConstants.h"

@implementation CTConstants

NSString *const CTHeader = @"CTHeader";
NSString *const CTMobileHeader = @"CTMobileHeader";
NSString *const CTInsuranceHeader = @"CTInsuranceHeader";
NSString *const CTCancelHeader = @"CTCancelHeader";
NSString *const CTRentalReqHeader = @"CTRentalReqHeader";
NSString *const CTGetExistingBookingHeader = @"CTGetExistingBookingHeader";
NSString *const CTLocationSearchHeader = @"CTLocationHeader";
NSString *const CTLocationGTSearchHeader = @"CTLocationHeaderGT";
NSString *const CTGroundTransportHeader = @"CTGroundTransportHeader";

NSString *const CTTestInternalAPI = @"http://internal-dev.cartrawler.com/cartrawlerota/json?type=";
NSString *const CTTestAPI = @"http://external-dev.cartrawler.com/cartrawlerota/json?type=";
NSString *const CTTestAPISecure = @"https://external-dev.cartrawler.com/cartrawlerpay/json?sec=true&type=";
NSString *const CTTestTarget = @"Test";

//NSString *const CTTestInternalAPI = @"http://localhost:8080/cartrawlerota/json?type=";
//NSString *const CTTestAPI = @"http://localhost:8080/cartrawlerota/json?type=";
//NSString *const CTTestAPISecure = @"http://localhost:8080/cartrawlerpay/json?sec=true&type=";
//NSString *const CTTestTarget = @"Test";

NSString *const CTProductionAPI = @"https://otageo.cartrawler.com/cartrawlerota/json?type=";
NSString *const CTProductionAPISecure = @"https://otasecure.cartrawler.com/cartrawlerpay/json?sec=true&type=";
NSString *const CTProductionTarget = @"Production";

NSString *const CTDateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
NSString *const CTAvailRequestDateFormat = @"yyyy-MM-dd'T'HH:mm:ss";

@end
