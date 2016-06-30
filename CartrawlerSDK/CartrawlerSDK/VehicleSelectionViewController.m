//
//  ViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleSelectionViewController.h"
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "CTLabel.h"
#import "DateUtils.h"

@interface VehicleSelectionViewController ()

@property (weak, nonatomic) IBOutlet CTVehicleSelectionView *vehicleSelectionView;
@property (weak, nonatomic) IBOutlet UILabel *locationsLabel;
@property (weak, nonatomic) IBOutlet CTLabel *datesLabel;
@property (weak, nonatomic) IBOutlet CTLabel *carCountLabel;

@end

@implementation VehicleSelectionViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationsLabel.text = [NSString stringWithFormat:@"%@ - %@", self.pickupLocation.name, self.dropoffLocation.name];
    
    NSString *pickupDate = [DateUtils shortDescriptionFromDate:self.pickupDate];
    NSString *dropoffDate = [DateUtils shortDescriptionFromDate:self.dropoffDate];

    self.datesLabel.text = [NSString stringWithFormat:@"%@ - %@", pickupDate, dropoffDate];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self.vehicleSelectionView initWithVehicleAvailability:self.vehicleAvailability];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
