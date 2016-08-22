//
// Copyright 2014 Etrawler
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
//  Vendor.h
//  CarTrawler
//
//

#import <Foundation/Foundation.h>
#import "CTVehicle.h"
#import "CTVendorRating.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTVendor
 */
@interface CTVendor : NSObject

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
 *  The vendor code
 */
@property (nonatomic, nonnull) NSString *code;
/**
 *  The vendor name
 */
@property (nonatomic, nonnull) NSString *name;
/**
 *  The vendor division
 */
@property (nonatomic, nonnull) NSString *division;
/**
 *  Picture url for the vendor logo
 */
@property (nonatomic, nonnull) NSURL *logoURL;
/**
 *  The vendor ID
 */
@property (nonatomic, nonnull) NSString *ID;
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
/**
 *  Vendor rating
 */
@property (nonatomic, nonnull) CTVendorRating *rating;
/**
 *  Drop off vendor
 */
@property (nonatomic, weak) CTVendor *dropoffVendor;
/**
 *  Available cars from the vendor
 */
@property (nonatomic, nonnull) NSArray<CTVehicle *> *availableCars;

- (instancetype)initFromVehVendorAvailsDictionary:(NSDictionary *)vehVendorAvails  ;

@end

NS_ASSUME_NONNULL_END


