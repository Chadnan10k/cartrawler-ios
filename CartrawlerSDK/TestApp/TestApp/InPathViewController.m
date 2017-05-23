//
//  InPathViewController.m
//  TestApp
//
//  Created by Lee Maguire on 19/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "InPathViewController.h"
#import "RYRRentalManager.h"

@interface InPathViewController ()

@property (weak, nonatomic) IBOutlet UIView *cardContainer;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;
@property (weak, nonatomic) IBOutlet UISwitch *oneWaySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *endpointSwitch;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation InPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [RYRRentalManager instance].parent = self;
    [RYRRentalManager instance].priceLabel = self.priceLabel;

    [[RYRRentalManager instance] setupInPath:self.cardContainer parentVC:self];
    [RYRRentalManager instance].callToAction = self.bookButton;
    self.endpointSwitch.on = [RYRRentalManager instance].currentEndpoint;
    
}

- (IBAction)bookCar:(id)sender {
    [[RYRRentalManager instance] inPathOpenEngine:self];
}

- (IBAction)mockPayment:(id)sender {
    [[RYRRentalManager instance].inPath presentAllCars:self];

}

- (IBAction)remove:(id)sender {
    [[RYRRentalManager instance] removeVehicle];
}

- (IBAction)loadCard:(id)sender {

   // [self.inPath addCrossSellCardToView:self.cardContainer];
}

- (IBAction)changeEndpoint:(id)sender {
    UISwitch *s = sender;
    [[RYRRentalManager instance] changeEndpointInPath:s.isOn];

}

- (IBAction)oneWayChanged:(id)sender {
    UISwitch *s = (UISwitch *)sender;
    [[RYRRentalManager instance] changeRoundTrip:s.isOn];
}

- (IBAction)refresh:(id)sender {
    [[RYRRentalManager instance] reset];

}

@end
