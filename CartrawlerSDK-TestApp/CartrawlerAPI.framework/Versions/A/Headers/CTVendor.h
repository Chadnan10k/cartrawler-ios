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
@property (nonatomic, strong) NSString *code;
/**
 *  The vendor name
 */
@property (nonatomic, strong) NSString *name;
/**
 *  The vendor division
 */
@property (nonatomic, strong) NSString *division;
/**
 *  Picture url for the vendor logo
 */
@property (nonatomic, strong) NSURL *logoURL;
/**
 *  The vendor ID
 */
@property (nonatomic, strong) NSString *ID;
/**
 *  The vendor location code
 */
@property (nonatomic, strong) NSString *locationCode;
/**
 *  The vendor location name
 */
@property (nonatomic, strong) NSString *locationName;
/**
 *  The vendor address
 */
@property (nonatomic, strong) NSString *address;
/**
 *  The vendor country code
 */
@property (nonatomic, strong) NSString *countryCode;
/**
 *  The vendor phone number
 */
@property (nonatomic, strong) NSString *phone;
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


