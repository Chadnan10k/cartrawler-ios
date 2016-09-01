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

@end
