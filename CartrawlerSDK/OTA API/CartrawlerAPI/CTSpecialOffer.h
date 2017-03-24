//
//  CTSpecialOffers.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 01/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTSpecialOffer : NSObject

typedef NS_ENUM(NSUInteger, CTSpecialOfferType) {
    
    CTSpecialOfferTypeMonetaryDiscount = 0,
    
    CTSpecialOfferTypeFreeGPS,
    
    CTSpecialOfferTypePercentageDiscount,
    
    CTSpecialOfferTypeFreeAdditionalDriver,
    
    CTSpecialOfferTypeFreeFuel,
    
    CTSpecialOfferTypeFreeDays,
    
    CTSpecialOfferTypeFreeWinterCarKit,
    
    CTSpecialOfferTypeCongestionCharge,
    
    CTSpecialOfferTypeChildSeat,
    
    CTSpecialOfferTypePersonalAccidentInsurance,
    
    CTSpecialOfferTypeEuroDisneyPass,
    
    CTSpecialOfferTypeFreeSkiPass,
    
    CTSpecialOfferTypeFreeUpgrade,
    
    CTSpecialOfferTypePercentageDiscountGPS,
    
    CTSpecialOfferTypeFreeWIFI,
    
    CTSpecialOfferTypeGuaranteedMAM,
    
    CTSpecialOfferTypeGenericOffer,
    
    CTSpecialOfferTypeWheelchairAccess,
    
    CTSpecialOfferTypeNewCar,
    
    CTSpecialOfferTypeFreeWinterTyres,
    
    CTSpecialOfferTypeFreeParking,
    
    CTSpecialOfferTypeFreeBoosterSeat,
    
    CTSpecialOfferTypeFastTrack,
    
    CTSpecialOfferTypeDeliveryCollection,
    
    CTSpecialOfferTypeCarWithDriver,
    
    CTSpecialOfferTypeXDaysCarHire,
    
    CTSpecialOfferTypeHourGrace,
    
    CTSpecialOfferTypeFreeDayAndUpgrade,
    
    CTSpecialOfferTypeGPSIncluded,
    
    CTSpecialOfferTypeServedWithinXMinutes,
    
    CTSpecialOfferTypeBlueLagonPass,
    
    CTSpecialOfferTypeFreeSkiRack,
    
    CTSpecialOfferTypeFreeSnowChains,
    
    CTSpecialOfferTypeCarWithDriver_8HRS_80KM,
    
    CTSpecialOfferTypeCarWithDriver_4HRS_40KM,
    
    CTSpecialOfferTypeCarWithDriver_16HRS_250KM,
    
    CTSpecialOfferTypePercentageDiscountBranded,
    
    CTSpecialOfferTypeMarketPlace,
    
    CTSpecialOfferTypeGenericDiscountBranded,
    
    CTSpecialOfferTypeGenericDiscount,
    
    CTSpecialOfferTypeCartrawlerCash,
    
    CTSpecialOfferTypeWinterTyresNotIncluded,
    
    CTSpecialOfferTypeElectricCar,
    
    CTSpecialOfferTypeFreeSkiPackage,
    
    CTSpecialOfferTypeGPSJapanese,
    
    CTSpecialOfferTypeNewCar2015,
    
    CTSpecialOfferTypeDistressedInventory,
    
    CTSpecialOfferTypeEarlyBirdGenericDiscount,
    
    CTSpecialOfferTypeEarlyBirdPercentageDiscount,
    
    CTSpecialOfferTypeUnknown
    
};

@property (nonatomic, readonly) CTSpecialOfferType type;
@property (nonatomic, strong, nonnull, readonly) NSString *shortText;
@property (nonatomic, strong, nonnull, readonly) NSString *uiToken;
@property (nonatomic, strong, nonnull, readonly) NSString *text;

- (instancetype)initFromDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

