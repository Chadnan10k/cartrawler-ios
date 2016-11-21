//
//  ViewController.m
//  TestApp
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ViewController.h"
#import <CartrawlerSDK/CartrawlerSDK.h>

@interface ViewController () <CartrawlerSDKDelegate>

@property (nonatomic, strong) CartrawlerSDK *sdk;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CartrawlerSDK appearance].fontName = @"Roboto-Regular";
    [CartrawlerSDK appearance].boldFontName = @"Roboto-Bold";
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [CartrawlerSDK appearance].presentAnimated = YES;
    [CartrawlerSDK appearance].modalPresentationStyle = UIModalPresentationOverFullScreen;
    [CartrawlerSDK appearance].modalTransitionStyle = UIModalTransitionStyleCoverVertical;

    _sdk = [[CartrawlerSDK alloc] initWithRequestorID:@"643826" languageCode:@"EN" sandboxMode:NO];
    
    self.sdk.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openCarRental:(id)sender {
    [self.sdk presentCarRentalInViewController:self];
//    [self.sdk presentCarRentalInViewController:self
//                                     firstName:@"Lee"
//                                       surname:@"Maguire"
//                                     driverAge:@30
//                          additionalPassengers:@0
//                                         email:@"lmaguire@cartrawler.com"
//                                         phone:@"0865555555"
//                                      flightNo:@"FR1234"
//                                  addressLine1:@"123 Cartrawler St"
//                                  addressLine2:@""
//                                          city:@"Dublin"
//                                      postcode:@"Dublin 1"];
}

- (IBAction)openGroundTransport:(id)sender {
    [self.sdk presentGroundTransportInViewController:self];
}

#pragma Mark CartrawlerSDKDelegate

- (void)didCancelVehicleBooking
{
    NSLog(@"The vehicle booking was canceled");
}

- (void)didBookVehicle:(CTBooking *)booking
{
    NSLog(@"We booked a vehicle!");
}

@end
