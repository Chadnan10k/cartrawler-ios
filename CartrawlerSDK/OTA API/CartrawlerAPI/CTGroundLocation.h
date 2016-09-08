//
//  CTGroundAvail.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 23/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTGroundLocation
 */
@interface CTGroundLocation : NSObject

/**
 *  Location Type enum
 */
typedef NS_ENUM(NSUInteger, LocationType) {
    /**
     *  Airport Location
     */
    LocationTypeAirport = 0,
    /**
     *  Company Location
     */
    LocationTypeCompany,
    /**
     *  Hotel Location
     */
    LocationTypeHotel,
    /**
     *  Home Residence Location
     */
    LocationTypeHomeResidence,
    /**
     *  Train Station Location
     */
    LocationTypeTrainStation,
    /**
     *  Vicinity Area
     */
    LocationTypeVicinity
};
/**
 *  The latitude of the location
 */
@property (nonatomic, nonnull, readonly) NSNumber *latitude;

/**
 *  The longitude of the location
 */
@property (nonatomic, nonnull, readonly) NSNumber *longitude;

/**
 *  String representation of the LocationType enum
 */
@property (nonatomic, nonnull, readonly) NSString *locationTypeDescription;

@property (nonatomic, nonnull, readonly) NSString *name;

@property (nonatomic, readonly) LocationType locationType;

/**
 *  the date / time for searching availability of a location
 */
@property (nonatomic, nonnull, readonly) NSDate *dateTime;

/**
 *  Use this for searching the ground transport services of a location
 *
 *  @param latitude     The location latitude
 *  @param longitude    The location longitude
 *  @param locationType Use LocationType enum
 *  @param dateTime     The Date / Time needed for pickup / dropoff
 *
 *  @return Initialized CTGroundLocation
 */
- (instancetype)initWithLatitude:(NSNumber *)latitude
             longitude:(NSNumber *)longitude
          locationType:(LocationType)locationType
              dateTime:(NSDate *)dateTime
                  name:(NSString *)name;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 *  Convenience method for getting the LocationType
 *
 *  @param locationType Use LocationType enum
 *
 *  @return A LocationType
 */
+ (LocationType)locationType:(LocationType)locationType;



@end

NS_ASSUME_NONNULL_END
