//
//  CTAirport.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 24/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  CTAirport
 */
@interface CTAirport : NSObject

/**
 *  Flight Type
 */
typedef NS_ENUM(NSUInteger, FlightType) {
    /**
     *  Arrival flight
     */
    FlightTypeArrival = 0,
    /**
     *  Departure Flight
     */
    FlightTypeDeparture = 1
};

/**
 *  The flight type in string value
 */
@property (nonatomic, strong, readonly) NSString *flightType;
/**
 *  The IATA code
 */
@property (nonatomic, strong, readonly) NSString *IATACode;
/**
 *  The terminal number
 */
@property (nonatomic, strong, readonly) NSString *terminalNumber;

/**
 *  Creates a CTAirport object
 *
 *  @param flightType     Use the flight type enum
 *  @param IATACode       The IATA code for the airport eg. DUB. MCO
 *  @param terminalNumber The terminal number/name
 *
 *  @return returns initialized CTAirport
 */
- (id)initWithFlightType:(FlightType)flightType
                IATACode:(NSString *)IATACode
          terminalNumber:(NSString *)terminalNumber;

/**
 *  Convenience method to get a flight type
 *
 *  @param flightType Use the flight type enum
 *
 *  @return Returns a FlightType
 */
+ (FlightType)flightType:(FlightType)flightType;
@end
