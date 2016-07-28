//
//  CTViewManager.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTViewManager.h"
#import "CTSearchDetailsViewController.h"
#import "CTSearch.h"
#import "CTSDKSettings.h"

#import "VehicleSelectionViewController.h"
#import "StepThreeViewController.h"
#import "StepFourViewController.h"
#import "StepFiveViewController.h"
#import "StepSixViewController.h"
#import "StepSevenViewController.h"

@interface CTViewManager()

@end

@implementation CTViewManager

+ (BOOL)canTransitionToStep:(CTViewController *)step search:(CTSearch *)search
{
    if ([step isKindOfClass:[StepThreeViewController class]]) {
        return [self validateSelectionStep:search];
    }
    
    if ([step isKindOfClass:[StepFourViewController class]]) {
        return [self validateVehicleDetailsStep:search];
    }
    
    if ([step isKindOfClass:[StepFiveViewController class]]) {
        return [self validateInsuranceExtrasStop:search];
    }
    
    if ([step isKindOfClass:[StepSixViewController class]]) {
        return [self validationForDriverDetails:search];
    }
    
    if ([step isKindOfClass:[StepSevenViewController class]]) {
        return [self validationForPaymentDetails:search];
    }
    
    return NO;
}

+ (void)canTransitionToVehicleSelection:(CartrawlerAPI *)cartrawlerAPI
                             completion:(VehAvailCompletion)completion
{
    
    if ([CTSearch instance].pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.pickupLocation IS NOT SET \n\n");
        completion(NO, @"search.pickupLocation is not set");
        return;
    }
    
    if ([CTSearch instance].dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.dropoffLocation IS NOT SET \n\n");
        completion(NO, @"search.dropoffLocation is not set");
        return;
    }
    
    if ([CTSearch instance].pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.pickupDate IS NOT SET \n\n");
        completion(NO, @"search.pickupDate is not set");
        return;
    }
    
    if ([CTSearch instance].dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.dropoffDate IS NOT SET \n\n");
        completion(NO, @"search.dropoffDate is not set");
        return;
    }
    
    if ([CTSearch instance].driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP TWO AS self.driverAge IS NOT SET \n\n");
        completion(NO, @"search.driverAge is not set");
        return;
    }
    
    [cartrawlerAPI requestVehicleAvailabilityForLocation:[CTSearch instance].pickupLocation.code
                                           returnLocationCode:[CTSearch instance].dropoffLocation.code
                                          customerCountryCode:[CTSDKSettings instance].homeCountryCode
                                                 passengerQty:@3
                                                    driverAge:[CTSearch instance].driverAge
                                               pickUpDateTime:[CTSearch instance].pickupDate
                                               returnDateTime:[CTSearch instance].dropoffDate
                                                 currencyCode:[CTSDKSettings instance].currencyCode
                                                   completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                                       if (response) {
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               [CTSearch instance].vehicleAvailability = response;
                                                               completion(YES, nil);
                                                           });
                                                       } else {
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               completion(NO, error.errorMessage);
                                                           });
                                                       }
                                                   }];
}

+ (BOOL)validateSelectionStep:(CTSearch *)search;
{
    
    if (search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.pickupLocation IS NOT SET \n\n");
        return NO;
    }

    if (search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.dropoffLocation IS NOT SET \n\n");
        return NO;
    }

    if (search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.pickupDate IS NOT SET \n\n");
        return NO;
    }

    if (search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.dropoffDate IS NOT SET \n\n");
        return NO;
    }

    if (search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.driverAge IS NOT SET \n\n");
        return NO;
    }

    if (search.vehicleAvailability == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.vehicleAvailability IS NOT SET \n\n");
        return NO;
    }
    
    if (search.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP THREE AS self.selectedVehicle IS NOT SET \n\n");
        return NO;
    }
    
    return YES;
}

