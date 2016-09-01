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
//  Fee.h
//  CarTrawler
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTFee
 */
@interface CTFee : NSObject
/**
 *  The fee amount
 */
@property (nonatomic, nonnull, readonly) NSNumber *feeAmount;
/**
 *  Currency code associated with price
 */
@property (nonatomic, nonnull, readonly) NSString *feeCurrencyCode;
/**
 *  Purpose of the fee
 */
@property (nonatomic, nonnull, readonly) NSString *feePurpose;
/**
 *  Description of the fee purpose
 */
@property (nonatomic, nonnull, readonly) NSString *feePurposeDescription;

- (instancetype)initFromFeeDictionary:(NSDictionary *)feeDictionary;

@end

NS_ASSUME_NONNULL_END
