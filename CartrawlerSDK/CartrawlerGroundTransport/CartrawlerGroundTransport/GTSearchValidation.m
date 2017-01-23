//
//  GTSearchValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTSearchValidation.h"
#import "CTSDKSettings.h"

@implementation GTSearchValidation

- (void)validateGroundTransport:(GroundTransportSearch *)search
                  cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
                     completion:(CTSearchValidation)completion
{
    
    if (!search.airport) {
        completion(NO, @"You must select an airport", NO);
        return;
    }
    
    if (!search.pickupLocation) {
        completion(NO, @"Ground Transport Pickup location not set", NO);
        return;
    }
    
    if (!search.dropoffLocation) {
        completion(NO, @"Ground Transport Dropoff location not set", NO);
        return;
    }
    
    if (search.adultQty.intValue == 0) {    //we just need 1 adult passenger to make call
        completion(NO, @"No passengers set for Ground transport", NO);
        return;
    }
    
    [cartrawlerAPI groundTransportationAvail:search.airport
                              pickupLocation:search.pickupLocation
                             dropoffLocation:search.dropoffLocation
                     airportIsPickupLocation:search.airportIsPickupLocation
                                    adultQty:search.adultQty
                                    childQty:search.childQty
                                   infantQty:search.infantQty
                                   seniorQty:search.seniorQty
                                currencyCode:[CTSDKSettings instance].currencyCode
                                 countryCode:[CTSDKSettings instance].homeCountryCode
                                  completion:^(CTGroundAvailability *response, CTErrorResponse *error) {
                                      if (response) {
                                          search.availability = response;
                                          completion(YES, nil, NO);
                                      } else if (error) {
                                          completion(NO, error.errorMessage, NO);
                                      } else {
                                          completion(NO, @"Could not perform groundTransportationAvail", NO);
                                      }
                                  }];
    
    //TODO: REMOVE MOCK DATA
//    CTGroundAvailability *avail = [[CTGroundAvailability alloc] initWithDictionary:[self dictionaryWithContentsOfJSONString:@"MockGTRS.json"]];
//    search.availability = avail;
//    completion(YES, nil);
}

- (NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileName
{
    
    NSString *filePath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:fileName];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end
