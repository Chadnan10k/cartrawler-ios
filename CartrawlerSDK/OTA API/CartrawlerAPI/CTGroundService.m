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
    
    //check if shuttle is available
    
    if (dict[@"Shuttle"]) {
        
        if ([dict[@"Shuttle"][@"Vehicle"][@"@DisabilityInd"] isEqualToString:@"true"]) {
            _disabilityVehicle = YES;
        } else {
            _disabilityVehicle = NO;
        }
        
        _maxPassengers = dict[@"Shuttle"][@"Vehicle"][@"VehicleSize"][@"@MaxBaggageCapacity"];
        _maxBaggage = dict[@"Shuttle"][@"Vehicle"][@"VehicleSize"][@"@MaxPassengerCapacity"];
        
        //initialise the other half of the shuttle
        
    } else {
        
        if ([dict[@"Service"][@"@DisabilityVehicleInd"] isEqualToString:@"true"]) {
            _disabilityVehicle = YES;
        } else {
            _disabilityVehicle = NO;
        }
        
        _maxPassengers = dict[@"Service"][@"@MaxPassengerCapacity"];
        _maxBaggage = dict[@"Service"][@"@MaxBaggageCapacity"];
        
    }
    
//    if ([dict[@"Service"][@"ServiceLevel"] isEqualToString:@"NONE"]) {
//        _serviceLevel = ServiceLevelNone;
//    } else if ([dict[@"Service"][@"ServiceLevel"] isEqualToString:@"STANDARD"]) {
//        _serviceLevel = ServiceLevelStandard;
//    } else if ([dict[@"Service"][@"ServiceLevel"] isEqualToString:@"BUSINESS"]) {
//        _serviceLevel = ServiceLevelBusiness;
//    } else if ([dict[@"Service"][@"ServiceLevel"] isEqualToString:@"PREMIUM"]) {
//        _serviceLevel = ServiceLevelPremium;
//    } else if ([dict[@"Service"][@"ServiceLevel"] isEqualToString:@"STANDARD_CLASS"]) {
//        _serviceLevel = ServiceLevelStandardClass;
//    } else if ([dict[@"Service"][@"ServiceLevel"] isEqualToString:@"FIRST_CLASS"]) {
//        _serviceLevel = ServiceLevelFirstClass;
//    }
    
    //get inclusions
    
    NSLog(@"%@", dict[@"Reference"][@"TPA_Extensions"][@"GroundAvail"][@"Inclusions"]);
    
    NSMutableArray *inclusionArr = [[NSMutableArray alloc] init];
    for (NSString *str in dict[@"Reference"][@"TPA_Extensions"][@"GroundAvail"][@"Inclusions"]) {
        GTInclusion *inclusion = [[GTInclusion alloc] initFromInclusionString:str];
        [inclusionArr addObject:inclusion];
    }
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber *totalCharge = [numberFormatter numberFromString:dict[@"TotalCharge"][@"@RateTotalAmount"]];

    _currency = dict[@"TotalCharge"][@"@CurrencyCode"];
    _totalCharge = totalCharge;
    
    _refId = dict[@"Reference"][@"@ID"];
    _refUrl = dict[@"Reference"][@"@URL"];
    
    _companyName = dict[@"Reference"][@"CompanyName"][@"#text"];
    
    NSURL *vehImgUrl = [[NSURL alloc] initWithString:dict[@"Reference"][@"TPA_Extensions"][@"GroundAvail"][@"Vehicle"][@"PictureURL"]];
    
    _vehicleImage = vehImgUrl;
    
    //TODO: Locations
    return self;
}

@end
