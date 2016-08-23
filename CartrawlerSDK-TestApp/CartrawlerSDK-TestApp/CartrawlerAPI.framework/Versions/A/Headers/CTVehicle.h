//
// copyright 2014 Etrawler
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a nonnull of the License at
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
 *  Fuel Policy
 */
typedef NS_ENUM(NSUInteger, FuelPolicy) {
    /**
     *  Electric Vehicle
     */
    FuelPolicyElectricVehicle = 0,
    /**
     *  Full To Full
     */
    FuelPolicyFullToFull,
    /**
     *  Empty to Empty
     */
    FuelPolicyEmptyToEmpty,
    /**
     *  Full to Empty
     */
    FuelPolicyFullToEmpty,
    /**
     *  Half to Empty
     */
    FuelPolicyHalfToEmpty,
    /**
     *  Quarter to Empty
     */
    FuelPolicyQuarterToEmpty,
    /**
     *  Half to half
     */
    FuelPolicyHalfToHalf,
    /**
     *  Quarter to quarter
     */
    FuelPolicyQuarterToQuarter,
    /**
     *  Unknown fuel policy
     */
    FuelPolicyUnknown,
    /**
     *  Full to empty refund
     */
    FuelPolicyFullEmptyRefund,
    /**
     *  Full to full hybrid
     */
    FuelPolicyFullToFullHybrid,
    
    FuelPolicyChaufFullFull,
    
    FuelPolicyChaufFuelInc
};

typedef NS_ENUM(NSUInteger, VehicleSize) {

    VehicleSizeMini = 0,

    VehicleSizeSubcompact,

    VehicleSizeEconomy,

    VehicleSizeCompact,

    VehicleSizeMidsize,

    VehicleSizeIntermediate,

    VehicleSizeStandard,

    VehicleSizeFullsize,

    VehicleSizeLuxury,

    VehicleSizePremium,

    VehicleSizeMinivan,
    
    VehicleSizeTwelvePassengerVan,
    
    VehicleSizeMovingVan,
    
    VehicleSizeFifteenPassengerVan,

    VehicleSizeCargoVan,
    
    VehicleSizeTwelveFootTruck,
    
    VehicleSizeTwentyFootTruck,
    
    VehicleSizeTwentyFourFootTruck,
    
    VehicleSizeTwentySixFootTruck,
    
    VehicleSizeMoped,
    
    VehicleSizeStretch,
    
    VehicleSizeRegular,
    
    VehicleSizeUnique,
    
    VehicleSizeExotic,
    
    VehicleSizeSmallMediumTruck,
    
    VehicleSizeLargeTruck,
    
    VehicleSizeSmallSUV,
    
    VehicleSizeMediumSUV,
    
    VehicleSizeLargeSUV,
    
    VehicleSizeExoticSUV,
    
    VehicleSizeFourWheelDrive,
    
    VehicleSizeSpecial,
    
    VehicleSizeMiniElite,
    
    VehicleSizeEconomyElite,
    
    VehicleSizeCompactElite,
    
    VehicleSizeIntermediateElite,
    
    VehicleSizeStandardElite,
    
    VehicleSizeFullsizeElite,
    
    VehicleSizePremiumElite,
    
    VehicleSizeLuxuryElite,
    
    VehicleSizeOversize,
    
    VehicleSizeUnknown

};

NS_ASSUME_NONNULL_BEGIN

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
@property (nonatomic, nonnull, readonly) NSNumber *passengerQty;
/**
 *  Int value representing the vehicle class size
 */
@property (nonatomic, readonly) NSInteger classSize;
/**
 *  The total base price for this vehicle
 */
@property (nonatomic, nonnull, readonly) NSNumber *totalPriceForThisVehicle;
/**
 *  The transmission type of the vehicle
 */
@property (nonatomic, nonnull, readonly) NSString *transmissionType;
/**
 *  The fuel type of the vehicle
 */
@property (nonatomic, nonnull, readonly) NSString *fuelType;
/**
 *  The vehicles fuel policy description
 */
@property (nonatomic, nonnull, readonly) NSString *fuelPolicyDescription;
/**
 *  Fuel policy enum
 */
@property (nonatomic) FuelPolicy fuelPolicy;
/**
 *  The vehicles drive type
 */
@property (nonatomic, nonnull, readonly) NSString *driveType;
/**
 *  The quantity of the amount of baggage the vehicle can hold
 */
@property (nonatomic, nonnull, readonly) NSNumber *baggageQty;
/**
 *  The vehicles ID code
 */
@property (nonatomic, nonnull, readonly) NSString *code;
/**
 *  The vehicle code context
 */
@property (nonatomic, nonnull, readonly) NSString *codeContext;
/**
 *  The vehicle category description
 */
@property (nonatomic, readonly) VehicleSize size;
/**
 *  Vehicle category code
 */
@property (nonatomic, nonnull, readonly) NSString *sizeCode;
/**
 *  The number of doors the vehicle has
 */
@property (nonatomic, nonnull, readonly) NSNumber *doorCount;
/**
 *  The make / model name of the vehicle
 */
@property (nonatomic, nonnull, readonly) NSString *makeModelName;
/**
 *  The make / model code of the vehicle
 */
@property (nonatomic, nonnull, readonly) NSString *makeModelCode;
/**
 *  Picture url for the vehicle
 */
@property (nonatomic, nonnull, readonly) NSURL *pictureURL;
/**
 *  Vehicle asset number
 */
@property (nonatomic, nonnull, readonly) NSString *vehicleAssetNumber;
/**
 *  Rate qualifier
 */
@property (nonatomic, nonnull, readonly) NSString *rateQualifier;
/**
 *  Rate total amount
 */
@property (nonatomic, nonnull, readonly) NSString *rateTotalAmount;
/**
 *  Estimated total amount for vehicle
 */
@property (nonatomic, nonnull, readonly) NSNumber *estimatedTotalAmount;
/**
 *  Currency code for vehicle cost
 */
@property (nonatomic, nonnull, readonly) NSString *currencyCode;
/**
 *  Vehicle reference type
 */
@property (nonatomic, nonnull, readonly) NSString *refType;
/**
 *  Vehicle reference ID
 */
@property (nonatomic, nonnull, readonly) NSString *refID;
/**
 *  Vehicle reference ID context
 */
@property (nonatomic, nonnull, readonly) NSString *refIDContext;
/**
 *  Vehicle reference time tamp
 */
@property (nonatomic, nonnull, readonly) NSString *refTimeStamp;
/**
 *  Vehicle reference URL
 */
@property (nonatomic, nonnull, readonly) NSString *refURL;
/**
 *  Rental duration
 */
@property (nonatomic, nonnull, readonly) NSString *rentalDuration;
/**
 *  Currency exchanage rate
 */
@property (nonatomic, nonnull, readonly) NSString *currencyExchangeRate;
/**
 *  Currency exchange rate
 */
@property (nonatomic, nonnull, readonly) NSString *currencyExchangeRate23;
/**
 *  Array of available equipment for vehicle
 */
@property (nonatomic, nonnull, readonly) NSArray<CTExtraEquipment *> *extraEquipment;
/**
 *  Array of fees for vehicle
 */
@property (nonatomic, nonnull, readonly) NSArray<CTFee *> *fees;
/**
 *  Array of charges for vehicle
 */
@property (nonatomic, nonnull, readonly) NSArray<CTVehicleCharge *> *vehicleCharges;
/**
 *  Array of priced coverages for vehicle
 */
@property (nonatomic, nonnull, readonly) NSArray<CTPricedCoverage *> *pricedCoverages;

- (instancetype)initFromDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END



