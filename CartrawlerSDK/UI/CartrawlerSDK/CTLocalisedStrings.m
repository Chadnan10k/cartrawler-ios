//
//  CTLocalisedStrings.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTLocalisedStrings.h"
#import "CTSDKLocalizationConstants.h"

@implementation CTLocalisedStrings

+ (NSString *)pickupType:(CTAvailabilityItem *)item
{
    switch (item.vendor.pickupLocation.pickupType) {
        case PickupTypeTerminal:
            return CTLocalizedString(CTSDKVehiclePickupTypeVLI1VLIX);
        case PickupTypeShuttleBus:
            return CTLocalizedString(CTSDKVehiclePickupTypeVLI2VLIX);
        case PickupTypeTerminalAndShuttle:
            return CTLocalizedString(CTSDKVehiclePickupTypeVLI3VLIX);
        case PickupTypeMeetAndGreet:
            return CTLocalizedString(CTSDKVehiclePickupTypeVLI4VLIX);
        case PickupTypeCarDriver:
            return CTLocalizedString(CTSDKVehiclePickupTypeVLI6VLIX);
        case PickupTypeUnknown:
            
            if (item.vendor.pickupLocation.atAirport) {
                return CTLocalizedString(CTSDKVehiclePickupTypeAtAirport);
            } else {
                return nil;
            }
            
        default:
            if (item.vendor.pickupLocation.atAirport) {
                return CTLocalizedString(CTSDKVehiclePickupTypeAtAirport);
            } else {
                return nil;
            }
    }
}