+ (BOOL)validateVehicleDetailsStep:(CTSearch *)search;
{
    
    if (search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.pickupLocation IS NOT SET \n\n");
        return NO;
    }

    if (search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.dropoffLocation IS NOT SET \n\n");
        return NO;
    }

    if (search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.pickupDate IS NOT SET \n\n");
        return NO;
    }

    if (search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.dropoffDate IS NOT SET \n\n");
        return NO;
    }

    if (search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.driverAge IS NOT SET \n\n");
        return NO;
    }

    if (search.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FOUR AS self.vehicleAvailability IS NOT SET \n\n");
        return NO;
    }
    
    return YES;
}

+ (BOOL)validateInsuranceExtrasStop:(CTSearch *)search;
{
    if (search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.pickupLocation IS NOT SET \n\n");
        return NO;
    }
    
    if (search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.dropoffLocation IS NOT SET \n\n");
        return NO;
    }
    
    if (search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.pickupDate IS NOT SET \n\n");
        return NO;
    }
    
    if (search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.dropoffDate IS NOT SET \n\n");
        return NO;
    }
    
    if (search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.driverAge IS NOT SET \n\n");
        return NO;
    }
    
    if (search.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.vehicleAvailability IS NOT SET \n\n");
        return NO;
    }
    
    if (search.selectedVehicle.extraEquipment == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS extras IS NOT SET \n\n");
        return NO;
    }
    
    return YES;
}

+ (BOOL)validationForDriverDetails:(CTSearch *)search
{
    if (search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.pickupLocation IS NOT SET \n\n");
        return NO;
    }
    
    if (search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.dropoffLocation IS NOT SET \n\n");
        return NO;
    }
    
    if (search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.pickupDate IS NOT SET \n\n");
        return NO;
    }
    
    if (search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.dropoffDate IS NOT SET \n\n");
        return NO;
    }
    
    if (search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.driverAge IS NOT SET \n\n");
        return NO;
    }
    
    if (search.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS self.vehicleAvailability IS NOT SET \n\n");
        return NO;
    }
    
    if (search.selectedVehicle.extraEquipment == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP FIVE AS extras IS NOT SET \n\n");
        return NO;
    }
    
    return YES;
}

+ (BOOL)validationForPaymentDetails:(CTSearch *)search
{
    if (search.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.pickupLocation IS NOT SET \n\n");
        return NO;
    }
    
    if (search.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.dropoffLocation IS NOT SET \n\n");
        return NO;
    }
    
    if (search.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.pickupDate IS NOT SET \n\n");
        return NO;
    }
    
    if (search.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.dropoffDate IS NOT SET \n\n");
        return NO;
    }
    
    if (search.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.driverAge IS NOT SET \n\n");
        return NO;
    }
    
    if (search.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.vehicleAvailability IS NOT SET \n\n");
        return NO;
    }
    
    if (search.insurance == nil && search.isBuyingInsurance) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.insurance IS NOT SET \n\n");
        return NO;
    }
    
    if (search.firstName == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.firstName IS NOT SET \n\n");
        return NO;
    }
    
    if (search.surname == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.surname IS NOT SET \n\n");
        return NO;
    }
    
    if (search.email == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.email IS NOT SET \n\n");
        return NO;
    }
    
    if (search.phone == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.phone IS NOT SET \n\n");
        return NO;
    }
    
    if (search.flightNumber == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.flightNumber IS NOT SET \n\n");
        return NO;
    }
    
    if (search.addressLine1 == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.addressLine1 IS NOT SET \n\n");
        return NO;
    }
    
    if (search.addressLine2 == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.addressLine2 IS NOT SET \n\n");
        return NO;
    }
    
    if (search.city == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.city IS NOT SET \n\n");
        return NO;
    }
    
    if (search.postcode == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.postcode IS NOT SET \n\n");
        return NO;
    }
    
    if (search.country == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.country IS NOT SET \n\n");
        return NO;
    }
    
    return YES;
}



@end
