//
//  StepSevenViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepSevenViewController.h"
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "CTSDKSettings.h"

@interface StepSevenViewController ()

@end

@implementation StepSevenViewController

- (void)makeBooking:(CTPaymentCard *)paymentCard completion:(StepOneCompletion)completion
{
    if (self.pickupLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.pickupLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffLocation == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.dropoffLocation IS NOT SET \n\n");
        return;
    }
    
    if (self.pickupDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.pickupDate IS NOT SET \n\n");
        return;
    }
    
    if (self.dropoffDate == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.dropoffDate IS NOT SET \n\n");
        return;
    }
    
    if (self.driverAge == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.driverAge IS NOT SET \n\n");
        return;
    }
    
    if (self.cartrawlerAPI == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.cartrawlerAPI IS NOT SET \n\n");
        return;
    }
    
    if (self.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.vehicleAvailability IS NOT SET \n\n");
        return;
    }
    
    if (self.insurance == nil && self.isBuyingInsurance) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.insurance IS NOT SET \n\n");
        return;
    }
    
    if (self.extras == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.extras IS NOT SET \n\n");
        return;
    }
    
    if (self.firstName == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.firstName IS NOT SET \n\n");
        return;
    }
    
    if (self.surname == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.surname IS NOT SET \n\n");
        return;
    }
    
    if (self.email == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.email IS NOT SET \n\n");
        return;
    }
    
    if (self.phone == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.phone IS NOT SET \n\n");
        return;
    }
    
    if (self.flightNumber == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.flightNumber IS NOT SET \n\n");
        return;
    }
    
    if (self.addressLine1 == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.addressLine1 IS NOT SET \n\n");
        return;
    }
    
    if (self.addressLine2 == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.addressLine2 IS NOT SET \n\n");
        return;
    }
    
    if (self.city == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.city IS NOT SET \n\n");
        return;
    }
    
    if (self.postcode == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.postcode IS NOT SET \n\n");
        return;
    }
    
    if (self.country == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS self.country IS NOT SET \n\n");
        return;
    }
    
    if (paymentCard == nil) {
        NSLog(@"\n\n ERROR: CANNOT MAKE BOOKING AS paymentCard IS NOT SET \n\n");
    }

    
    NSString *address = self.addressLine2 ?
    [NSString stringWithFormat:@"%@, %@, %@, %@, %@",
                                             self.addressLine1,
                                             self.addressLine2,
                                             self.city,
                                             self.postcode,
                                             [CTSDKSettings instance].homeCountryCode]
    :[NSString stringWithFormat:@"%@, %@, %@, %@",
    self.addressLine1,
    self.city,
    self.postcode,
      [CTSDKSettings instance].homeCountryCode];
    
    CTCustomer *customer = [[CTCustomer alloc] initWithHomeCountry:[CTSDKSettings instance].homeCountryCode
                                                               age:self.driverAge
                                                         firstName:self.firstName
                                                          lastName:self.surname
                                                             email:self.email
                                                           address:address
                                                             phone:self.phone];
    
    [self.cartrawlerAPI reserveVehicle:self.pickupDate
                        returnDateTime:self.dropoffDate
                    pickupLocationCode:self.pickupLocation.code
                    returnLocationCode:self.dropoffLocation.code
                          passengerQty:@3
                          flightNumber:self.flightNumber
                              customer:customer
                                   car:self.selectedVehicle
                                extras:self.extras
                              currency:[CTSDKSettings instance].currencyCode
                                  card:paymentCard
                       insuranceObject:self.isBuyingInsurance ? self.insurance : nil
                            completion:^(CTBooking *response, CTErrorResponse *error) {
                                if (response) {
                                    completion(YES, nil);
                                } else {
                                    completion(NO, nil);
                                }
                            }];
}

@end
