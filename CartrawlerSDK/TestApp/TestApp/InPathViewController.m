//
//  InPathViewController.m
//  TestApp
//
//  Created by Lee Maguire on 08/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "InPathViewController.h"
#import "CT+NSNumber.h"
#import <CartrawlerInPath/CartrawlerInPath.h>

@interface InPathViewController () <CartrawlerInPathDelegate>

@property (weak, nonatomic) IBOutlet UIView *inPathViewContainer;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;

@property (strong, nonnull) CTInPathVehicle *selectedVehicle;
@property (strong, nonnull) NSDictionary *selectedVehicleDict;
@property (strong, nonatomic) CartrawlerInPath *inPath;

@property (nonatomic) BOOL didBookCar;

@end

@implementation InPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CartrawlerSDK *sdk = [[CartrawlerSDK alloc] initWithRequestorID:@"642619" languageCode:@"EN" sandboxMode:YES];
    _inPath = [[CartrawlerInPath alloc] initWithCartrawlerSDK:sdk];
    [self.inPath addCrossSellCardToView:self.inPathViewContainer];
    self.inPath.delegate = self;
}

- (IBAction)openInPath:(id)sender
{
    if (self.didBookCar) {
        _didBookCar = NO;
        _selectedVehicle = nil;
        _selectedVehicleDict = nil;
        [self.inPath removeVehicle];
        [self.bookButton setTitle:@"Book vehicle" forState:UIControlStateNormal];
    } else {
        [self.inPath presentCarRentalWithFlightDetails:@"ALC"
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
    [self.inPath didReceiveBookingResponse:@{@"bookingId" : @"INPATH67890"}];
}

#pragma mark For in path

- (void)didProduceInPathRequest:(nonnull NSDictionary *)request vehicle:(nonnull CTInPathVehicle *)vehicle
{
    [self.bookButton setTitle:@"Remove vehicle" forState:UIControlStateNormal];
    NSLog(@"%@", request);
    _selectedVehicle = vehicle;
    _selectedVehicleDict = request;
    _didBookCar = YES;
}

@end
