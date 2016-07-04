//
//  VehicleDetailsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleDetailsViewController.h"
#import "VehicleDetailsView.h"
#import "ExpandingInfoView.h"

@interface VehicleDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIView *vehicleDetailsContainer;
@property (weak, nonatomic) IBOutlet UIView *vendorRatingContainer;
@property (weak, nonatomic) IBOutlet ExpandingInfoView *pickupLocationView;

@end

@implementation VehicleDetailsViewController

+ (void)forceLinkerLoad_ {}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.vendorRatingContainer.layer.cornerRadius = 5;
    self.vendorRatingContainer.layer.masksToBounds = YES;
    self.vehicleDetailsContainer.layer.cornerRadius = 5;
    self.vehicleDetailsContainer.layer.masksToBounds = YES;
    
    [self.pickupLocationView setTitle:@"" andImage:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"VehicleEmbed"]) {
        VehicleDetailsView *vc = (VehicleDetailsView *)[segue destinationViewController];
        [vc setData:self.selectedVehicle
                api:self.cartrawlerAPI
         pickupDate:self.pickupDate
         returnDate:self.dropoffDate
         pickupCode:self.pickupLocation.code
         returnCode:self.dropoffLocation.code
        homeCountry:@"IE"];
    }
}

- (IBAction)changeView:(id)sender {
    UISegmentedControl *sc = (UISegmentedControl *)sender;
    
    switch (sc.selectedSegmentIndex) {
        case 0:
            self.vehicleDetailsContainer.alpha = 1;
            break;
        case 1:
            self.vehicleDetailsContainer.alpha = 0;
            break;
        default:
            break;
    }
}


@end
