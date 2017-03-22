//
//  CTSpecialOffers.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 01/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSpecialOffer.h"

@implementation CTSpecialOffer

/*
 "SpecialOffers": {
 "Offer": {
 "@Type": "new_cars",
 "@ShortText": "Guaranteed 2016 - registered car",
 "@UIToken": "new_cars",
 "#text": "We guarantee that you are going to get a 2016-registered car at the desk."
 }
 },
 */

- (instancetype)initFromDictionary:(NSDictionary *)dict
{
    self = [super init];
    _type = [self typeFromString:dict[@"Offer"][@"@Type"]];
    _shortText = dict[@"Offer"][@"@ShortText"];
    _uiToken = dict[@"Offer"][@"@UIToken"];
    _text = dict[@"Offer"][@"#text"];
    return self;

}

- (CTSpecialOfferType)typeFromString:(NSString *)typeStr
{
    
    if ([typeStr isEqualToString:@"monetary_discount"]) {
        return CTSpecialOfferTypeMonetaryDiscount;
    }
    
    if ([typeStr isEqualToString:@"free_gps"]) {
        return CTSpecialOfferTypeFreeGPS;
    }
    
    if ([typeStr isEqualToString:@"percentage_discount"]) {
        return CTSpecialOfferTypePercentageDiscount;
    }
    
    if ([typeStr isEqualToString:@"free_additional_driver"]) {
        return CTSpecialOfferTypeFreeAdditionalDriver;
    }
    
    if ([typeStr isEqualToString:@"free_fuel"]) {
        return CTSpecialOfferTypeFreeFuel;
    }
    
    if ([typeStr isEqualToString:@"free_days"]) {
        return CTSpecialOfferTypeFreeDays;
    }
    
    if ([typeStr isEqualToString:@"free_winter_carkit"]) {
        return CTSpecialOfferTypeFreeWinterCarKit;
    }
    
    if ([typeStr isEqualToString:@"free_congestion_charge"]) {
        return CTSpecialOfferTypeCongestionCharge;
    }
    
    if ([typeStr isEqualToString:@"free_child_seat"]) {
        return CTSpecialOfferTypeChildSeat;
    }
    
    if ([typeStr isEqualToString:@"free_personal_ainsurance"]) {
        return CTSpecialOfferTypePersonalAccidentInsurance;
    }
    
    if ([typeStr isEqualToString:@"euro_disney_pass"]) {
        return CTSpecialOfferTypeEuroDisneyPass;
    }
    
    if ([typeStr isEqualToString:@"free_ski_pass"]) {
        return CTSpecialOfferTypeFreeSkiPass;
    }
    
    if ([typeStr isEqualToString:@"free_upgrade"]) {
        return CTSpecialOfferTypeFreeUpgrade;
    }
    
    if ([typeStr isEqualToString:@"percentage_discount_gps"]) {
        return CTSpecialOfferTypePercentageDiscountGPS;
    }
    
    if ([typeStr isEqualToString:@"free_wifi"]) {
        return CTSpecialOfferTypeFreeWIFI;
    }
    
    if ([typeStr isEqualToString:@"guaranteed_mam"]) {
        return CTSpecialOfferTypeGuaranteedMAM;
    }
    
    if ([typeStr isEqualToString:@"generic_offer"]) {
        return CTSpecialOfferTypeGenericOffer;
    }
    
    if ([typeStr isEqualToString:@"wheelchair_access"]) {
        return CTSpecialOfferTypeWheelchairAccess;
    }
    
    if ([typeStr isEqualToString:@"new_cars"]) {
        return CTSpecialOfferTypeNewCar;
    }
    
    if ([typeStr isEqualToString:@"free_winter_tyres"]) {
        return CTSpecialOfferTypeFreeWinterTyres;
    }
    
    if ([typeStr isEqualToString:@"free_parking"]) {
        return CTSpecialOfferTypeFreeParking;
    }
    
    if ([typeStr isEqualToString:@"free_booster_seat"]) {
        return CTSpecialOfferTypeFreeBoosterSeat;
    }
    
    if ([typeStr isEqualToString:@"fast_track"]) {
        return CTSpecialOfferTypeFastTrack;
    }
    
    if ([typeStr isEqualToString:@"delivery_colection"]) {
        return CTSpecialOfferTypeDeliveryCollection;
    }
    
    if ([typeStr isEqualToString:@"car_with_driver"]) {
        return CTSpecialOfferTypeCarWithDriver;
    }
    
    if ([typeStr isEqualToString:@"x_days_car_hire"]) {
        return CTSpecialOfferTypeXDaysCarHire;
    }
    
    if ([typeStr isEqualToString:@"hour_grace"]) {
        return CTSpecialOfferTypeHourGrace;
    }
    
    if ([typeStr isEqualToString:@"free_day_and_upgrade"]) {
        return CTSpecialOfferTypeFreeDayAndUpgrade;
    }
    
    if ([typeStr isEqualToString:@"gps_included"]) {
        return CTSpecialOfferTypeGPSIncluded;
    }
    
    if ([typeStr isEqualToString:@"served_within_x_minutes"]) {
        return CTSpecialOfferTypeServedWithinXMinutes;
    }
    
    if ([typeStr isEqualToString:@"blue_lagoon_pass"]) {
        return CTSpecialOfferTypeBlueLagonPass;
    }
    
    if ([typeStr isEqualToString:@"free_ski_rack"]) {
        return CTSpecialOfferTypeFreeSkiRack;
    }
    
    if ([typeStr isEqualToString:@"free_snow_chains"]) {
        return CTSpecialOfferTypeFreeSnowChains;
    }
    
    if ([typeStr isEqualToString:@"car_with_driver_8hrs_80km"]) {
        return CTSpecialOfferTypeCarWithDriver_8HRS_80KM;
    }
    
    if ([typeStr isEqualToString:@"car_with_driver_4hrs_40km"]) {
        return CTSpecialOfferTypeCarWithDriver_4HRS_40KM;
    }
    
    if ([typeStr isEqualToString:@"car_with_driver_16hrs_250km"]) {
        return CTSpecialOfferTypeCarWithDriver_16HRS_250KM;
    }
    
    if ([typeStr isEqualToString:@"percentage_discount_branded"]) {
        return CTSpecialOfferTypePercentageDiscountBranded;
    }
    
    if ([typeStr isEqualToString:@"market_place"]) {
        return CTSpecialOfferTypeMarketPlace;
    }
    
    if ([typeStr isEqualToString:@"generic_discount_branded"]) {
        return CTSpecialOfferTypeGenericDiscountBranded;
    }
    
    if ([typeStr isEqualToString:@"generic_discount"]) {
        return CTSpecialOfferTypeGenericDiscount;
    }
    
    if ([typeStr isEqualToString:@"cartrawler_cash"]) {
        return CTSpecialOfferTypeCartrawlerCash;
    }
    
    if ([typeStr isEqualToString:@"winter_tyres_not_included"]) {
        return CTSpecialOfferTypeWinterTyresNotIncluded;
    }
    
    if ([typeStr isEqualToString:@"electric_car"]) {
        return CTSpecialOfferTypeElectricCar;
    }
    
    if ([typeStr isEqualToString:@"free_ski_package"]) {
        return CTSpecialOfferTypeFreeSkiPackage;
    }
    
    if ([typeStr isEqualToString:@"free_gps_japanese"]) {
        return CTSpecialOfferTypeGPSJapanese;
    }
    
    if ([typeStr isEqualToString:@"new_cars_2015"]) {
        return CTSpecialOfferTypeNewCar2015;
    }
    
    if ([typeStr isEqualToString:@"distressed_inventory"]) {
        return CTSpecialOfferTypeDistressedInventory;
    }
    
    if ([typeStr isEqualToString:@"early_bird_generic_discount"]) {
        return CTSpecialOfferTypeEarlyBirdGenericDiscount;
    }
    
    if ([typeStr isEqualToString:@"early_bird_percentage_discount"]) {
        return CTSpecialOfferTypeEarlyBirdPercentageDiscount;
    }
    
    return CTSpecialOfferTypeUnknown;
}

@end
