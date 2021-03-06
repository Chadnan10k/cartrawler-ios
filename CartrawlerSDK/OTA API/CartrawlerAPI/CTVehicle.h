#import <Foundation/Foundation.h>
#import "CTPricedCoverage.h"
#import "CTExtraEquipment.h"
#import "CTVehicleCharge.h"
#import "CTFee.h"
#import "CTVehicleConfig.h"
#import "CTSpecialOffer.h"
#import "CTVehicleIndexation.h"
#import "CTRateDistance.h"

@class CTVendor;

/**
 Merchandising Tags
 */
typedef NS_ENUM(NSUInteger, CTMerchandisingTag) {
    /**
     *  Business Traveller
     */
    CTMerchandisingTagBusiness = 0,
    /**
     *  City Break
     */
    CTMerchandisingTagCityBreak,
    /**
     *  Family Size
     */
    CTMerchandisingTagFamilySize,
    /**
     *  Best Seller
     */
    CTMerchandisingTagBestSeller,
    /**
     *  Great Value
     */
    CTMerchandisingTagGreatValue,
    /**
     *  Quickest Queue
     */
    CTMerchandisingTagQuickestQueue,
    /**
     *  Recommended
     */
    CTMerchandisingTagRecommended,
    /**
     *  Upgrade to
     */
    CTMerchandisingTagUpgradeTo,
    /**
     *  On a budget
     */
    CTMerchandisingTagOnBudget,
    /**
     *  Best Reviewed
     */
    CTMerchandisingTagBestReviewed,
    /**
     *  Unknown
     */
    CTMerchandisingTagUnknown
};

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
    
    VehicleSizeConvertible,
    
    VehicleSizeEstate,
    
    VehicleSizeFiveSeatCarrier,
    
    VehicleSizeSevenSeatCarrier,
    
    VehicleSizeNineSeatCarrier,
    
    VehicleSizeSUV,
    
    VehicleSizeUnknown

};

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTVehicle
 */
@interface CTVehicle : NSObject


@property (nonatomic, nonnull, readonly) NSNumber *orderIndex;
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
 Bool stating if car has bluetooth
 */
@property (nonatomic, readonly) BOOL isBluetoothEnabled;
/**
 Bool stating if car has a USB port
 */
@property (nonatomic, readonly) BOOL isUSBEnabled;
/**
 Bool stating if car has included GPS
 */
@property (nonatomic, readonly) BOOL isGPSIncluded;
/**
 Bool stating if car has included parking sensors
 */
@property (nonatomic, readonly) BOOL isParkingSensorEnabled;
/**
 Bool stating if car is German model
 */
@property (nonatomic, readonly) BOOL isGermanModel;
/**
 Bool stating if car has good fuel economy
 */
@property (nonatomic, readonly) BOOL isExceptionalFuelEconomy;
/**
 Bool stating if car has front demister
 */
@property (nonatomic, readonly) BOOL isFrontDemisterEnabled;
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
 *  The vehicle category description
 */
@property (nonatomic, readonly) CTMerchandisingTag merchandisingTag;
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
 *  Trailing 'or similar' text of vehicle name
 */
@property (nonatomic, nullable, readonly) NSString *orSimilar;

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
/**
 Index of the vehicle
 */
@property (nonatomic, nonnull, readonly) CTVehicleIndexation *indexation;
/**
 Vehicle special offers
 */
@property (nonatomic, nonnull, readonly) NSArray <CTSpecialOffer *> *specialOffers;
/**
 Vehicle config parameters
 */
@property (nonatomic, nonnull, readonly) CTVehicleConfig *config;
/**
 The mileage allowance of the vehicle
 */
@property (nonatomic, nonnull, readonly) CTRateDistance *rateDistance;

- (instancetype)initFromDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END



