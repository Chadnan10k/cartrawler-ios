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
//  ExtraEquipment.h
//  CarTrawler
//
//
#import <Foundation/Foundation.h>
/**
 *  CTExtraEquipment
 */
@interface CTExtraEquipment : NSObject

/**
 *  The quantity of the equipment
 */
@property (nonatomic, readonly) NSInteger qty;
/**
 *  Bool value if is included in rate
 */
@property (nonatomic, readonly) BOOL isIncludedInRate;
/**
 *  Bool value if equipment is tax inclusive
 */
@property (nonatomic, readonly) BOOL isTaxInclusive;
/**
 *  Cost of equipment
 */
@property (nonatomic, strong, readonly) NSNumber *chargeAmount;
/**
 *  Currency code of equipment
 */
@property (nonatomic, strong, readonly) NSString *currencyCode;
/**
 *  The equipment type
 */
@property (nonatomic, strong, readonly) NSString *equipType;
/**
 *  description of the equipment
 */
@property (nonatomic, strong, readonly) NSString *equipDescription;

/**
 *  Setter method for the equipemt quantity
 *
 *  @param qty The quantity amount
 */
- (void)setQty:(NSInteger)qty;

- (instancetype)initFromDictionary:(NSDictionary *)dict  ;

@end
