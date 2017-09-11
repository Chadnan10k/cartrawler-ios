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
@property (nonatomic, readwrite) UIColor *primaryColor;
@property (nonatomic, readwrite) CTExtrasCellType type;
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *detail;
@property (nonatomic, readwrite) NSString *moreDetail;
@property (nonatomic, readwrite) NSString *quantity;
@property (nonatomic, readwrite) NSString *imageCharacter;
@property (nonatomic, readwrite) CTExtraEquipment *extra;
@property (nonatomic, readwrite) BOOL incrementEnabled;
@property (nonatomic, readwrite) BOOL decrementEnabled;
@property (nonatomic, readwrite) UIColor *incrementButtonColor;
@property (nonatomic, readwrite) UIColor *decrementButtonColor;
@property (nonatomic, readwrite) BOOL flipped;
@property (nonatomic, readwrite) BOOL expanded;
@end

@implementation CTSelectedVehicleExtrasCellModel

+ (instancetype)viewModelForState:(CTAppState *)appState
                            extra:(CTExtraEquipment *)extra
                             type:(CTExtrasCellType)type {
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    
    CTSelectedVehicleExtrasCellModel *viewModel = [CTSelectedVehicleExtrasCellModel new];
    viewModel.primaryColor = appState.userSettingsState.primaryColor;
    viewModel.type = type;
    viewModel.title = extra.equipDescription;
    viewModel.detail = [self detailForExtra:extra];
    viewModel.imageCharacter = [self imageCharacterForExtra:extra];
    viewModel.extra = extra;
    
    NSInteger index = [selectedVehicleState.selectedAvailabilityItem.vehicle.extraEquipment indexOfObject:extra];
    
    viewModel.quantity = [selectedVehicleState.addedExtras objectForKey:extra].stringValue;
    NSInteger maximumQuantity = extra.isIncludedInRate ? 1 : 4;
    viewModel.incrementEnabled = [selectedVehicleState.addedExtras objectForKey:extra].integerValue < maximumQuantity;
    NSInteger minimumQuantity = extra.isIncludedInRate ? 1 : 0;
    viewModel.decrementEnabled = [selectedVehicleState.addedExtras objectForKey:extra].integerValue > minimumQuantity;
    viewModel.incrementButtonColor = viewModel.incrementEnabled ? appState.userSettingsState.primaryColor : [UIColor lightGrayColor];
    viewModel.decrementButtonColor = viewModel.decrementEnabled ? appState.userSettingsState.primaryColor : [UIColor lightGrayColor];
    
    viewModel.flipped = selectedVehicleState.flippedExtras[index].integerValue;
    viewModel.expanded = selectedVehicleState.expandedExtras[index].integerValue;
        
    viewModel.moreDetail = [self moreDetailForExtra:extra];
    
    return viewModel;
}

+ (NSString *)detailForExtra:(CTExtraEquipment *)extra {
    if (extra.isIncludedInRate) {
        return @"Included for free";
    } else {
        NSString *charge = [extra.chargeAmount numberStringWithCurrencyCode];
        return [NSString stringWithFormat:@"%@ %@", charge, CTLocalizedString(CTRentalExtrasPerRental)];
    }
}

+ (NSString *)imageCharacterForExtra:(CTExtraEquipment *)extra {
    switch (extra.equipmentType) {
        case CTExtraEquipmentTypeAdditionalDriver:
            return @"";
        case CTExtraEquipmentTypeBoosterSeat:
            return @"";
        case CTExtraEquipmentTypeBreathalyser:
            return @"";
        case CTExtraEquipmentTypeNavigationSystem:
        case CTExtraEquipmentTypeNavigationalPhone:
        case CTExtraEquipmentTypeGPS:
            return @"";
        case CTExtraEquipmentTypeInfantSeat:
            return @"";
        case CTExtraEquipmentTypeLuggageRack:
            return @"";
        case CTExtraEquipmentTypeMobilePhone:
            return @"";
        case CTExtraEquipmentTypeSkiRack:
            return @"";
        case CTExtraEquipmentTypeSnowChains:
            return @"";
        case CTExtraEquipmentTypeSnowTires:
            return @"";
        case CTExtraEquipmentTypeToddlerSeat:
            return @"";
        case CTExtraEquipmentTypeTollTag:
            return @"";
        case CTExtraEquipmentTypeWifi:
            return @"";
        case CTExtraEquipmentTypeWinterPackage:
            return @"";
        default:
            return @"";
            break;
    }
}

+ (NSString *)moreDetailForExtra:(CTExtraEquipment *)extra {
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

@end