+ (NSString *)vehicleSize:(VehicleSize)size {
    switch (size) {
        case VehicleSizeMini: {
            
            return CTLocalizedString(CTSDKVehicleTypeMini);
        }
        case VehicleSizeSubcompact: {
            
            return CTLocalizedString(CTSDKVehicleTypeSubcompact);
        }
        case VehicleSizeEconomy: {
            
            return CTLocalizedString(CTSDKVehicleTypeEconomy);
        }
        case VehicleSizeCompact: {
            
            return CTLocalizedString(CTSDKVehicleTypeEconomy);
        }
        case VehicleSizeMidsize: {
            
            return CTLocalizedString(CTSDKVehicleTypeMidsize);
        }
        case VehicleSizeIntermediate: {
            
            return CTLocalizedString(CTSDKVehicleTypeIntermediate);
        }
        case VehicleSizeStandard: {
            
            return CTLocalizedString(CTSDKVehicleTypeStandard);
        }
        case VehicleSizeFullsize: {
            
            return CTLocalizedString(CTSDKVehicleTypeFullsize);
        }
        case VehicleSizeLuxury: {
            
            return CTLocalizedString(CTSDKVehicleTypeLuxury);
        }
        case VehicleSizePremium: {
            
            return CTLocalizedString(CTSDKVehicleTypePremium);
        }
        case VehicleSizeMinivan: {
            
            return CTLocalizedString(CTSDKVehicleTypeMinivan);
        }
        case VehicleSizeTwelvePassengerVan: {
            
            return CTLocalizedString(CTSDKVehicleTypeTwelvePassengerVan);
        }
        case VehicleSizeMovingVan: {
            
            return CTLocalizedString(CTSDKVehicleTypeMovingVan);
        }
        case VehicleSizeFifteenPassengerVan: {
            
            return CTLocalizedString(CTSDKVehicleTypeFifteenPassengerVan);
        }
        case VehicleSizeCargoVan: {
            
            return CTLocalizedString(CTSDKVehicleTypeCargoVan);
        }
        case VehicleSizeTwelveFootTruck: {
            
            return CTLocalizedString(CTSDKVehicleTypeTwelveFootTruck);
        }
        case VehicleSizeTwentyFootTruck: {
            
            return CTLocalizedString(CTSDKVehicleTypeTwentyFootTruck);
        }
        case VehicleSizeTwentyFourFootTruck: {
            
            return CTLocalizedString(CTSDKVehicleTypeTwentyFourFootTruck);
        }
        case VehicleSizeTwentySixFootTruck: {
            
            return CTLocalizedString(CTSDKVehicleTypeTwentySixFootTruck);
        }
        case VehicleSizeMoped: {
            
            return CTLocalizedString(CTSDKVehicleTypeMoped);
        }
        case VehicleSizeStretch: {
            
            return CTLocalizedString(CTSDKVehicleTypeStretch);
        }
        case VehicleSizeRegular: {
            
            return CTLocalizedString(CTSDKVehicleTypeRegular);
        }
        case VehicleSizeUnique: {
            
            return CTLocalizedString(CTSDKVehicleTypeUnique);
        }
        case VehicleSizeExotic: {
            
            return CTLocalizedString(CTSDKVehicleTypeExotic);
        }
        case VehicleSizeSmallMediumTruck: {
            
            return CTLocalizedString(CTSDKVehicleTypeSmallMediumTruck);
        }
        case VehicleSizeLargeTruck: {
            
            return CTLocalizedString(CTSDKVehicleTypeLargeTruck);
        }
        case VehicleSizeSmallSUV: {
            
            return CTLocalizedString(CTSDKVehicleTypeSmallSUV);
        }
        case VehicleSizeMediumSUV: {
            
            return CTLocalizedString(CTSDKVehicleTypeMediumSUV);
        }
        case VehicleSizeLargeSUV: {
            
            return CTLocalizedString(CTSDKVehicleTypeLargeSUV);
        }
        case VehicleSizeExoticSUV: {
            
            return CTLocalizedString(CTSDKVehicleTypeExoticSUV);
        }
        case VehicleSizeFourWheelDrive: {
            
            return CTLocalizedString(CTSDKVehicleTypeFourWheelDrive);
        }
        case VehicleSizeSpecial: {
            
            return CTLocalizedString(CTSDKVehicleTypeSpecial);
        }
        case VehicleSizeMiniElite: {
            
            return CTLocalizedString(CTSDKVehicleTypeMiniElite);
        }
        case VehicleSizeEconomyElite: {
            
            return CTLocalizedString(CTSDKVehicleTypeEconomyElite);
        }
        case VehicleSizeCompactElite: {
            
            return CTLocalizedString(CTSDKVehicleTypeCompactElite);
        }
        case VehicleSizeIntermediateElite: {
            
            return CTLocalizedString(CTSDKVehicleTypeIntermediateElite);
        }
        case VehicleSizeStandardElite: {
            
            return CTLocalizedString(CTSDKVehicleTypeStandardElite);
        }
        case VehicleSizeFullsizeElite: {
            
            return CTLocalizedString(CTSDKVehicleTypeFullsizeElite);
        }
        case VehicleSizePremiumElite: {
            
            return CTLocalizedString(CTSDKVehicleTypePremiumElite);
        }
        case VehicleSizeLuxuryElite: {
            
            return CTLocalizedString(CTSDKVehicleTypeLuxuryElite);
        }
        case VehicleSizeOversize: {
            
            return CTLocalizedString(CTSDKVehicleTypeOversize);
        }
        case VehicleSizeUnknown: {
            
            return CTLocalizedString(CTSDKVehicleTypeUnknown);
        }
        case VehicleSizeEstate: {
            
            return CTLocalizedString(CTSDKVehicleTypeEstate);
        }
        case VehicleSizeFiveSeatCarrier: {
            
            return CTLocalizedString(CTSDKVehicleTypeFiveSeatCarrier);
        }
        case VehicleSizeSevenSeatCarrier: {
            
            return CTLocalizedString(CTSDKVehicleTypeSevenSeatCarrier);
        }
        case VehicleSizeNineSeatCarrier: {
            
            return CTLocalizedString(CTSDKVehicleTypeNineSeatCarrier);
        }
        case VehicleSizeSUV: {
            
            return CTLocalizedString(CTSDKVehicleTypeSUV);
        }   
    }
}

