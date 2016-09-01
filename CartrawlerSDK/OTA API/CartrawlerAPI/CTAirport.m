//
//  CTAirport.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 24/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTAirport.h"

@implementation CTAirport

- (instancetype)initWithFlightType:(FlightType)flightType
                IATACode:(NSString *)IATACode
          terminalNumber:(NSString *)terminalNumber
{
    switch (flightType) {
        case FlightTypeArrival:
            _flightType = @"Arrival";
            break;
        case FlightTypeDeparture:
            _flightType = @"Departure";
            break;
    }
    
    _IATACode = IATACode;
    _terminalNumber = terminalNumber;
    
    return self;
}

+ (FlightType)flightType:(FlightType)flightType
{
    return flightType;
}

@end
