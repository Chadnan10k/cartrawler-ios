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
                                                      returnDate:nil
                                                       firstName:@"Lee"
                                                         surname:@"Maguire"
                                                       driverAge:@30
                                            additionalPassengers:@0
                                                           email:nil
                                                           phone:nil
                                                        flightNo:@"FR 1234"
                                                    addressLine1:nil
                                                    addressLine2:nil
                                                            city:nil
                                                        postcode:nil
                                                     countryCode:nil
                                                     countryName:nil
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
    [self.bookButton setTitle:@"you booked a car" forState:UIControlStateNormal];
    NSLog(@"%@", request);
    NSLog(@"%@", vehicle.vehicleName);
}


@end
