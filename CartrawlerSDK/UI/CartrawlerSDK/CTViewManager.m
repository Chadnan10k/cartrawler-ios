//
//  CTViewManager.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTViewManager.h"
#import "CarRentalSearch.h"
#import "CTSDKSettings.h"
#import "PaymentValidation.h"
#import "InsuranceValidation.h"
#import "SearchValidation.h"
#import "GenericValidation.h"
#import "GTSearchValidation.h"
#import "GroundTransportSearch.h"

@interface CTViewManager()
typedef void (^VehAvailCompletion)(BOOL success, NSString *errorMessage);
typedef void (^InsuranceCompletion)(BOOL success, NSString *errorMessage);
@end

@implementation CTViewManager

+ (void)canTransitionToStep:(CTViewController *)step
            carRentalSearch:(CarRentalSearch *)carRentalSearch
      groundTransportSearch:(GroundTransportSearch *)groundTransportSearch
              cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
                 completion:(ValidationCompletion)completion
{
    
    if (!step) {
        NSLog(@"\n\n CartrawlerSDK ERROR: Destination View Controller is nil \n\n");
        completion(NO, @"Destination View Controller is nil");
        return;
    }
    
    switch (step.viewType) {
        case ViewTypeVehicleSelection:
        {
            [self canTransitionToVehicleSelection:cartrawlerAPI
                                           search:[CarRentalSearch instance]
                                       completion:^(BOOL success, NSString *errorMessage) {
                                           if (success) {
                                               completion(YES, nil);
                                               return;
                                           } else {
                                               completion(NO, errorMessage);
                                               return;
                                           }
                                       }];
        }
            break;
        case ViewTypeInsurance:
        {
            [self canTransitionToInsuranceQuote:cartrawlerAPI
                                         search:[CarRentalSearch instance]
                                     completion:^(BOOL success, NSString *errorMessage) {
                                         if (success) {
                                             completion(YES, nil);
                                             return;
                                         } else {
                                             completion(NO, errorMessage);
                                             return;
                                         }
                                     }];
        }
            break;
            
        case ViewTypeDriverDetails:
        {
            if ([GenericValidation validate:[CarRentalSearch instance]]) {
                completion(YES, nil);
                return;
            } else {
                completion(NO, @"");
                return;
            }
        }
            break;
            
        case ViewTypePaymentDetails:
        {
            if ([self validationForPaymentDetails:[CarRentalSearch instance]]) {
                completion(YES, nil);
                return;
            } else {
                completion(NO, @"ViewTypePaymentDetails: Validation error");
                return;
            }
        }
            break;
            
        case ViewTypeGeneric:
        {
            if ([GenericValidation validate:[CarRentalSearch instance]]) {
                completion(YES, nil);
                return;
            } else {
                completion(NO, @"");
                return;
            }
        }
            break;
        default:
        {
            completion(NO, @"CartrawlerSDK: Each CTViewController must have viewType set.");
        }
            break;
    }
    
    
}

+ (void)canTransitionToVehicleSelection:(CartrawlerAPI *)cartrawlerAPI
                                 search:(CarRentalSearch *)search
                             completion:(VehAvailCompletion)completion
{
    if (![SearchValidation validate:search]) {
        completion(NO, @"Validation error");
        return;
    }
    
    [cartrawlerAPI requestVehicleAvailabilityForLocation:search.pickupLocation.code
                                           returnLocationCode:search.dropoffLocation.code
                                          customerCountryCode:[CTSDKSettings instance].homeCountryCode
                                                 passengerQty:@3
                                                    driverAge:search.driverAge
                                               pickUpDateTime:search.pickupDate
                                               returnDateTime:search.dropoffDate
                                                 currencyCode:[CTSDKSettings instance].currencyCode
                                                   completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                                       if (response) {
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               search.vehicleAvailability = response;
                                                               completion(YES, nil);
                                                           });
                                                       } else {
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               completion(NO, error.errorMessage);
                                                           });
                                                       }
                                                   }];
}

+ (void)canTransitionToInsuranceQuote:(CartrawlerAPI *)cartrawlerAPI
                               search:(CarRentalSearch *)search
                           completion:(VehAvailCompletion)completion
{
    
    if (![InsuranceValidation validate: search]) {
        completion(NO, @"");
        return;
    }

    [cartrawlerAPI requestInsuranceQuoteForVehicle:[CTSDKSettings instance].homeCountryCode
                                               currency:[CTSDKSettings instance].currencyCode
                                              totalCost:[NSString stringWithFormat:@"%.02f", search.selectedVehicle.vehicle.totalPriceForThisVehicle.doubleValue]
                                         pickupDateTime:search.pickupDate
                                         returnDateTime:search.dropoffDate
                                 destinationCountryCode:search.pickupLocation.codeContext
                                             completion:
     ^(CTInsurance *response, CTErrorResponse *error) {
         if (response) {
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 search.insurance = response;
                 completion(YES, nil);
             });
             
         } else {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if (search.selectedVehicle.vehicle.extraEquipment.count == 0) {
                     search.insurance = nil;
                     search.isBuyingInsurance = NO;
                     completion(NO, @"");
                 } else {
                     search.insurance = nil;
                     search.isBuyingInsurance = NO;
                     completion(YES, nil);
                 }
             });
         }
     }];
}

+ (BOOL)validationForPaymentDetails:(CarRentalSearch *)search
{
    return [PaymentValidation validate:search];
}


@end
