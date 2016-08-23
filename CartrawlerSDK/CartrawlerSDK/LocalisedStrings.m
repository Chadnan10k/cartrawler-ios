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
            break;
        case PickupTypeShuttleBus:
            return NSLocalizedString(@"Free shuttle bus", @"");
            break;
        case PickupTypeTerminalAndShuttle:
            return NSLocalizedString(@"Free shuttle bus", @"");
            break;
        case PickupTypeMeetAndGreet:
            return NSLocalizedString(@"Meet and greet", @"");
            break;
        case PickupTypeCarDriver:
            return NSLocalizedString(@"Personal driver", @"");
            break;
        case PickupTypeUnknown:
            
            if (item.vendor.pickupLocation.atAirport) {
                return NSLocalizedString(@"At Airport", @"At Airport");
            } else {
                return NSLocalizedString(@"", @"");
            }
            
            return NSLocalizedString(@"", @"");
            break;
        default:
            if (item.vendor.pickupLocation.atAirport) {
                return NSLocalizedString(@"At Airport", @"At Airport");
            } else {
                return NSLocalizedString(@"", @"");
            }
            break;
    }
}

@end
