//
//  CTGroundAvail.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 23/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
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
    LocationTypeCompany = 1,
    /**
     *  Hotel Location
     */
    LocationTypeHotel = 2,
    /**
     *  Home Residence Location
     */
    LocationTypeHomeResidence = 3,
    /**
     *  Train Station Location
     */
    LocationTypeTrainStation = 4,
    /**
     *  Vicinity Area
     */
    LocationTypeVicinity = 5,
};
/**
 *  The latitude of the location
 */
@property (nonatomic, strong, readonly) NSNumber *latitude;
/**
 *  The longitude of the location
 */
@property (nonatomic, strong, readonly) NSNumber *longitude;
/**
 *  String representation of the LocationType enum
 */
@property (nonatomic, strong, readonly) NSString *locationType;
/**
 *  the date / time for searching availability of a location
 */
@property (nonatomic, strong, readonly) NSDate   *dateTime;

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
- (id)initWithLatitude:(NSNumber *)latitude
             longitude:(NSNumber *)longitude
          locationType:(LocationType)locationType
              dateTime:(NSDate *)dateTime;

/**
 *  Convenience method for getting the LocationType
 *
 *  @param locationType Use LocationType enum
 *
 *  @return A LocationType
 */
+ (LocationType)locationType:(LocationType)locationType;

@end
