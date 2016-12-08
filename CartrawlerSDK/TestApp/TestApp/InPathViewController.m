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

@end

@implementation InPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sdk.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openInPath:(id)sender
{
    [self.sdk presentCarRentalWithFlightDetails:@"ALC"
                                     pickupDate:[NSDate dateWithTimeIntervalSinceNow:480000]
                                     returnDate:[NSDate dateWithTimeIntervalSinceNow:960000]
                                      firstName:@"Lee"
                                        surname:@"Maguire"
                                      driverAge:@30
                           additionalPassengers:@3
                                          email:@"lmaguire@cartrawler.com"
                                          phone:@"0866666666"
                                       flightNo:@"FR1234"
                                   addressLine1:@"123 abc"
                                   addressLine2:@""
                                           city:@"Dublin"
                                       postcode:@""
                                    countryCode:@"IE"
                                    countryName:@"Ireland"
                                isInPathBooking:YES
                             overViewController:self
                                     completion:^(BOOL success, NSString * _Nonnull errorMessage) {
                                         
                                     }];
}

#pragma mark For in path
- (void)didGenerateInPathRequest:(NSDictionary *)request vehicle:(CTInPathVehicle *)vehicle
{
    [self.inPathView renderVehicleDetails:vehicle];
    [self.bookButton setTitle:[NSString stringWithFormat:@"Car for %@", [vehicle.totalCost numberStringWithCurrencyCode]] forState:UIControlStateNormal];
    NSLog(@"%@", request);
}

@end
