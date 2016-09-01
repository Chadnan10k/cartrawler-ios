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
#import "CTVehicleCharge.h"
#import "CTFee.h"
@class CTVendor;

/**
 *  CTVehicle
 */
@interface CTVehicle : NSObject

/**
 *  Bool value if vehicle requires payment card information or not
 */
@property (nonatomic, readonly) BOOL needCCInfo;
/**
 *  Bool value showing if insurance is available for this vehicle
 */
@property (nonatomic, readonly) BOOL insuranceAvailable;
/**
 *  Bool value stating if vehicle is available or not
 */
@property (nonatomic, readonly) BOOL isAvailable;
/**
 *  Bool value stating if vehicle is air conditioned or not
 */
@property (nonatomic, readonly) BOOL isAirConditioned;
/**
 *  Passenger quantity vehicle can take
 */
@property (nonatomic, strong, readonly) NSNumber *passengerQty;
/**
 *  Int value representing the vehicle class size
 */
@property (nonatomic, readonly) NSInteger vehicleClassSize;
/**
 *  The total base price for this vehicle
 */
@property (nonatomic, strong, readonly) NSNumber *totalPriceForThisVehicle;
/**
 *  The transmission type of the vehicle
 */
@property (nonatomic, strong, readonly) NSString *transmissionType;
/**
 *  The fuel type of the vehicle
 */
@property (nonatomic, strong, readonly) NSString *fuelType;
/**
 *  The vehicles fuel policy
 */
@property (nonatomic, strong, readonly) NSString *fuelPolicy;
/**
 *  The vehicles drive type
 */
@property (nonatomic, strong, readonly) NSString *driveType;
/**
 *  The quantity of the amount of baggage the vehicle can hold
 */
@property (nonatomic, strong, readonly) NSNumber *baggageQty;
/**
 *  The vehicles ID code
 */
@property (nonatomic, strong, readonly) NSString *code;
/**
 *  The vehicle code context
 */
@property (nonatomic, strong, readonly) NSString *codeContext;
/**
 *  the vehicle category
 */
@property (nonatomic, strong, readonly) NSString *vehicleCategory;
/**
 *  The number of doors the vehicle has
 */
@property (nonatomic, strong, readonly) NSNumber *doorCount;
/**
 *  The make / model name of the vehicle
 */
@property (nonatomic, strong, readonly) NSString *vehicleMakeModelName;
/**
 *  The make / model code of the vehicle
 */
@property (nonatomic, strong, readonly) NSString *vehicleMakeModelCode;
/**
 *  Picture url for the vehicle
 */
@property (nonatomic, strong, readonly) NSURL *pictureURL;
/**
 *  Vehicle asset number
 */
@property (nonatomic, strong, readonly) NSString *vehicleAssetNumber;
/**
 *  Rate qualifier
 */
@property (nonatomic, strong, readonly) NSString *rateQualifier;
/**
 *  Rate total amount
 */
@property (nonatomic, strong, readonly) NSString *rateTotalAmount;
/**
 *  Estimated total amount for vehicle
 */
@property (nonatomic, strong, readonly) NSString *estimatedTotalAmount;
/**
 *  Currency code for vehicle cost
 */
@property (nonatomic, strong, readonly) NSString *currencyCode;
/**
 *  Vehicle reference type
 */
@property (nonatomic, strong, readonly) NSString *refType;
/**
 *  Vehicle reference ID
 */
@property (nonatomic, strong, readonly) NSString *refID;
/**
 *  Vehicle reference ID context
 */
@property (nonatomic, strong, readonly) NSString *refIDContext;
/**
 *  Vehicle reference time tamp
 */
@property (nonatomic, strong, readonly) NSString *refTimeStamp;
/**
 *  Vehicle reference URL
 */
@property (nonatomic, strong, readonly) NSString *refURL;
/**
 *  Rental duration
 */
@property (nonatomic, strong, readonly) NSString *rentalDuration;
/**
 *  Currency exchanage rate
 */
@property (nonatomic, strong, readonly) NSString *currencyExchangeRate;
/**
 *  Currency exchange rate
 */
@property (nonatomic, strong, readonly) NSString *currencyExchangeRate23;
/**
 *  Vehicle CTVendor
 */
@property (nonatomic, strong, readonly) CTVendor *vendor;
/**
 *  Array of available equipment for vehicle
 */
@property (nonatomic, strong, readonly) NSArray<CTExtraEquipment *> *extraEquipment;
/**
 *  Array of fees for vehicle
 */
@property (nonatomic, strong, readonly) NSArray<CTFee *> *fees;
/**
 *  Array of charges for vehicle
 */
@property (nonatomic, strong, readonly) NSArray<CTVehicleCharge *> *vehicleCharges;
/**
 *  Array of priced coverages for vehicle
 */
@property (nonatomic, strong, readonly) NSArray<CTPricedCoverage *> *pricedCoverages;

- (id) initFromVehicleDictionary:(NSDictionary *)vehicleDictionary vendor:(CTVendor *)vendor;


@end




