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
//  PricedCoverage.h
//  CarTrawler
//
//

#import <Foundation/Foundation.h>
/**
 *  CTPricedCoverage
 */
@interface CTPricedCoverage : NSObject

/**
 *  Coverage type
 */
@property (nonatomic, strong, readonly) NSString *coverageType;
/**
 *  Description of the charge
 */
@property (nonatomic, strong, readonly) NSString *chargeDescription;
/**
 *  Bool value if coverage is tax inclusive
 */
@property (nonatomic, readonly) BOOL isTaxInclusive;
/**
 *  Bool value of coverage is included in rate
 */
@property (nonatomic, readonly) BOOL isIncludedInRate;

- (instancetype)initWithPricedCoveragesDictionary:(NSDictionary *)pricedCoveragesDictionary;
@end
