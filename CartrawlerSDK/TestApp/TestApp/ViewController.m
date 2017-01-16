//
//  ViewController.m
//  TestApp
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ViewController.h"
#import <CartrawlerSDK/CartrawlerSDK.h>
#import <CartrawlerRental/CartrawlerRental.h>
#import "InPathViewController.h"

@interface ViewController () <CartrawlerRentalDelegate>

@property (nonatomic, strong) CartrawlerSDK *sdk;
@property (nonatomic, strong) CartrawlerRental *rental;
@property (weak, nonatomic) IBOutlet UISegmentedControl *endpointControl;

@property (nonatomic) BOOL isDebug;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad]; //643826 ryr desktop 642619 ryr mobile
    _isDebug = YES;
    _sdk = [[CartrawlerSDK alloc] initWithRequestorID:@"642619" languageCode:@"EN" sandboxMode:YES];
    [self.sdk enableLogs:YES];
    _rental = [[CartrawlerRental alloc] initWithCartrawlerSDK:self.sdk];
    
    self.rental.delegate = self;
}

- (IBAction)openCarRental:(id)sender {
    _sdk = [[CartrawlerSDK alloc] initWithRequestorID:@"642619" languageCode:@"EN" sandboxMode:self.isDebug];
    _rental = [[CartrawlerRental alloc] initWithCartrawlerSDK:self.sdk];
    [self.rental presentCarRentalInViewController:self];
}

- (IBAction)endpointChanged:(id)sender {
    if (self.endpointControl.selectedSegmentIndex == 0) {
        _isDebug = YES;
    } else {
        _isDebug = NO;
    }
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    _sdk = [[CartrawlerSDK alloc] initWithRequestorID:@"642619" languageCode:@"EN" sandboxMode:self.isDebug];
    _rental = [[CartrawlerRental alloc] initWithCartrawlerSDK:self.sdk];
    InPathViewController *vc = segue.destinationViewController;
    vc.rental = self.rental;
}


@end
