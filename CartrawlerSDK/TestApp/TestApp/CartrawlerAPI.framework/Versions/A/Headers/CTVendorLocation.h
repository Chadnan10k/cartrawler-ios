//
//  CTVendorLocation.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 23/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTVendorLocation : NSObject

/**
 *  Pickup type enum, use this for info like 'Free shuttle bus etc.'
 */
typedef NS_ENUM(NSUInteger, PickupType) {
    /**
     *  Terminal pickup
     */
    PickupTypeTerminal = 0,
    /**
     *  Shuttle bus pickup
     */
    PickupTypeShuttleBus,
    /**
     *  In terminal counter, shuttle to car
     */
    PickupTypeTerminalAndShuttle,
    /**
     *  Meet and greet
     */
    PickupTypeMeetAndGreet,
    /**
     *  Chaufur service
     */
    PickupTypeCarDriver,
    /**
     *  Unknown pickup type
     */
    PickupTypeUnknown
};

/**
 *  Counter type enum, this uses VWF
 */
typedef NS_ENUM(NSUInteger, VendorLocationType) {
    /**
     *  Terminal
     */
    VendorLocationTypeTerminal = 0,
    /**
     *  Shuttle on airport
     */
    VendorLocationTypeShuttleOnAirport,
    /**
     *  Shuttle off airport
     */
    VendorLocationTypeShuttleOffAirport,
    /**
     *  Railway station
     */
    VendorLocationTypeRailwayStation,
    /**
     *  Hotel
     */
    VendorLocationTypeHotel,
    /**
     *  Car dealer
     */
    VendorLocationTypeCarDealer,
    /**
     *  City center/downtown
     */
    VendorLocationTypeCityCenterDowntown,
    /**
     *  East of city center
     */
    VendorLocationTypeCityCenterEast,
    /**
     *  South of city center
     */
    VendorLocationTypeCityCenterSouth,
    /**
     *  West of city center
     */
    VendorLocationTypeCityCenterWest,
    /**
     *  North of city center
     */
    VendorLocationTypeCityCenterNorth,
    /**
     *  Port/ferry
     */
    VendorLocationTypeFerryPort,
    /**
     *  Near resort
     */
    VendorLocationTypeNearResort,
    /**
     *  Airport
     */
    VendorLocationTypeAirport
};

/**
 *  Bool value stating if vendor is at airport or not
 */
@property (nonatomic) BOOL atAirport;
/**
 *  Vendor pickup type, In terminal, free shuttle bus etc..
 */
@property (nonatomic) PickupType pickupType;
/**
 *  Vendor counter type
 */
@property (nonatomic) VendorLocationType locationType;
/**
 *  The vendor location code
 */
@property (nonatomic, nonnull) NSString *locationCode;
/**
 *  The vendor location name
 */
@property (nonatomic, nonnull) NSString *locationName;
/**
 *  The vendor address
 */
@property (nonatomic, nonnull) NSString *address;
/**
 *  The vendor country code
 */
@property (nonatomic, nonnull) NSString *countryCode;
/**
 *  The vendor phone number
 */
@property (nonatomic, nonnull) NSString *phone;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

