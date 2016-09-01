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

@interface CTExtraEquipment : NSObject

@property (nonatomic, readonly) NSInteger qty;
@property (nonatomic, strong, readonly) NSString *chargeAmount;
@property (nonatomic, readonly) BOOL isIncludedInRate;
@property (nonatomic, strong, readonly) NSString *currencyCode;
@property (nonatomic, readonly) BOOL isTaxInclusive;
@property (nonatomic, strong, readonly) NSString *equipType;
@property (nonatomic, strong, readonly) NSString *equipDescription;

- (void)setQty:(NSInteger)qty;
- (id) initFromDictionary:(NSDictionary *)dict;

@end
