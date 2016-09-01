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
//  VehicleCharge.h
//  CarTrawler
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTVehicleCharge
 */
@interface CTVehicleCharge : NSObject

/**
 *  Bool value if car is tax inclusive
 */
@property (nonatomic, readonly) BOOL isTaxInclusive;
/**
 *  Bool value if this charge is included in the rate
 */
@property (nonatomic, readonly) BOOL isIncludedInRate;
/**
 *  Description of charge
 */
@property (nonatomic, nonnull, readonly) NSString *chargeDescription;
/**
 *  Purpose of the charge
 */
@property (nonatomic, nonnull, readonly) NSString *chargePurpose;

- (instancetype) initFromVehicleChargesDictionary:(NSDictionary *)vehicleChargesDictionary;

@end

NS_ASSUME_NONNULL_END
