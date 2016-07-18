//
//  StepSixViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepSixViewController.h"
#import "CTImageCache.h"

@interface StepSixViewController () <UIAlertViewDelegate>

@end
//driver details base
@implementation StepSixViewController

- (void)pushToStepSeven
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
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.driverAge IS NOT SET \n\n");
        return;
    }
    
    if (self.cartrawlerAPI == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.cartrawlerAPI IS NOT SET \n\n");
        return;
    }
    
    if (self.selectedVehicle == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.vehicleAvailability IS NOT SET \n\n");
        return;
    }
    
    if (self.insurance == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.insurance IS NOT SET \n\n");
        return;
    }
    
    if (self.extras == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.extras IS NOT SET \n\n");
        return;
    }
    
    if (self.firstName == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.firstName IS NOT SET \n\n");
        return;
    }
    
    if (self.surname == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.surname IS NOT SET \n\n");
        return;
    }
    
    if (self.email == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.email IS NOT SET \n\n");
        return;
    }
    
    if (self.phone == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.phone IS NOT SET \n\n");
        return;
    }
    
    if (self.flightNumber == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.flightNumber IS NOT SET \n\n");
        return;
    }
    
    if (self.addressLine1 == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.addressLine1 IS NOT SET \n\n");
        return;
    }
    
    if (self.addressLine2 == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.addressLine2 IS NOT SET \n\n");
        return;
    }
    
    if (self.city == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.city IS NOT SET \n\n");
        return;
    }
    
    if (self.postcode == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.postcode IS NOT SET \n\n");
        return;
    }
    
    if (self.country == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.country IS NOT SET \n\n");
        return;
    }
    
    if (self.stepSevenViewController == nil) {
        NSLog(@"\n\n ERROR: CANNOT PUSH TO STEP SEVEN AS self.stepSevenViewController IS NOT SET \n\n");
        return;
    }
    
    [self.stepSevenViewController setSelectedVehicle:self.selectedVehicle];
    [self.stepSevenViewController setPickupDate:self.pickupDate];
    [self.stepSevenViewController setDropoffDate:self.dropoffDate];
    [self.stepSevenViewController setPickupLocation:self.pickupLocation];
    [self.stepSevenViewController setDropoffLocation:self.dropoffLocation];
    [self.stepSevenViewController setDriverAge:self.driverAge];
    [self.stepSevenViewController setPassengerQty:self.passengerQty];
    [self.stepSevenViewController setCartrawlerAPI:self.cartrawlerAPI];
    [self.stepSevenViewController setInsurance:self.insurance];
    [self.stepSevenViewController setIsBuyingInsurance:self.isBuyingInsurance];
    [self.stepSevenViewController setExtras:self.extras];
    [self.stepSevenViewController setFirstName:self.firstName];
    [self.stepSevenViewController setSurname:self.surname];
    [self.stepSevenViewController setEmail:self.email];
    [self.stepSevenViewController setPhone:self.phone];
    [self.stepSevenViewController setFlightNumber:self.flightNumber];
    [self.stepSevenViewController setAddressLine1:self.addressLine1];
    [self.stepSevenViewController setAddressLine2:self.addressLine2];
    [self.stepSevenViewController setCity:self.city];
    [self.stepSevenViewController setPostcode:self.postcode];
    [self.stepSevenViewController setCountry:self.country];
    //[self.navigationController pushViewController:self.stepSevenViewController animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"End of CTSDK demo"
                                                        message:@"🚗"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[CTImageCache sharedInstance] removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
