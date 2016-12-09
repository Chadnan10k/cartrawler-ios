//
//  ViewController.m
//  TestApp
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ViewController.h"
#import <CartrawlerSDK/CartrawlerSDK.h>
#import "InPathViewController.h"

@interface ViewController () <CartrawlerSDKDelegate>

//@property (nonatomic, strong) CartrawlerSDK *sdk;

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

    [[CartrawlerSDK instance] setRequestorID:@"642619" languageCode:@"EN" sandboxMode:YES];
    
    [CartrawlerSDK instance].delegate = self;
}

- (IBAction)openCarRental:(id)sender {
    [[CartrawlerSDK instance] presentCarRentalInViewController:self];
}

#pragma Mark CartrawlerSDKDelegate

- (void)didCancelVehicleBooking
{
    NSLog(@"The vehicle booking was canceled");
}

#pragma mark For standalone
- (void)didBookVehicle:(CTBooking *)booking
{
    NSLog(@"We booked a vehicle!");
}


@end
