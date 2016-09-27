//
//  CarRentalSearch.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CarRentalSearch.h"
#import "CTSDKSettings.h"

@implementation CarRentalSearch

+ (instancetype)instance
{
    static CarRentalSearch *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CarRentalSearch alloc] init];
    });
    return sharedInstance;
}

- (void)reset
{
    _vehicleAvailability = nil;
    _selectedVehicle = nil;
    _pickupLocation = nil;
    _dropoffLocation = nil;
    _pickupDate = nil;
    _dropoffDate = nil;
    _driverAge = [NSNumber numberWithInteger:0];
    _passengerQty = [NSNumber numberWithInteger:1];
    _insurance = nil;
    _insuranceItem = nil;
    _isBuyingInsurance = NO;
    _firstName = nil;
    _surname = nil;
    _email = nil;
    _phone = nil;
    _flightNumber = nil;
    _addressLine1 = nil;
    _addressLine2 = nil;
    _city = nil;
    _postcode = nil;
    _country = nil;
}

- (NSString *)concatinatedAddress
{
    if (![self.addressLine2 isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%@, %@, %@, %@, %@", self.addressLine1, self.addressLine2, self.city, self.postcode, self.country];
    } else {
        return [NSString stringWithFormat:@"%@, %@, %@, %@", self.addressLine1, self.city, self.postcode, self.country];
    }
}

- (void)refreshResults:(RefreshCompletion)completion
{
    
    CartrawlerAPI *cartrawlerAPI = [[CartrawlerAPI alloc] initWithClientKey:[CTSDKSettings instance].clientId
                                                                   language:[CTSDKSettings instance].languageCode
                                                                      debug:[CTSDKSettings instance].isDebug];
    
    [cartrawlerAPI requestVehicleAvailabilityForLocation:self.pickupLocation.code
                                      returnLocationCode:self.dropoffLocation.code
                                     customerCountryCode:[CTSDKSettings instance].homeCountryCode
                                            passengerQty:self.passengerQty
                                               driverAge:self.driverAge
                                          pickUpDateTime:self.pickupDate
                                          returnDateTime:self.dropoffDate
                                            currencyCode:[CTSDKSettings instance].currencyCode
                                              completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                                  if (response) {
                                                      _vehicleAvailability = response;
                                                      completion(YES, @"");
                                                  } else {
                                                      completion(NO, error.errorMessage);
                                                  }
                                              }];
}

@end
