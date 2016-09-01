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
//  termsAndConditions.h
//  CarTrawler
//
//

#import <Foundation/Foundation.h>


@interface CTTermsAndConditions : NSObject
	
@property (nonatomic, strong, readonly) NSString *titleText;
@property (nonatomic, strong, readonly) NSString *bodyText;
@property (nonatomic, strong, readonly) NSArray<CTTermsAndConditions *> *termsAndConditions;
- (id)initFromDictionary:(NSDictionary *)TQ_Dictionary;
- (id)initFromAPIResponse:(NSDictionary *)dict;

@end
	
