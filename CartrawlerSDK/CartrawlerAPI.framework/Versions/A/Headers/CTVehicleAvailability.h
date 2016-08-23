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
//  VehAvailRSCore.h
//  CarTrawler
//

#import <Foundation/Foundation.h>
#import "CTVendor.h"
#import "CTAvailabilityItem.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTVehicleAvailability
 */
@interface CTVehicleAvailability : NSObject

/**
 *  The pickup date and time
 */
@property (nonatomic, nonnull, readonly) NSString *puDate;
/**
 *  The drop off date and time
 */
@property (nonatomic, nonnull, readonly) NSString *doDate;
/**
 *  The pickup location code
 */
@property (nonatomic, nonnull, readonly) NSString *puLocationCode;
/**
 *  The Pickup location name
 */
@property (nonatomic, nonnull, readonly) NSString *puLocationName;
/**
 *  The drop off location code
 */
@property (nonatomic, nonnull, readonly) NSString *doLocationCode;
/**
 *  The drop off location name
 */
@property (nonatomic, nonnull, readonly) NSString *doLocationName;

@property (nonatomic, nonnull, readonly) NSArray<CTAvailabilityItem *> *items;

- (instancetype)initFromVehAvailRSCoreDictionary:(NSDictionary *)vehAvailRSCoreDictionary;

@end

NS_ASSUME_NONNULL_END
