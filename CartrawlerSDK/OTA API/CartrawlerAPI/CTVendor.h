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
#import "CTVendorLocation.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTVendor
 */
@interface CTVendor : NSObject
/**
 *  The vendor code
 */
@property (nonatomic, nonnull) NSString *code;
/**
 *  The vendor name
 */
@property (nonatomic, nonnull) NSString *name;
/**
 *  The vendor division
 */
@property (nonatomic, nonnull) NSString *division;
/**
 *  Picture url for the vendor logo
 */
@property (nonatomic, nonnull) NSURL *logoURL;
/**
 *  Vendor rating
 */
@property (nonatomic, nonnull) CTVendorRating *rating;
/**
 *  Drop off location for vendor
 */
@property (nonatomic, nonnull) CTVendorLocation *pickupLocation;
/**
 *  Pickup location for vendor
 */
@property (nonatomic, nonnull) CTVendorLocation *dropoffLocation;

- (instancetype)initWithVendorInfo:(NSDictionary *)vendorInfo;

@end

NS_ASSUME_NONNULL_END


