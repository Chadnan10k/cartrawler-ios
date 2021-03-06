//
//  VehMatchedLoc.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 13/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTMatchedLocation.h"

@implementation CTMatchedLocation

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (dictionary[@"LocationDetail"] != nil) {
        NSDictionary *tempDict = dictionary[@"LocationDetail"];
        
        if (tempDict[@"@AtAirport"] != nil) {
            if ([tempDict[@"@AtAirport"] isEqualToString:@"0"]) {
                _isAtAirport = NO;
            } else if ([tempDict[@"@AtAirport"] isEqualToString:@"1"]) {
                _isAtAirport = YES;
            }
        }
        
        if (tempDict[@"@Code"] != nil) {
            _code = tempDict[@"@Code"];
        }
        
        if (tempDict[@"@Name"] != nil) {
            _name = tempDict[@"@Name"];
        }
        
        if (tempDict[@"Address"] != nil) {
            NSDictionary *addressDict = tempDict[@"Address"];
            if (addressDict[@"AddressLine"] != nil && [addressDict[@"AddressLine"] isKindOfClass:[NSString class]]) {
                _addressLine = addressDict[@"AddressLine"];
            } else {
                _addressLine = @"";
            }
            if (addressDict[@"CountryName"] != nil) {
                NSDictionary *countryDict = addressDict[@"CountryName"];
                if (countryDict[@"@Code"] != nil) {
                    _countryCode = countryDict[@"@Code"];
                    _addressStateCode = countryDict[@"@StateCode"];
                }
            }
        }
    }
    
    if (dictionary[@"LocationDetail"][@"AdditionalInfo"][@"TPA_Extensions"][@"Position"] != nil) {
        NSDictionary *locDict = dictionary[@"LocationDetail"][@"AdditionalInfo"][@"TPA_Extensions"][@"Position"];
        _latitude = locDict[@"@Latitude"];
        _longitude = locDict[@"@Longitude"];
    }
    
    if (dictionary[@"LocationDetail"][@"AdditionalInfo"][@"TPA_Extensions"][@"SearchRef"] != nil) {
        NSDictionary *locDict = dictionary[@"LocationDetail"][@"AdditionalInfo"][@"TPA_Extensions"][@"SearchRef"];
        _distance = locDict[@"@Distance"];
        _distanceUnit = locDict[@"@DistanceMeasure"];
    }
    
    _airportCode = @"";
    _latitude = @0.0;
    _longitude = @0.0;
    _distance = @0.0;
    _distanceUnit = @"";
    
    return self;
}

- (instancetype)initWithPartialStringDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    _addressLine = @"";
    _distanceUnit = @"";
    _addressStateCode = @"";
    _distance = @0.0;
    
    _airportCode = dictionary[@"@AirportCode"] ?: @"";
    
    if ([self.airportCode isEqualToString:@""]) {
        _isAtAirport = NO;
    } else {
        _isAtAirport = YES;
    }
    
    NSNumberFormatter *f = [NSNumberFormatter new];
    [f setLocale:[[NSLocale alloc] initWithLocaleIdentifier: @"en_US"]];

    f.numberStyle = NSNumberFormatterDecimalStyle;
    f.maximumFractionDigits = 5;

    _latitude = [f numberFromString:dictionary[@"@Lat"]] ?: @0.0;
    _longitude = [f numberFromString:dictionary[@"@Lng"]] ?: @0.0;

    _countryCode = dictionary[@"@CountryCode"];
    _code = dictionary[@"@Code"];
    _name = dictionary[@"@Name"];
    
    return self;
}

- (instancetype)initWithGooglePlacesDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    for (NSString *type in dictionary[@"types"]) {
        if ([type isEqualToString:@"airport"]) {
            _isAtAirport = YES;
        }
    }
    
    _name = dictionary[@"formatted_address"];
    _addressLine = dictionary[@"formatted_address"];
    _latitude = dictionary[@"geometry"][@"location"][@"lat"];
    _longitude = dictionary[@"geometry"][@"location"][@"lng"];

    return self;
}

@end
