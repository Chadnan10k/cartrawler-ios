//
// Copyright 2014 Etrawler
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
//  Vendor.h
//  CarTrawler
//
//

#import <Foundation/Foundation.h>
#import "CTVehicle.h"
#import "CTVendorRating.h"

/**
 *  CTVendor
 */
@interface CTVendor : NSObject

/**
 *  Bool value stating if vendor is at airport or not
 */
@property (nonatomic) BOOL atAirport;
/**
 *  The vendor code
 */
@property (nonatomic, strong) NSString *vendorCode;
/**
 *  The vendor name
 */
@property (nonatomic, strong) NSString *vendorName;
/**
 *  The vendor division
 */
@property (nonatomic, strong) NSString *vendorDivision;
/**
 *  Picture url for the vendor logo
 */
@property (nonatomic, strong) NSURL *venLogo;
/**
 *  The vendor ID
 */
@property (nonatomic, strong) NSString *vendorID;
/**
 *  The vendor location code
 */
@property (nonatomic, strong) NSString *locationCode;
/**
 *  The vendor location name
 */
@property (nonatomic, strong) NSString *venLocationName;
/**
 *  The vendor address
 */
@property (nonatomic, strong) NSString *venAddress;
/**
 *  The vendor country code
 */
@property (nonatomic, strong) NSString *venCountryCode;
/**
 *  The vendor phone number
 */
@property (nonatomic, strong) NSString *venPhone;
/**
 *  Vendor rating
 */
@property (nonatomic, strong) CTVendorRating *rating;
/**
 *  Drop off vendor
 */
@property (nonatomic, strong) CTVendor *dropoffVendor;
/**
 *  Available cars from the vendor
 */
@property (nonatomic, strong) NSArray<CTVehicle *> *availableCars;

- (id)initFromVehVendorAvailsDictionary:(NSDictionary *)vehVendorAvails;

@end


