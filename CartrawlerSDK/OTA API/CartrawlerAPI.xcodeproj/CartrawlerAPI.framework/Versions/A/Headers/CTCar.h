//
// strongright 2014 Etrawler
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a strong of the License at
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
//  Car.h
//  CarTrawler
//
//
#import <Foundation/Foundation.h>
#import "CTPricedCoverage.h"
#import "CTExtraEquipment.h"

@class CTVendor;

@interface CTCar : NSObject
@property (nonatomic, strong, readonly) NSNumber *totalPriceForThisVehicle;
@property (nonatomic, strong, readonly) CTVendor *vendor;
@property (nonatomic, readonly) int orderIndex;
@property (nonatomic, strong, readonly) NSArray<CTExtraEquipment *> *extraEquipment;
@property (nonatomic, readonly) BOOL insuranceAvailable;
@property (nonatomic, readonly) BOOL isAvailable;
@property (nonatomic, readonly) BOOL isAirConditioned;
@property (nonatomic, strong, readonly) NSString *transmissionType;
@property (nonatomic, strong, readonly) NSString *fuelType;
@property (nonatomic, strong, readonly) NSString *fuelPolicy;
@property (nonatomic, strong, readonly) NSString *driveType;
@property (nonatomic, strong, readonly) NSString *passengerQty;
@property (nonatomic, readonly) NSInteger passengerQtyInt;
@property (nonatomic, strong, readonly) NSString *baggageQty;
@property (nonatomic, strong, readonly) NSString *code;
@property (nonatomic, strong, readonly) NSString *codeContext;
@property (nonatomic, strong, readonly) NSString *vehicleCategory;
@property (nonatomic, strong, readonly) NSString *doorCount;
@property (nonatomic, readonly) NSInteger vehicleClassSize;
@property (nonatomic, strong, readonly) NSString *vehicleMakeModelName;
@property (nonatomic, strong, readonly) NSString *vehicleMakeModelCode;
@property (nonatomic, strong, readonly) NSString *pictureURL;
@property (nonatomic, strong, readonly) NSString *vehicleAssetNumber;
@property (nonatomic, strong, readonly) NSArray *vehicleCharges;
@property (nonatomic, strong, readonly) NSString *rateQualifier;
@property (nonatomic, strong, readonly) NSString *rateTotalAmount;
@property (nonatomic, strong, readonly) NSString *estimatedTotalAmount;
@property (nonatomic, strong, readonly) NSString *currencyCode;
@property (nonatomic, strong, readonly) NSString *refType;
@property (nonatomic, strong, readonly) NSString *refID;
@property (nonatomic, strong, readonly) NSString *refIDContext;
@property (nonatomic, strong, readonly) NSString *refTimeStamp;
@property (nonatomic, strong, readonly) NSString *refURL;
@property (nonatomic, strong, readonly) NSString *orderBy;
@property (nonatomic, readonly) BOOL needCCInfo;
@property (nonatomic, strong, readonly) NSString *theDuration;
@property (nonatomic, strong, readonly) NSArray *fees;
@property (nonatomic, strong, readonly) NSString *currencyExchangeRate;
@property (nonatomic, strong, readonly) NSString *currencyExchangeRate23;
@property (nonatomic, strong, readonly) NSArray<CTPricedCoverage *> *pricedCoverages;

- (NSNumber *)calculateTotalPriceForThisCar;
- (id)initFromVehicleDictionary:(NSDictionary *)vehicleDictionary vendor:(CTVendor *)vendor ;

@end




