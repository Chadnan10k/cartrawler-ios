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

@property (strong, nonatomic) NSDate *pickupDate;
@property (strong, nonatomic) NSDate *dropoffDate;
@property (weak, nonatomic) IBOutlet UISwitch *oneWaySwitch;

@end

@implementation InPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:56000];
    _pickupDate = date;
    [self resetInPath];
}

- (void)resetInPath
{
    for (UIView *sv in self.cardContainer.subviews) {
        [sv removeFromSuperview];
    }
    
    CTUserDetails *userDetails = [CTUserDetails new];
    userDetails.firstName = @"Lee";
    userDetails.surname = @"Maguire";
    userDetails.email = @"lee@maguire.com";
    userDetails.phone = @"086666666";
    userDetails.currency = @"GBP";
    userDetails.driverAge = @30;
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:56000];
    _pickupDate = date;
    
    _inPath = [[CartrawlerInPath alloc] initWithCartrawlerRental:self.rental
                                                        IATACode:@"ALC"
                                                      pickupDate:self.pickupDate
                                                      returnDate:self.dropoffDate
                                                     userDetails:userDetails];
    self.inPath.delegate = self;
    [self.inPath addCrossSellCardToView:self.cardContainer];
}

- (IBAction)bookCar:(id)sender {
    [self.inPath presentCarRentalWithFlightDetails:self];
}

- (IBAction)mockPayment:(id)sender {
    [self.inPath didReceiveBookingConfirmationID:@"INPATH"];
}

- (IBAction)remove:(id)sender {
    [self.inPath removeVehicle];
}

- (IBAction)loadCard:(id)sender {

    [self.inPath addCrossSellCardToView:self.cardContainer];
}

- (IBAction)oneWayChanged:(id)sender {
    UISwitch *s = (UISwitch *)sender;

    if (s.isOn) {
        _dropoffDate = nil;
    } else {
        _dropoffDate = [self.pickupDate dateByAddingTimeInterval:112000];
    }
    [self.bookButton setTitle:@"LOADING" forState:UIControlStateNormal];
    [self resetInPath];
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
    NSLog(@"%@", vehicle.firstName);
    NSLog(@"%@", vehicle.lastName);

}

- (void)didFailToReceiveBestDailyRate
{
    [self.bookButton setTitle:@"Book a car" forState:UIControlStateNormal];
}


@end
