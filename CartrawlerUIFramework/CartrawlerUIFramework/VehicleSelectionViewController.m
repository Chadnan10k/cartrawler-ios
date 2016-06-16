//
//  ViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleSelectionViewController.h"
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface VehicleSelectionViewController ()

@property (weak, nonatomic) IBOutlet CTVehicleSelectionView *vehicleSelectionView;

@end

@implementation VehicleSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.vehicleSelectionView initWithVehicleAvailability:self.vehicleAvailability];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
