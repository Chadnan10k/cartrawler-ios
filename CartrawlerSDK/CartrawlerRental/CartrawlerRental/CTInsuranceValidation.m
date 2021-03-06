//
//  CTInsuranceValidation.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInsuranceValidation.h"
#import <CartrawlerSDK/CTSDKSettings.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@implementation CTInsuranceValidation

- (void)validateCarRental:(CTRentalSearch *)search
            cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
               completion:(CTSearchValidationCompletion)completion
{

    if (search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupLocation IS NOT SET \n\n");
        completion(NO, @"", NO);
        return;
    }

    if (search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffLocation IS NOT SET \n\n");
        completion(NO, @"", NO);
        return;
    }

    if (search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.pickupDate IS NOT SET \n\n");
        completion(NO, @"", NO);
        return;
    }

    if (search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.dropoffDate IS NOT SET \n\n");
        completion(NO, @"", NO);
        return;
    }

    if (search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.driverAge IS NOT SET \n\n");
        completion(NO, @"", NO);
        return;
    }

    if (search.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH AS self.vehicleAvailability IS NOT SET \n\n");
        completion(NO, @"", NO);
        return;
    }
    
    if (search.selectedVehicle.vehicle.insuranceAvailable) {
        [cartrawlerAPI requestInsuranceQuoteForVehicle:[CTSDKSettings instance].homeCountryCode
                                              currency:[CTSDKSettings instance].currencyCode
                                             totalCost:[NSString stringWithFormat:@"%.02f", search.selectedVehicle.vehicle.totalPriceForThisVehicle.doubleValue]
                                        pickupDateTime:search.pickupDate
                                        returnDateTime:search.dropoffDate
                                destinationCountryCode:search.pickupLocation.countryCode
                                selectedVehicle:search.selectedVehicle
                                            completion:
         ^(CTInsurance *response, CTErrorResponse *error) {
             if (response) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     search.insurance = response;
                     completion(YES, nil, NO);
                 });
                 
             } else {
                 if (error) {
                     [[CTAnalytics instance] tagError:@"step4" event:@"InsuranceQuoteRQ fail" message:error.errorMessage];
                 }
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (search.selectedVehicle.vehicle.extraEquipment.count > 0) {
                         search.insurance = nil;
                         search.isBuyingInsurance = NO;
                         completion(NO, CTLocalizedString(CTRentalErrorNoInsuranceAvailable), YES);
                     } else {
                         search.insurance = nil;
                         search.isBuyingInsurance = NO;
                         completion(NO, CTLocalizedString(CTRentalErrorNoInsuranceAvailable), NO);
                     }
                 });
             }
         }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (search.selectedVehicle.vehicle.extraEquipment.count > 0) {
                search.insurance = nil;
                search.isBuyingInsurance = NO;
                completion(NO, CTLocalizedString(CTRentalErrorNoInsuranceAvailable), YES);
            } else {
                search.insurance = nil;
                search.isBuyingInsurance = NO;
                completion(NO, CTLocalizedString(CTRentalErrorNoInsuranceAvailable), NO);
            }
        });
    }
    
}

@end
