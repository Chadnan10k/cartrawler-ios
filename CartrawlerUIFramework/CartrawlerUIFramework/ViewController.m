//
//  ViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ViewController.h"
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface ViewController ()
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSDateComponents *pickupComp;
@property (nonatomic, strong) NSDateComponents *dropoffComp;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _pickupComp = [[NSDateComponents alloc] init];
    [self.pickupComp setDay:5];
    [self.pickupComp  setMonth:6];
    [self.pickupComp  setYear:2016];
    [self.pickupComp  setHour:13];
    [self.pickupComp  setMinute:30];
    [self.pickupComp  setSecond:00];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _pickupDate = [gregorian dateFromComponents:self.pickupComp];
    
    _dropoffComp = [[NSDateComponents alloc] init];
    [self.dropoffComp setDay:10];
    [self.dropoffComp  setMonth:7];
    [self.dropoffComp  setYear:2016];
    [self.dropoffComp  setHour:13];
    [self.dropoffComp  setMinute:30];
    [self.dropoffComp  setSecond:00];
    
    _dropoffDate = [gregorian dateFromComponents: self.dropoffComp];
    
    CartrawlerAPI *api = [[CartrawlerAPI alloc] initWithClientKey:@"621369" language:@"EN" debug:YES];
    
    [api requestVehicleAvailabilityForLocation:@"480"
                            returnLocationCode:@"480"
                           customerCountryCode:@"IE"
                                  passengerQty:@3
                                     driverAge:@30
                                pickUpDateTime:self.pickupDate
                                returnDateTime:self.dropoffDate
                                  currencyCode:@"USD"
                                    completion:^(CTVehicleAvailability *response, CTErrorResponse *error) {
                                        if (error == nil) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                [self.vehicleSelectionView initWithVehicleAvailability:response];
                                            });
                                            
                                        } else {
                                            NSLog(@"%@", error.errorMessage);
                                        }
                                    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
