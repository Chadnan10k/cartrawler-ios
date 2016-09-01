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
//  Vendor.h
//  CarTrawler
//
//

#import <Foundation/Foundation.h>
#import "CTCar.h"
@interface CTVendor : NSObject

@property (nonatomic, strong) NSString *vendorCode;
@property (nonatomic, strong) NSString *vendorName;
@property (nonatomic, strong) NSString *vendorDivision;
@property (nonatomic, strong) NSString *venLogo;
@property (nonatomic, strong) NSString *vendorID;
@property (nonatomic, strong) NSArray<CTCar *> *availableCars;
@property (nonatomic) BOOL atAirport;
@property (nonatomic, strong) NSString *locationCode;
@property (nonatomic, strong) NSString *venLocationName;
@property (nonatomic, strong) NSString *venAddress;
@property (nonatomic, strong) NSString *venCountryCode;
@property (nonatomic, strong) NSString *venPhone;
@property (nonatomic,strong) CTVendor *dropoffVendor;

- (id)initFromVehVendorAvailsDictionary:(NSDictionary *)vehVendorAvails;

@end


