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
        completion(nil, @"CTAirport not set");
        return;
    }
    
    if (!search.pickupLocation) {
        completion(nil, @"Ground Transport Pickup location not set");
        return;
    }
    
    if (!search.dropoffLocation) {
        completion(nil, @"Ground Transport Dropoff location not set");
        return;
    }
    
    if (!search.adultQty) {    //we just need 1 adult passenger to make call
        completion(nil, @"No passengers set for Ground transport");
        return;
    }
    
//    [cartrawlerAPI groundTransportationAvail:search.airport
//                              pickupLocation:search.pickupLocation
//                             dropoffLocation:search.dropoffLocation
//                     airportIsPickupLocation:search.airportIsPickupLocation
//                                    adultQty:search.adultQty
//                                    childQty:search.childQty
//                                   infantQty:search.infantQty
//                                currencyCode:[CTSDKSettings instance].currencyCode
//                                  completion:^(CTGroundAvailability *response, CTErrorResponse *error) {
//                                      if (response) {
//                                          search.availability = response;
//                                          completion(response, nil);
//                                      } else if (error) {
//                                          completion(nil, error.errorMessage);
//                                      } else {
//                                          completion(nil, @"Could not perform groundTransportationAvail");
//                                      }
//                                  }];
    
    //TODO: REMOVE MOCK DATA
    CTGroundAvailability *avail = [[CTGroundAvailability alloc] initWithDictionary:[self dictionaryWithContentsOfJSONString:@"MockGTRS.json"]];
    search.availability = avail;
    completion(avail, nil);
}

- (NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileName {
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    
    NSString *filePath = [[[NSBundle bundleWithPath:bundlePath] resourcePath] stringByAppendingPathComponent:fileName];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end
