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
/**
 *  CTVehicleAvailability
 */
@interface CTVehicleAvailability : NSObject

/**
 *  The pickup date and time
 */
@property (nonatomic, strong, readonly) NSString *puDate;
/**
 *  The drop off date and time
 */
@property (nonatomic, strong, readonly) NSString *doDate;
/**
 *  The pickup location code
 */
@property (nonatomic, strong, readonly) NSString *puLocationCode;
/**
 *  The Pickup location name
 */
@property (nonatomic, strong, readonly) NSString *puLocationName;
/**
 *  The drop off location code
 */
@property (nonatomic, strong, readonly) NSString *doLocationCode;
/**
 *  The drop off location name
 */
@property (nonatomic, strong, readonly) NSString *doLocationName;
/**
 *  Available vendors for an availability search
 */
@property (nonatomic, strong, readonly) NSArray<CTVendor *> *availableVendors;

/**
 *  Convenienve property to get all vehicles sorted by price
 */
@property (nonatomic, strong, readonly) NSArray<CTVehicle *> *allVehicles;


- (instancetype)initFromVehAvailRSCoreDictionary:(NSDictionary *)vehAvailRSCoreDictionary  ;

@end
