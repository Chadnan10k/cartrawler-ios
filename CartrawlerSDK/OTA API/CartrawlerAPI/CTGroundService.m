//
//  CTGroundService.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 24/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTGroundService.h"

@implementation CTGroundService

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];

    if ([dict[@"Service"][@"@DisabilityVehicleInd"] isEqualToString:@"true"]) {
        _disabilityVehicle = YES;
    } else {
        _disabilityVehicle = NO;
    }
    
    _maxPassengers = dict[@"Service"][@"@MaximumPassengers"];
    _maxBaggage = dict[@"Service"][@"@MaximumBaggage"];
    _meetAndGreet = [dict[@"Service"][@"@MeetAndGreetInd"] isEqualToString:@"true"] ? YES : NO;
    
    if (dict[@"Service"][@"Location"]) {
        _pickupLocation = [[CTGroundLocation alloc] initWithDictionary:dict[@"Service"][@"Location"][@"Pickup"]];
        _dropoffLocation = [[CTGroundLocation alloc] initWithDictionary:dict[@"Service"][@"Location"][@"Pickup"]];
    }
//
//    NSMutableArray *inclusionArr = [[NSMutableArray alloc] init];
//    for (NSString *str in dict[@"Reference"][@"TPA_Extensions"][@"GroundAvail"][@"Inclusions"]) {
//        CTGroundInclusion *inclusion = [[CTGroundInclusion alloc] initFromInclusionString:str];
//        [inclusionArr addObject:inclusion];
//    }
//    _inclusions = inclusionArr;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier: @"es_US"]];

    NSNumber *totalCharge = [numberFormatter numberFromString:dict[@"TotalCharge"][@"@RateTotalAmount"]];

    _currency = dict[@"TotalCharge"][@"@CurrencyCode"];
    _totalCharge = totalCharge;
    
    _refId = dict[@"Reference"][@"@ID"];
    _refUrl = dict[@"Reference"][@"@URL"];
    
    _companyName = dict[@"Reference"][@"CompanyName"][@"#text"];
    
    NSURL *vehImgUrl = [[NSURL alloc] initWithString:dict[@"Reference"][@"TPA_Extensions"][@"GroundAvail"][@"Vehicle"][@"PictureURL"]];
    
    _vehicleImage = vehImgUrl;
    _vehicleType = dict[@"Service"][@"VehicleType"];
    
    return self;
}

@end