+ (NSString *)serviceLevel:(ServiceLevel)type
{
    switch (type) {
        case ServiceLevelNone:
            return @"Unknown";
        case ServiceLevelEconomy:
            return @"Economy";
        case ServiceLevelStandard:
            return @"Standard";
        case ServiceLevelBusiness:
            return @"Business";
        case ServiceLevelLuxury:
            return @"Luxury";
        case ServiceLevelPremium:
            return @"Premium";
        case ServiceLevelStandardClass:
            return @"Standard Class";
        case ServiceLevelFirstClass:
            return @"First Class";
        default:
            return @"Unknown";
    }
}

+ (NSString *)inclusionText:(Inclusion)inclusion
{
    
    switch (inclusion) {
        case InclusionAirCon: {
            return NSLocalizedString(@"Air Con", @"Air Con");
            
        }
        case InclusionBathroom: {
            return NSLocalizedString(@"Bathroom", @"Bathroom");
            
        }
        case InclusionBike: {
            return NSLocalizedString(@"Bike", @"Bike");
            
        }
        case InclusionChildSeats: {
            return NSLocalizedString(@"Child Seats", @"");
            
        }
        case InclusionDriverLanguages: {
            return NSLocalizedString(@"Driver Languages", @"");
            
        }
        case InclusionExtraPrivacyLegroom: {
            return NSLocalizedString(@"Extra Privacy & Legroom", @"");
            
        }
        case InclusionMagazines: {
            return NSLocalizedString(@"Magazines", @"");
            
        }
        case InclusionMakeModel: {
            return NSLocalizedString(@"Make model", @""); // ??
            
        }
        case InclusionNewspaper: {
            return NSLocalizedString(@"Newspaper", @"");
            
        }
        case InclusionOversizeLuggage: {
            return NSLocalizedString(@"Oversize Luggage", @"");
            
        }
        case InclusionPhoneCharger: {
            return NSLocalizedString(@"Phone Charger", @"");
            
        }
        case InclusionPowerSocket: {
            return NSLocalizedString(@"Power Socket", @"");
            
        }
        case InclusionSMS: {
            return NSLocalizedString(@"SMS", @"");
            
        }
        case InclusionSnacks: {
            return NSLocalizedString(@"Snacks", @"");
            
        }
        case InclusionTablet: {
            return NSLocalizedString(@"Tablet", @"");
            
        }
        case InclusionWaitMinutes: {
            return NSLocalizedString(@"Wait Minutes", @""); //??
            
        }
        case InclusionWheelchairAccess: {
            return NSLocalizedString(@"Wheelchair Access", @"");
            
        }
        case InclusionWifi: {
            return NSLocalizedString(@"Wifi", @"");
            
        }
        case InclusionWorkTable: {
            return NSLocalizedString(@"Work Table", @"");
            
        }
        case InclusionVideo: {
            return NSLocalizedString(@"Video", @"");
            
        }
        case InclusionWater: {
            return NSLocalizedString(@"Water", @"");
            
        }
        case InclusionUnknown: {
            return NSLocalizedString(@"Unknown", @"");
            
        }
    }
    
    return @"";
}

