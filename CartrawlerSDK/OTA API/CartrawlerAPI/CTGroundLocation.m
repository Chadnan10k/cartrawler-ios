//
//  CTGroundAvail.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 23/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTGroundLocation.h"
#import "NSDateUtils.h"

@implementation CTGroundLocation

- (instancetype)initWithLatitude:(NSNumber *)latitude
                       longitude:(NSNumber *)longitude
                    locationType:(LocationType)locationType
                        dateTime:(NSDate *)dateTime
                            name:(NSString *)name
{
    _latitude = latitude;
    _longitude = longitude;
    _locationType = locationType;
    
    switch (locationType) {
        case LocationTypeAirport:
            _locationTypeDescription = @"Airport";
            break;
        case LocationTypeCompany:
            _locationTypeDescription = @"Company";
            break;
        case LocationTypeHotel:
            _locationTypeDescription = @"Hotel";
            break;
        case LocationTypeHomeResidence:
            _locationTypeDescription = @"HomeResidence";
            break;
        case LocationTypeTrainStation:
            _locationTypeDescription = @"TrainStation";
            break;
        case LocationTypeVicinity:
            _locationTypeDescription = @"Vicinity";
            break;
        case LocationTypeBusStation:
            _locationTypeDescription = @"BusStation";
            break;
    }

    _dateTime = dateTime;
    _name = name;
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    _latitude = dictionary[@"Address"][@"@Latitude"];
    _longitude = dictionary[@"Address"][@"@Longitude"];
  
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-DD'T'HH:mm:ss"; //2016-10-03T16:13:14

    df.locale = [NSLocale currentLocale];
    NSString *date = dictionary[@"@DateTime"];
    
    _dateTime = [df dateFromString:date];
    
    if ([dictionary[@"Address"][@"LocationType"] isKindOfClass:[NSDictionary class]]) {
        if(dictionary[@"Address"][@"LocationType"][@"@Code"]) {
            NSString *locType = dictionary[@"Address"][@"LocationType"][@"@Code"];
            _locationTypeDescription = locType;
            if ([locType isEqualToString:@"Airport"]) {
                _locationType = LocationTypeAirport;
            } else if ([locType isEqualToString:@"Company"]) {
                _locationType = LocationTypeCompany;
            } else if ([locType isEqualToString:@"Hotel"]) {
                _locationType = LocationTypeHotel;
            } else if ([locType isEqualToString:@"HomeResidence"]) {
                _locationType = LocationTypeHomeResidence;
            } else if ([locType isEqualToString:@"TrainStation"]) {
                _locationType = LocationTypeTrainStation;
            } else if ([locType isEqualToString:@"Vicinity"]) {
                _locationType = LocationTypeVicinity;
            } else if ([locType isEqualToString:@"BusStation"]) {
                _locationType = LocationTypeBusStation;
            }
        }
    } else {
    
        NSString *locType = dictionary[@"Address"][@"LocationType"];
        _locationTypeDescription = locType;
        
        if ([locType isEqualToString:@"Airport"]) {
            _locationType = LocationTypeAirport;
        } else if ([locType isEqualToString:@"Company"]) {
            _locationType = LocationTypeCompany;
        } else if ([locType isEqualToString:@"Hotel"]) {
            _locationType = LocationTypeHotel;
        } else if ([locType isEqualToString:@"HomeResidence"]) {
            _locationType = LocationTypeHomeResidence;
        } else if ([locType isEqualToString:@"TrainStation"]) {
            _locationType = LocationTypeTrainStation;
        } else if ([locType isEqualToString:@"Vicinity"]) {
            _locationType = LocationTypeVicinity;
        } else if ([locType isEqualToString:@"BusStation"]) {
            _locationType = LocationTypeBusStation;
        }
        
    }
    
    _name = dictionary[@"Address"][@"LocationName"];
    
    return self;
}

+ (LocationType)locationType:(LocationType)locationType
{
    return locationType;
}

@end
