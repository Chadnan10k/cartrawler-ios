//
//  CTGroundAvail.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 23/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTGroundLocation.h"

@implementation CTGroundLocation

- (instancetype)initWithLatitude:(NSNumber *)latitude
             longitude:(NSNumber *)longitude
          locationType:(LocationType)locationType
              dateTime:(NSDate *)dateTime
{
    _latitude = latitude;
    _longitude = longitude;
    switch (locationType) {
        case LocationTypeAirport:
            _locationType = @"Airport";
            break;
        case LocationTypeCompany:
            _locationType = @"Company";
            break;
        case LocationTypeHotel:
            _locationType = @"Hotel";
            break;
        case LocationTypeHomeResidence:
            _locationType = @"HomeResidence";
            break;
        case LocationTypeTrainStation:
            _locationType = @"TrainStation";
            break;
        case LocationTypeVicinity:
            _locationType = @"Vicinity";
            break;
    }

    _dateTime = dateTime;
    return self;
}


+ (LocationType)locationType:(LocationType)locationType
{
    return locationType;
}

@end
