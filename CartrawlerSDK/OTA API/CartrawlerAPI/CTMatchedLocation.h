//
//  VehMatchedLoc.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 13/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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
@property (nonatomic, nonnull, readonly) NSString *airportCode;
/**
 *  Location code
 */
@property (nonatomic, nonnull, readonly) NSString *code;
/**
 *  Location name
 */
@property (nonatomic, nonnull, readonly) NSString *name;
/**
 *  Location code context
 */
@property (nonatomic, nonnull, readonly) NSString *countryCode;
/**
 *  Location address line
 */
@property (nonatomic, nonnull, readonly) NSString *addressLine;
/**
 *  Location state code
 */
@property (nonatomic, nonnull, readonly) NSString *addressStateCode;
/**
 *  Location latitude, if available
 */
@property (nonatomic, nullable, readonly) NSNumber *latitude;
/**
 *  Location longitude, if available
 */
@property (nonatomic, nullable, readonly) NSNumber *longitude;
/**
 *  Location distance, if available
 */
@property (nonatomic, nullable, readonly) NSNumber *distance;
/**
 *  Distance unit, km or miles, if available
 */
@property (nonatomic, nullable, readonly) NSString *distanceUnit;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithPartialStringDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithGooglePlacesDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
