//
//  CTSelectedVehicleExtrasCellModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleExtrasCellModel.h"
#import "CTAppState.h"
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import "CTSDKLocalizationConstants.h"

@interface CTSelectedVehicleExtrasCellModel ()
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *detail;
@property (nonatomic, readwrite) NSString *quantity;
@property (nonatomic, readwrite) NSString *imageCharacter;
@property (nonatomic, readwrite) CTExtraEquipment *extra;
@end

@implementation CTSelectedVehicleExtrasCellModel

+ (instancetype)viewModelForState:(CTAppState *)state extra:(CTExtraEquipment *)extra {
    CTSelectedVehicleExtrasCellModel *viewModel = [CTSelectedVehicleExtrasCellModel new];
    viewModel.title = [self titleForExtra:extra];
    viewModel.detail = [self detailForExtra:extra];
    viewModel.imageCharacter = [self imageCharacterForExtra:extra];
    viewModel.extra = extra;
    return viewModel;
}

+ (NSString *)titleForExtra:(CTExtraEquipment *)extra {
    switch (extra.equipmentType) {
        case CTExtraEquipmentTypeAdditionalDriver:
            return CTLocalizedString(CTRentalDetailAdditionalDriver);
        case CTExtraEquipmentTypeBoosterSeat:
            return CTLocalizedString(CTRentalDetailBoosterSeat);
        case CTExtraEquipmentTypeBreathalyser:
            return CTLocalizedString(CTRentalDetailBreathalyser);
        case CTExtraEquipmentTypeNavigationSystem:
            return CTLocalizedString(CTRentalDetailNavigationSystem);
        case CTExtraEquipmentTypeNavigationalPhone:
            return CTLocalizedString(CTRentalDetailNavigationalPhone);
        case CTExtraEquipmentTypeGPS:
            return CTLocalizedString(CTRentalDetailGPS);
        case CTExtraEquipmentTypeInfantSeat:
            return CTLocalizedString(CTRentalDetailInfantSeat);
        case CTExtraEquipmentTypeLuggageRack:
            return CTLocalizedString(CTRentalDetailLuggageRack);
        case CTExtraEquipmentTypeMobilePhone:
            return CTLocalizedString(CTRentalDetailMobilePhone);
        case CTExtraEquipmentTypeSkiRack:
            return CTLocalizedString(CTRentalDetailSkiRack);
        case CTExtraEquipmentTypeSnowChains:
            return CTLocalizedString(CTRentalDetailSnowChains);
        case CTExtraEquipmentTypeSnowTires:
            return CTLocalizedString(CTRentalDetailSnowTires);
        case CTExtraEquipmentTypeToddlerSeat:
            return CTLocalizedString(CTRentalDetailToddlerSeat);
        case CTExtraEquipmentTypeTollTag:
            return CTLocalizedString(CTRentalDetailTollTag);
        case CTExtraEquipmentTypeWifi:
            return CTLocalizedString(CTRentalDetailWifi);
        case CTExtraEquipmentTypeWinterPackage:
            return CTLocalizedString(CTRentalDetailWinterPackage);
        default:
            return CTLocalizedString(CTRentalExtrasPaidAtDesk);
            break;
    }
}

+ (NSString *)detailForExtra:(CTExtraEquipment *)extra {
    NSString *charge = [extra.chargeAmount numberStringWithCurrencyCode];
    return [NSString stringWithFormat:@"%@ %@", charge, CTLocalizedString(CTRentalExtrasPerRental)];
}

+ (NSString *)imageCharacterForExtra:(CTExtraEquipment *)extra {
    switch (extra.equipmentType) {
        case CTExtraEquipmentTypeAdditionalDriver:
            return @"";
        case CTExtraEquipmentTypeBoosterSeat:
            return @"";
        case CTExtraEquipmentTypeBreathalyser:
            return @"";
        case CTExtraEquipmentTypeNavigationSystem:
        case CTExtraEquipmentTypeNavigationalPhone:
        case CTExtraEquipmentTypeGPS:
            return @"";
        case CTExtraEquipmentTypeInfantSeat:
            return @"";
        case CTExtraEquipmentTypeLuggageRack:
            return @"";
        case CTExtraEquipmentTypeMobilePhone:
            return @"";
        case CTExtraEquipmentTypeSkiRack:
            return @"";
        case CTExtraEquipmentTypeSnowChains:
            return @"";
        case CTExtraEquipmentTypeSnowTires:
            return @"";
        case CTExtraEquipmentTypeToddlerSeat:
            return @"";
        case CTExtraEquipmentTypeTollTag:
            return @"";
        case CTExtraEquipmentTypeWifi:
            return @"";
        case CTExtraEquipmentTypeWinterPackage:
            return @"";
        default:
            return @"";
            break;
    }
}


@end
