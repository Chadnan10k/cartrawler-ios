//
//  RYRRentalManager.m
//  TestApp
//
//  Created by Lee Maguire on 18/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "RYRRentalManager.h"

@interface RYRRentalManager()

@property (strong, nonatomic) NSDate *pickupDate;
@property (strong, nonatomic) NSDate *dropoffDate;
@property (weak, nonatomic) UIViewController *inPathViewController;
@property (nonatomic) BOOL isProduction;

@end

@implementation RYRRentalManager

+ (instancetype)instance
{
    static RYRRentalManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RYRRentalManager alloc] init];
        sharedInstance.isProduction = NO;
        [sharedInstance setup];
    });
    return sharedInstance;
}

- (BOOL)currentEndpoint
{
    return self.isProduction;
}

- (void)changeEndpoint:(BOOL)production
{
    _isProduction = production;
    [self setup];
}

- (void)changeEndpointInPath:(BOOL)production
{
    _isProduction = production;
    [self setup];
    [self reset];
}

- (void)reset
{
    
	CTPassenger *passenger1 = [CTPassenger passengerWithFirstName:@"Lee"
														 lastName:@"Maguire"
													 addressLine1:@"123 Cartrawler St"
													 addressLine2:nil
															 city:@"Dundrum"
														 postcode:@"D18"
													  countryCode:@"IE"
															  age:@22
															email:@"lmaguire@cartrawler.com"
															phone:@"0861111111"
												  isPrimaryDriver:YES];
	
	CTPassenger *passenger2 = [CTPassenger passengerWithFirstName:@"John"
														 lastName:@"Smith"
													 addressLine1:@"123 Cartrawler St"
													 addressLine2:nil
															 city:@"Dundrum"
														 postcode:@"D18"
													  countryCode:@"IE"
															  age:@30
															email:nil
															phone:nil
												  isPrimaryDriver:NO];
	
	
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:86400];
    _pickupDate = date;

	
    [self.inPath performSearchWithIATACode:@"ALC"
                                pickupDate:self.pickupDate
                                returnDate:[self.pickupDate dateByAddingTimeInterval:260000]
                              flightNumber:@"FR 1234"
                                  currency:@"EUR"
                                 passegers:@[passenger1, passenger2]
                                  clientID:@"642619"
                      parentViewController:self.parent];

	
    [self.callToAction setTitle:@"Loading" forState:UIControlStateNormal];

}

- (void)setup
{
    NSString * language = @"en";

    _sdk = [[CartrawlerSDK alloc] initWithlanguageCode:language sandboxMode:!self.isProduction];
    [self.sdk enableLogs:NO];
    _rental = [[CartrawlerRental alloc] initWithCartrawlerSDK:self.sdk];
    _inPath = [CartrawlerInPath initWithCartrawlerRental:self.rental];
    self.inPath.delegate = self;

    [self.sdk addAnalyticsProvider:[CartrawlerRakuten new]];

    self.rental.delegate = self;
    
    [self.sdk enableLogs:NO];
}

- (void)setupInPath:(UIView *)view parentVC:(UIViewController *)parentVC;
{
    [self reset];
    self.inPathViewController = parentVC;
    [self.inPath addCrossSellCardToView:view];
}

- (void)inPathOpenEngine:(UIViewController *)vc
{
    [self.inPath presentAllCars:vc];
}

- (void)removeVehicle
{
    [self.inPath removeVehicle];
}

- (void)changeRoundTrip:(BOOL)isRoundTrip
{
    if (isRoundTrip) {
        _dropoffDate = [self.pickupDate dateByAddingTimeInterval:112000];
    } else {
        _dropoffDate = nil;
    }
    [self.callToAction setTitle:@"LOADING" forState:UIControlStateNormal];
    [self reset];
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

#pragma mark InPath delegate

- (void)didReceiveBestDailyRate:(NSNumber *)price currency:(NSString *)currency
{
    [self.callToAction setTitle:[NSString stringWithFormat:@"Cars from: %@ %@", currency, price] forState:UIControlStateNormal];
}

- (void)didProduceInPathPaymentRequest:(NSDictionary *)request vehicle:(CTInPathVehicle *)vehicle
{
    [self.callToAction setTitle:@"you booked a car" forState:UIControlStateNormal];
    NSLog(@"Total %@", vehicle.totalCost);
    NSLog(@"Insurance %@", vehicle.insuranceCost);

    NSLog(@"%@", request);
    NSLog(@"%@", vehicle.vehicleName);
    NSLog(@"%@", vehicle.firstName);
    NSLog(@"%@", vehicle.lastName);
    
    NSLog(@"*** PAYNOW: %@ ** PAYLATER: %@ ** PAYDESK: %@ ** BOOKINGFEE: %@", vehicle.payNowPrice, vehicle.payLaterPrice, vehicle.payAtDeskPrice, vehicle.bookingFeePrice);
    
}

- (void)didFailToReceiveBestDailyRate
{
    [self.callToAction setTitle:@"Book a car" forState:UIControlStateNormal];
}

- (void)didTapCrossSellCard {
    [self.inPath presentAllCars:self.inPathViewController];
}

- (void)mockPayment
{
    [self.inPath didReceiveBookingConfirmationID:@"INPATH"];
}

@end