+ (NSString *)fuelPolicy:(FuelPolicy)fuelPolicy
{
    if (fuelPolicy == FuelPolicyFullToFull) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyTypeFullFull);
    }
    
    if (fuelPolicy == FuelPolicyFullEmptyRefund) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyTypeFullEmptyRefund);
    }
    
    if (fuelPolicy == FuelPolicyFullToEmpty) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyTypeFullEmpty);
    }
    
    if (fuelPolicy == FuelPolicyElectricVehicle) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyTypeElectricVehicle);
    }
    
    if (fuelPolicy == FuelPolicyEmptyToEmpty) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyTypeEmptyEmpty);
    }
    
    if (fuelPolicy == FuelPolicyHalfToEmpty) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyTypeHalfEmpty);
    }
    
    if (fuelPolicy == FuelPolicyQuarterToEmpty) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyTypeQuarterEmpty);
    }
    
    if (fuelPolicy == FuelPolicyHalfToHalf) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyTypeHalfHalf);
    }
    
    if (fuelPolicy == FuelPolicyQuarterToQuarter) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyTypeQuarterQuarter);
    }
    
    if (fuelPolicy == FuelPolicyQuarterToQuarter) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyTypeUnknown);
    }
    
    if (fuelPolicy == FuelPolicyFullToFullHybrid) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyTypeFullFullHybrid);
    }
    
    if (fuelPolicy == FuelPolicyChaufFullFull) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyTypeChaufFulFul);
    }
    
    return CTLocalizedString(CTSDKVehicleFuelPolicyTypeUnknown);
}

+ (NSString *)toolTipTextForFuelPolicy:(FuelPolicy)fuelPolicy
{
    if (fuelPolicy == FuelPolicyFullToFull) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyDescFullFull);
    }
    
    if (fuelPolicy == FuelPolicyFullEmptyRefund) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyDescFullEmptyRefund);
    }
    
    if (fuelPolicy == FuelPolicyFullToEmpty) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyDescFullEmpty);
    }
    
    if (fuelPolicy == FuelPolicyElectricVehicle) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyDescElectricVehicle);
    }
    
    if (fuelPolicy == FuelPolicyEmptyToEmpty) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyDescEmptyEmpty);
    }
    
    if (fuelPolicy == FuelPolicyHalfToEmpty) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyDescHalfEmpty);
    }
    
    if (fuelPolicy == FuelPolicyQuarterToEmpty) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyDescQuarterEmpty);
    }
    
    if (fuelPolicy == FuelPolicyHalfToHalf) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyDescHalfHalf);
    }
    
    if (fuelPolicy == FuelPolicyQuarterToQuarter) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyDescQuarterQuarter);
    }
    
    if (fuelPolicy == FuelPolicyFullToFullHybrid) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyDescFullFullHybrid);
    }
    
    if (fuelPolicy == FuelPolicyChaufFullFull) {
        return CTLocalizedString(CTSDKVehicleFuelPolicyDescChaufFulFul);
    }
    
    return CTLocalizedString(CTSDKVehicleFuelPolicyDescUnknown);
}

+ (NSString *)toolTipTextForPickupType:(CTAvailabilityItem *)item
{
    switch (item.vendor.pickupLocation.pickupType) {
        case PickupTypeTerminal:
            return [self localizedStringForKey:@"PICKUP_IN_TERMINAL"];
        case PickupTypeShuttleBus:
            return [self localizedStringForKey:@"PICKUP_FREE_SHUTTLE_BUS"];
        case PickupTypeTerminalAndShuttle:
            return [self localizedStringForKey:@"PICKUP_FREE_SHUTTLE_BUS"];
        case PickupTypeMeetAndGreet:
            return [self localizedStringForKey:@"PICKUP_MEET_GREET"];
        case PickupTypeCarDriver:
            return [self localizedStringForKey:@"PICKUP_PERSONAL_DRIVER"];
        case PickupTypeUnknown:
            if (item.vendor.pickupLocation.atAirport) {
                return [self localizedStringForKey:@"PICKUP_IN_TERMINAL"];
            } else {
                return @"";
            }
        default:
            if (item.vendor.pickupLocation.atAirport) {
                return [self localizedStringForKey:@"PICKUP_IN_TERMINAL"];
            } else {
                return @"";
            }
    }
}

+ (NSString *)localizedStringForKey:(NSString *)key
{
    return CTLocalizedString(key);
}

+ (NSString *)localizedStringForKey:(NSString *)key bundle:(NSBundle *)bundle
{
    return NSLocalizedStringFromTableInBundle(key, @"en", bundle, nil);
}


@end
