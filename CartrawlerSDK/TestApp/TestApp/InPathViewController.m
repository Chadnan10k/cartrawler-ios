//
//  InPathViewController.m
//  TestApp
//
//  Created by Lee Maguire on 08/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "InPathViewController.h"
#import <CartrawlerSDK/CTInPathView.h>
#import "CT+NSNumber.h"

@interface InPathViewController () <CartrawlerSDKDelegate>

@property (weak, nonatomic) IBOutlet CTInPathView *inPathView;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;

@property (strong, nonnull) CTInPathVehicle *selectedVehicle;
@property (strong, nonnull) NSDictionary *selectedVehicleDict;

@property (nonatomic) BOOL didBookCar;

@end

@implementation InPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [CartrawlerSDK instance].delegate = self;
}

- (IBAction)openInPath:(id)sender
{
    if (self.didBookCar) {
        _didBookCar = NO;
        [self.inPathView renderDefault];
        _selectedVehicle = nil;
        _selectedVehicleDict = nil;
        [self.bookButton setTitle:@"Book vehicle" forState:UIControlStateNormal];
    } else {
        [[CartrawlerSDK instance] presentCarRentalWithFlightDetails:@"ALC"
                                         pickupDate:[NSDate dateWithTimeIntervalSinceNow:480000]
                                         returnDate:[NSDate dateWithTimeIntervalSinceNow:960000]
                                          firstName:@"Lee"
                                            surname:@"Maguire"
                                          driverAge:@30
                               additionalPassengers:@3
                                              email:@"lmaguire@cartrawler.com"
                                              phone:@"0866666666"
                                           flightNo:@"FR1234"
                                       addressLine1:nil
                                       addressLine2:nil
                                               city:nil
                                           postcode:nil
                                        countryCode:@"IE"
                                        countryName:@"Ireland"
                                    isInPathBooking:YES
                                 overViewController:self
                                         completion:^(BOOL success, NSString * _Nonnull errorMessage) {
                                             if (errorMessage) {
                                                 NSLog(@"%@", errorMessage);
                                             }
                                         }];
    }
}

- (IBAction)makePayment:(id)sender
{
    //Lets simulate a successful payment
    [[CartrawlerSDK instance] didMakeInPathBooking:@{@"bookingId" : @"INPATH12345"}];
}

#pragma mark For in path
- (void)didGenerateInPathRequest:(NSDictionary *)request vehicle:(CTInPathVehicle *)vehicle
{
    [self.inPathView renderVehicleDetails:vehicle];
    [self.bookButton setTitle:@"Remove vehicle" forState:UIControlStateNormal];
    NSLog(@"%@", request);
    _selectedVehicle = vehicle;
    _selectedVehicleDict = request;
    _didBookCar = YES;
}

@end
