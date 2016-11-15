//
//  LocalisedStrings.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "LocalisedStrings.h"

@implementation LocalisedStrings

+ (NSString *)pickupType:(CTAvailabilityItem *)item
{
    switch (item.vendor.pickupLocation.pickupType) {
        case PickupTypeTerminal:
            return NSLocalizedString(@"In Terminal", @"");
        case PickupTypeShuttleBus:
            return NSLocalizedString(@"Free shuttle bus", @"");
        case PickupTypeTerminalAndShuttle:
            return NSLocalizedString(@"Free shuttle bus", @"");
        case PickupTypeMeetAndGreet:
            return NSLocalizedString(@"Meet and greet", @"");
        case PickupTypeCarDriver:
            return NSLocalizedString(@"Personal driver", @"");
        case PickupTypeUnknown:
            
            if (item.vendor.pickupLocation.atAirport) {
                return NSLocalizedString(@"At Airport", @"At Airport");
            } else {
                return NSLocalizedString(@"", @"");
            }
            
        default:
            if (item.vendor.pickupLocation.atAirport) {
                return NSLocalizedString(@"At Airport", @"At Airport");
            } else {
                return NSLocalizedString(@"", @"");
            }
    }
}

+ (NSString *)vehicleSize:(VehicleSize)size {
    switch (size) {
        case VehicleSizeMini: {
            
            return NSLocalizedString(@"Mini", @"");;
        }
        case VehicleSizeSubcompact: {
            
            return NSLocalizedString(@"Subcompact", @"");;
        }
        case VehicleSizeEconomy: {
            
            return NSLocalizedString(@"Economy", @"");;
        }
        case VehicleSizeCompact: {
            
            return NSLocalizedString(@"Compact", @"");;
        }
        case VehicleSizeMidsize: {
            
            return NSLocalizedString(@"Midsize", @"");;
        }
        case VehicleSizeIntermediate: {
            
            return NSLocalizedString(@"Intermediate", @"");;
        }
        case VehicleSizeStandard: {
            
            return NSLocalizedString(@"Standard", @"");;
        }
        case VehicleSizeFullsize: {
            
            return NSLocalizedString(@"Fullsize", @"");;
        }
        case VehicleSizeLuxury: {
            
            return NSLocalizedString(@"Luxury", @"");;
        }
        case VehicleSizePremium: {
            
            return NSLocalizedString(@"Premium", @"");;
        }
        case VehicleSizeMinivan: {
            
            return NSLocalizedString(@"Minivan", @"");;
        }
        case VehicleSizeTwelvePassengerVan: {
            
            return NSLocalizedString(@"12 Passenger Van", @"");;
        }
        case VehicleSizeMovingVan: {
            
            return NSLocalizedString(@"Moving Van", @"");;
        }
        case VehicleSizeFifteenPassengerVan: {
            
            return NSLocalizedString(@"15 Passenger Van", @"");;
        }
        case VehicleSizeCargoVan: {
            
            return NSLocalizedString(@"Cargo Van", @"");;
        }
        case VehicleSizeTwelveFootTruck: {
            
            return NSLocalizedString(@"12 Foot Truck", @"");;
        }
        case VehicleSizeTwentyFootTruck: {
            
            return NSLocalizedString(@"20 Foot Truck", @"");;
        }
        case VehicleSizeTwentyFourFootTruck: {
            
            return NSLocalizedString(@"24 Foot Truck", @"");;
        }
        case VehicleSizeTwentySixFootTruck: {
            
            return NSLocalizedString(@"26 Foot Truck", @"");;
        }
        case VehicleSizeMoped: {
            
            return NSLocalizedString(@"Moped", @"");;
        }
        case VehicleSizeStretch: {
            
            return NSLocalizedString(@"Stretch", @"");;
        }
        case VehicleSizeRegular: {
            
            return NSLocalizedString(@"Regular", @"");;
        }
        case VehicleSizeUnique: {
            
            return NSLocalizedString(@"Unique", @"");;
        }
        case VehicleSizeExotic: {
            
            return NSLocalizedString(@"Exotic", @"");;
        }
        case VehicleSizeSmallMediumTruck: {
            
            return NSLocalizedString(@"Small/Medium Truck", @"");;
        }
        case VehicleSizeLargeTruck: {
            
            return NSLocalizedString(@"Large Truck", @"");;
        }
        case VehicleSizeSmallSUV: {
            
            return NSLocalizedString(@"Small SUV", @"");;
        }
        case VehicleSizeMediumSUV: {
            
            return NSLocalizedString(@"Medium SUV", @"");;
        }
        case VehicleSizeLargeSUV: {
            
            return NSLocalizedString(@"Large SUV", @"");;
        }
        case VehicleSizeExoticSUV: {
            
            return NSLocalizedString(@"Exotic SUV", @"");;
        }
        case VehicleSizeFourWheelDrive: {
            
            return NSLocalizedString(@"Four Wheel Drive", @"");;
        }
        case VehicleSizeSpecial: {
            
            return NSLocalizedString(@"Special", @"");;
        }
        case VehicleSizeMiniElite: {
            
            return NSLocalizedString(@"Mini Elite", @"");;
        }
        case VehicleSizeEconomyElite: {
            
            return NSLocalizedString(@"Economy Elite", @"");;
        }
        case VehicleSizeCompactElite: {
            
            return NSLocalizedString(@"Compact Elite", @"");;
        }
        case VehicleSizeIntermediateElite: {
            
            return NSLocalizedString(@"Intermediate Elite", @"");;
        }
        case VehicleSizeStandardElite: {
            
            return NSLocalizedString(@"Standard Elite:", @"");;
        }
        case VehicleSizeFullsizeElite: {
            
            return NSLocalizedString(@"Fullsize Elite", @"");;
        }
        case VehicleSizePremiumElite: {
            
            return NSLocalizedString(@"Premium Elite", @"");;
        }
        case VehicleSizeLuxuryElite: {
            
            return NSLocalizedString(@"Luxury Elite", @"");;
        }
        case VehicleSizeOversize: {
            
            return NSLocalizedString(@"Oversize", @"");;
        }
        case VehicleSizeUnknown: {
            
            return NSLocalizedString(@"Unknown", @"");;
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
        return NSLocalizedString(@"Full to full", @"Full to full");
    }
    
    if (fuelPolicy == FuelPolicyFullEmptyRefund) {
        return NSLocalizedString(@"Full to empty refund", @"Full to empty refund");
    }
    
    if (fuelPolicy == FuelPolicyFullToEmpty) {
        return NSLocalizedString(@"Full to empty", @"Full to empty");
    }
    
    if (fuelPolicy == FuelPolicyElectricVehicle) {
        return NSLocalizedString(@"Electric vehicle", @"Electric vehicle");
    }
    
    if (fuelPolicy == FuelPolicyElectricVehicle) {
        return NSLocalizedString(@"Electric vehicle", @"Electric vehicle");
    }
    
    if (fuelPolicy == FuelPolicyEmptyToEmpty) {
        return NSLocalizedString(@"Empty to empty", @"Empty to empty");
    }
    
    if (fuelPolicy == FuelPolicyHalfToEmpty) {
        return NSLocalizedString(@"Half to empty", @"Half to empty");
    }
    
    if (fuelPolicy == FuelPolicyQuarterToEmpty) {
        return NSLocalizedString(@"Quarter to empty", @"Quarter to empty");
    }
    
    if (fuelPolicy == FuelPolicyHalfToHalf) {
        return NSLocalizedString(@"Half to half", @"Half to half");
    }
    
    if (fuelPolicy == FuelPolicyQuarterToQuarter) {
        return NSLocalizedString(@"Quarter to quarter", @"Quarter to quarter");
    }
    
    if (fuelPolicy == FuelPolicyQuarterToQuarter) {
        return NSLocalizedString(@"Unknown", @"Unknown");
    }
    
    if (fuelPolicy == FuelPolicyFullToFullHybrid) {
        return NSLocalizedString(@"Full to full hybrid", @"Full to full hybrid");
    }
    
    if (fuelPolicy == FuelPolicyChaufFullFull) {
        return NSLocalizedString(@"Full to full chauf", @"Full to full chauf");
    }
    
    return @"Unknown";
}

@end
