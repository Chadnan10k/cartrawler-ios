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
    
    if ([dict[@"Service"][@"@MeetAndGreetInd"]isEqualToString:@"true"]) {
        _meetAndGreet = YES;
    } else {
        _meetAndGreet = NO;
    }
    
    _maxPassengers = dict[@"Service"][@"@MaximumPassengers"];
    _maxBaggage = dict[@"Service"][@"@MaximumBaggage"];
    _serviceLevel = dict[@"Service"][@"ServiceLevel"];
    _vehicleType = dict[@"Service"][@"VehicleType"];
    _vehicleSize = dict[@"Service"][@"VehicleSize"];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber *totalCharge = [numberFormatter numberFromString:dict[@"TotalCharge"][@"@RateTotalAmount"]];

    _currency = dict[@"TotalCharge"][@"@CurrencyCode"];
    _totalCharge = totalCharge;
    
    _refId = dict[@"Reference"][@"@ID"];
    _refUrl = dict[@"Reference"][@"@URL"];
    
    _companyName = dict[@"Reference"][@"CompanyName"][@"#text"];
    
    NSURL *vehImgUrl = [[NSURL alloc] initWithString:dict[@"Reference"][@"TPA_Extensions"][@"GroundAvail"][@"Vehicle"][@"PictureURL"]];
    
    _vehicleImage = vehImgUrl;
    return self;
}

@end
