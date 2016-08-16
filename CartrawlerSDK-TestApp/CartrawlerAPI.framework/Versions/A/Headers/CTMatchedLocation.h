//
//  VehMatchedLoc.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 13/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  CTMatchedLocation
 */
@interface CTMatchedLocation : NSObject

/**
 *  Bool value if location is at airport or not
 */
@property (nonatomic, readonly) BOOL isAtAirport;
/**
 *  If at an airport we are returned an airport code
 */
@property (nonatomic, strong, readonly) NSString *airportCode;
/**
 *  Location code
 */
@property (nonatomic, strong, readonly) NSString *code;
/**
 *  Location name
 */
@property (nonatomic, strong, readonly) NSString *name;
/**
 *  Location code context
 */
@property (nonatomic, strong, readonly) NSString *codeContext;
/**
 *  Location address line
 */
@property (nonatomic, strong, readonly) NSString *addressLine;
/**
 *  Location address code
 */
@property (nonatomic, strong, readonly) NSString *addressCode;
/**
 *  Location state code
 */
@property (nonatomic, strong, readonly) NSString *addressStateCode;
/**
 *  Location latitude, if available
 */
@property (nonatomic, strong, readonly) NSNumber *latitude;
/**
 *  Location longitude, if available
 */
@property (nonatomic, strong, readonly) NSNumber *longitude;
/**
 *  Location distance, if available
 */
@property (nonatomic, strong, readonly) NSNumber *distance;
/**
 *  Distance unit, km or miles, if available
 */
@property (nonatomic, strong, readonly) NSString *distanceUnit;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary  ;
- (instancetype)initWithPartialStringDictionary:(NSDictionary *)dictionary  ;
@end
