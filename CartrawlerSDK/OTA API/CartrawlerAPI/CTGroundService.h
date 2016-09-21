//
//  CTGroundService.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 24/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTGroundService.h"
#import "CTGroundInclusion.h"
#import "CTGroundLocation.h"
#import "CTGroundItem.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTGroundService
 */
@interface CTGroundService : CTGroundItem

@property (nonatomic, nonnull, readonly) CTGroundLocation *pickupLocation;

@property (nonatomic, nonnull, readonly) CTGroundLocation *dropoffLocation;

@property (nonatomic, readonly) BOOL disabilityVehicle;

@property (nonatomic, readonly) BOOL meetAndGreet;

@property (nonatomic, nonnull, readonly) NSArray <CTGroundInclusion *> *inclusions;
/**
 *  The service level eg. First class, economy class
 */
@property (nonatomic, readonly) ServiceLevel serviceLevel;
/**
 *  Picture url for the vehicle
 */
@property (nonatomic, nonnull, readonly) NSURL *vehicleImage;
/**
 *  The max amount of passengers the vehicle can hold
 */
@property (nonatomic, nonnull, readonly) NSNumber *maxPassengers;
/**
 *  The max amount of baggage the vehicle can hold
 */
@property (nonatomic, nonnull, readonly) NSNumber *maxBaggage;
/**
 *  The vehicle type
 */
@property (nonatomic, nonnull, readonly) NSString *vehicleType;
/**
 *  The vehicle size
 */
@property (nonatomic, nonnull, readonly) NSString *vehicleSize;
/**
 *  The currency code of the price
 */
@property (nonatomic, nonnull, readonly) NSString *currency;
/**
 *  The total charge of the service
 */
@property (nonatomic, nonnull, readonly) NSNumber *totalCharge;
/**
 *  Reference url for the service
 */
@property (nonatomic, nonnull, readonly) NSString *refUrl;
/**
 *  Reference ID for the service
 */
@property (nonatomic, nonnull, readonly) NSString *refId;
/**
 *  The name of the company providing the service
 */
@property (nonatomic, nonnull, readonly) NSString *companyName;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
