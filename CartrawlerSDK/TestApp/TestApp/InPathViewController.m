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

@end

@implementation InPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[RYRRentalManager instance] setupInPath:self.cardContainer];
}

- (IBAction)bookCar:(id)sender {
    [[RYRRentalManager instance] inPathOpenEngine:self];
}

- (IBAction)mockPayment:(id)sender {
    [[RYRRentalManager instance] mockPayment];

}

- (IBAction)remove:(id)sender {
    [[RYRRentalManager instance] removeVehicle];
}

- (IBAction)loadCard:(id)sender {

   // [self.inPath addCrossSellCardToView:self.cardContainer];
}

- (IBAction)oneWayChanged:(id)sender {
    UISwitch *s = (UISwitch *)sender;
    [[RYRRentalManager instance] changeRoundTrip:s.isOn];
}


@end
