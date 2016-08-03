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
    PickupTypeShuttleBus = 1,
    /**
     *  In terminal counter, shuttle to car
     */
    PickupTypeTerminalAndShuttle = 2,
    /**
     *  Meet and greet
     */
    PickupTypeMeetAndGreet = 3,
    /**
     *  Chaufur service
     */
    PickupTypeCarDriver = 4,
    /**
     *  Unknown pickup type
     */
    PickupTypeUnknown = 5
};

/**
 *  Counter type enum, this uses VWF
 */
typedef NS_ENUM(NSUInteger, CounterType) {
    /**
     *  Terminal
     */
    CounterTypeTerminal = 0,
    /**
     *  Shuttle on airport
     */
    CounterTypeShuttleOnAirport = 1,
    /**
     *  Shuttle off airport
     */
    CounterTypeShuttleOffAirport = 2,
    /**
     *  Railway station
     */
    CounterTypeRailwayStation = 3,
    /**
     *  Hotel
     */
    CounterTypeHotel = 4,
    /**
     *  Car dealer
     */
    CounterTypeCarDealer = 5,
    /**
     *  City center/downtown
     */
    CounterTypeCityCenterDowntown = 6,
    /**
     *  East of city center
     */
    CounterTypeCityCenterEast = 7,
    /**
     *  South of city center
     */
    CounterTypeCityCenterSouth = 8,
    /**
     *  West of city center
     */
    CounterTypeCityCenterWest = 9,
    /**
     *  North of city center
     */
    CounterTypeCityCenterNorth = 10,
    /**
     *  Port/ferry
     */
    CounterTypeFerryPort = 11,
    /**
     *  Near resort
     */
    CounterTypeNearResort = 12,
    /**
     *  Airport
     */
    CounterTypeAirport = 12
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
@property (nonatomic) CounterType counterType;
/**
 *  The vendor code
 */
@property (nonatomic, strong) NSString *code;
/**
 *  The vendor name
 */
@property (nonatomic, strong) NSString *name;
/**
 *  The vendor division
 */
@property (nonatomic, strong) NSString *division;
/**
 *  Picture url for the vendor logo
 */
@property (nonatomic, strong) NSURL *logoURL;
/**
 *  The vendor ID
 */
@property (nonatomic, strong) NSString *ID;
/**
 *  The vendor location code
 */
@property (nonatomic, strong) NSString *locationCode;
/**
 *  The vendor location name
 */
@property (nonatomic, strong) NSString *locationName;
/**
 *  The vendor address
 */
@property (nonatomic, strong) NSString *address;
/**
 *  The vendor country code
 */
@property (nonatomic, strong) NSString *countryCode;
/**
 *  The vendor phone number
 */
@property (nonatomic, strong) NSString *phone;
/**
 *  Vendor rating
 */
@property (nonatomic, strong) CTVendorRating *rating;
/**
 *  Drop off vendor
 */
@property (nonatomic, strong) CTVendor *dropoffVendor;
/**
 *  Available cars from the vendor
 */
@property (nonatomic, strong) NSArray<CTVehicle *> *availableCars;

- (id)initFromVehVendorAvailsDictionary:(NSDictionary *)vehVendorAvails;

@end


