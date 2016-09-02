//
//  GTShuttle.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTGroundShuttle.h"

@implementation CTGroundShuttle

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    //check if shuttle is available
    
    if ([dict[@"RateQualifier"][@"SpecialInputs"][@"@Value"] isEqualToString:@"NONE"]) {
        _serviceLevel = ServiceLevelNone;
    } else if ([dict[@"RateQualifier"][@"SpecialInputs"][@"@Value"] isEqualToString:@"STANDARD"]) {
        _serviceLevel = ServiceLevelStandard;
    } else if ([dict[@"RateQualifier"][@"SpecialInputs"][@"@Value"] isEqualToString:@"BUSINESS"]) {
        _serviceLevel = ServiceLevelBusiness;
    } else if ([dict[@"RateQualifier"][@"SpecialInputs"][@"@Value"] isEqualToString:@"PREMIUM"]) {
        _serviceLevel = ServiceLevelPremium;
    } else if ([dict[@"RateQualifier"][@"SpecialInputs"][@"@Value"] isEqualToString:@"STANDARD_CLASS"]) {
        _serviceLevel = ServiceLevelStandardClass;
    } else if ([dict[@"RateQualifier"][@"SpecialInputs"][@"@Value"] isEqualToString:@"FIRST_CLASS"]) {
        _serviceLevel = ServiceLevelFirstClass;
    }
    
    if ([dict[@"Shuttle"][@"@Vehicle"][@"@Type"][@"@Code"] isEqualToString:@"TRAIN"]) {
        _shuttleType = ShuttleTypeTrain;
    }
    
    
    if ([dict[@"Shuttle"][@"Vehicle"][@"@DisabilityInd"] isEqualToString:@"true"]) {
        _disabilityVehicle = YES;
    } else {
        _disabilityVehicle = NO;
    }
    
    _maxPassengers = dict[@"Shuttle"][@"Vehicle"][@"VehicleSize"][@"@MaxBaggageCapacity"];
    _maxBaggage = dict[@"Shuttle"][@"Vehicle"][@"VehicleSize"][@"@MaxPassengerCapacity"];
    
    //initialise the other half of the shuttle
    
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    for(NSDictionary *d in dict[@"Shuttle"][@"ServiceLocation"]) {
        CTGroundLocation *location = [[CTGroundLocation alloc] initWithDictionary:d];
        [locations addObject:location];
        
    }
    
    NSMutableArray *inclusionArr = [[NSMutableArray alloc] init];
    for (NSString *str in dict[@"Reference"][@"TPA_Extensions"][@"GroundAvail"][@"Inclusions"]) {
        CTGroundInclusion *inclusion = [[CTGroundInclusion alloc] initFromInclusionString:str];
        [inclusionArr addObject:inclusion];
    }
    _inclusions = inclusionArr;
    
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
