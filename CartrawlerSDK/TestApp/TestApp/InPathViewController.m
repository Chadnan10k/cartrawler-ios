//
//  InPathViewController.m
//  TestApp
//
//  Created by Lee Maguire on 19/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "InPathViewController.h"
#import <CartrawlerInPath/CartrawlerInPath.h>

@interface InPathViewController () <CartrawlerInPathDelegate>

@property (nonatomic, strong) CartrawlerInPath *inPath;
@property (weak, nonatomic) IBOutlet UIView *cardContainer;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;

@end

@implementation InPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _inPath = [[CartrawlerInPath alloc] initWithCartrawlerRental:self.rental
                                                        IATACode:@"ALC"
                                                      pickupDate:[NSDate dateWithTimeIntervalSinceNow:48000]
                                                      returnDate:[NSDate dateWithTimeIntervalSinceNow:128000]
                                                       firstName:@"Lee"
                                                         surname:@"Maguire"
                                                       driverAge:@30
                                            additionalPassengers:@3
                                                           email:@"lmaguire@cartrawler.com"
                                                           phone:@"0866666666"
                                                        flightNo:@"FR1234"
                                                    addressLine1:@"123 Cartrawler St."
                                                    addressLine2:@""
                                                            city:@"Dublin"
                                                        postcode:@"D1"
                                                     countryCode:@"IE"
                                                     countryName:@"Ireland"
                                                      completion:nil];
    self.inPath.delegate = self;
    [self.inPath addCrossSellCardToView:self.cardContainer];
}

- (IBAction)bookCar:(id)sender {
    [self.inPath presentCarRentalWithFlightDetails:self];
}

- (IBAction)mockPayment:(id)sender {
    [self.inPath didReceiveBookingResponse:@{@"bookingId" : @"INPATHTEST"}];
}

- (IBAction)remove:(id)sender {
    [self.inPath removeVehicle];
}

- (void)didReceiveBestDailyRate:(NSNumber *)price currency:(NSString *)currency
{
    [self.bookButton setTitle:[NSString stringWithFormat:@"Cars from: %@ %@", currency, price] forState:UIControlStateNormal];
}

- (void)didProduceInPathRequest:(NSDictionary *)request vehicle:(CTInPathVehicle *)vehicle
{
    NSLog(@"%@", request);
    NSLog(@"%@", vehicle.vehicleName);
}


@end
