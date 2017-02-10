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
    CTUserDetails *userDetails = [CTUserDetails new];
    userDetails.firstName = @"Lee";
    userDetails.surname = @"Maguire";
    userDetails.email = @"lee@maguire.com";
    userDetails.phone = @"+086666666";
    userDetails.currency = @"GBP";
    userDetails.driverAge = @21;
    userDetails.flightNo = @"FR 777";

    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:86400];
    _pickupDate = date;
    _inPath = [[CartrawlerInPath alloc] initWithCartrawlerRental:self.rental
                                                        IATACode:@"LGW"
                                                      pickupDate:self.pickupDate
                                                      returnDate:self.dropoffDate
                                                     userDetails:userDetails];
    
    self.inPath.delegate = self;
    [self.callToAction setTitle:@"Loading" forState:UIControlStateNormal];

}

- (void)setup
{
    _sdk = [[CartrawlerSDK alloc] initWithRequestorID:@"642619" languageCode:@"el" sandboxMode:!self.isProduction];
    _rental = [[CartrawlerRental alloc] initWithCartrawlerSDK:self.sdk];
    
    [self.sdk addAnalyticsProvider:[CartrawlerRakuten new]];

    [self.sdk enableLogs:NO];
    self.rental.delegate = self;
}

- (void)setupInPath:(UIView *)view
{
    if (!self.inPath) {
        [self reset];
    }
    
    [self.inPath addCrossSellCardToView:view];
}

- (void)inPathOpenEngine:(UIViewController *)vc
{
    [self.inPath presentCarRentalWithFlightDetails:vc];
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

- (void)didProduceInPathRequest:(NSDictionary *)request vehicle:(CTInPathVehicle *)vehicle
{
    [self.callToAction setTitle:@"you booked a car" forState:UIControlStateNormal];
    NSLog(@"Total %@", vehicle.totalCost);
    NSLog(@"Insurance %@", vehicle.insuranceCost);

    NSLog(@"%@", request);
    NSLog(@"%@", vehicle.vehicleName);
    NSLog(@"%@", vehicle.firstName);
    NSLog(@"%@", vehicle.lastName);
    
}

- (void)didFailToReceiveBestDailyRate
{
    [self.callToAction setTitle:@"Book a car" forState:UIControlStateNormal];
}

- (void)mockPayment
{
    [self.inPath didReceiveBookingConfirmationID:@"INPATH"];
}

@end
