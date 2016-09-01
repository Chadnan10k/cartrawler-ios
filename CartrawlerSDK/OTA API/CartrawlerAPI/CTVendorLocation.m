//
//  CTVendorLocation.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 23/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVendorLocation.h"

@implementation CTVendorLocation

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    _locationCode = dictionary[@"@Code"];
    _atAirport    = [dictionary[@"@AtAirport"] boolValue];
    
    if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VLI_1.VLI.X"]) { //terminal counter + pickup
        _pickupType = PickupTypeTerminal;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VLI_2.VLI.X"]) { //shuttle bus
        _pickupType = PickupTypeShuttleBus;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VLI_3.VLI.X"]) { //terminal counter + shuttle to car
        _pickupType = PickupTypeTerminalAndShuttle;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VLI_4.VLI.X"]) { //meet and greet
        _pickupType = PickupTypeMeetAndGreet;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VLI_5.VLI.X"]) { //N/A
        _pickupType = PickupTypeUnknown;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VLI_6.VLI.X"]) { //car driver
        _pickupType = PickupTypeCarDriver;
    } else {
        _pickupType = PickupTypeUnknown;
    }
    
    if ([dictionary[@"AdditionalInfo"][@"CounterLocation"][@"@Location"] isEqualToString:@"VWF_1.VWF.X"]) { //Terminal
        _locationType =  VendorLocationTypeTerminal;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VWF_2.VWF.X"]) { //Shuttle on airport
        _locationType =  VendorLocationTypeShuttleOnAirport;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VWF_3.VWF.X"]) { //Shuttle off airport
        _locationType =  VendorLocationTypeShuttleOffAirport;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VWF_4.VWF.X"]) { //Railway station
        _locationType =  VendorLocationTypeRailwayStation;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VWF_5.VWF.X"]) { //Hotel
        _locationType =  VendorLocationTypeHotel;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VWF_6.VWF.X"]) { //Car dealer
        _locationType =  VendorLocationTypeCarDealer;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VWF_7.VWF.X"]) { //City center/downtown
        _locationType =  VendorLocationTypeCityCenterDowntown;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VWF_8.VWF.X"]) { //East of city center
        _locationType =  VendorLocationTypeCityCenterEast;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VWF_9.VWF.X"]) { //South of city center
        _locationType =  VendorLocationTypeCityCenterSouth;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VWF_10.VWF.X"]) { //West of city center
        _locationType =  VendorLocationTypeCityCenterWest;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VWF_11.VWF.X"]) { //North of city center
        _locationType =  VendorLocationTypeCityCenterNorth;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VWF_12.VWF.X"]) { //Port/ferry
        _locationType =  VendorLocationTypeFerryPort;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VWF_13.VWF.X"]) { //Near resort
        _locationType =  VendorLocationTypeNearResort;
    } else if ([dictionary[@"AdditionalInfo"][@"VehRentLocInfos"][@"VehRentLocInfo"][@"@Type"] isEqualToString:@"VWF_14.VWF.X"]) { //Airport
        _locationType =  VendorLocationTypeAirport;
    }
    
    _locationName    = dictionary[@"@Name"];
    _address         = dictionary[@"Address"][@"AddressLine"];
    _countryCode     = dictionary[@"Address"][@"CountryName"][@"@Code"];
    _phone           = dictionary[@"Telephone"][@"@PhoneNumber"];
    
    //TODO: Add lat long
    
    return self;
}

@end
