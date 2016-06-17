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
//  InsuranceObject.h
//  CarTrawler
//

#import <Foundation/Foundation.h>
/**
 *  CTInsurance
 */
@interface CTInsurance : NSObject

/**
 *  ID of the insurance plan
 */
@property (nonatomic, strong, readonly) NSString *planID;
/**
 *  Name of the insurance plan
 */
@property (nonatomic, strong, readonly) NSString *name;
/**
 *  The url for the policy document
 */
@property (nonatomic, strong, readonly) NSURL *detailURL;
/**
 *  The cost of the plan
 */
@property (nonatomic, strong, readonly) NSNumber *costAmount;
/**
 *  The cost currency code
 */
@property (nonatomic, strong, readonly) NSString *costCurrencyCode;
/**
 *  The premium amount
 */
@property (nonatomic, strong, readonly) NSNumber *premiumAmount;
/**
 *  The premium currency code
 */
@property (nonatomic, strong, readonly) NSString *premiumCurrencyCode;

- (id)initFromDict:(NSDictionary *)dict;

@end
