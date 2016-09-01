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

@interface CTInsurance : NSObject

@property (nonatomic, strong, readonly) NSString *timestamp;
@property (nonatomic, strong, readonly) NSString *planID;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *detailURL;
@property (nonatomic, strong, readonly) NSString *costAmount;
@property (nonatomic, strong, readonly) NSString *costCurrencyCode;
@property (nonatomic, strong, readonly) NSString *premiumAmount;
@property (nonatomic, strong, readonly) NSString *premiumCurrencyCode;

- (id) initFromDict:(NSDictionary *)dict;

@end
