//
//  ViewController.m
//  TestApp
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ViewController.h"
#import "RYRRentalManager.h"
#import "InPathViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *endpointControl;

@property (nonatomic) BOOL isDebug;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad]; //643826 ryr desktop 642619 ryr mobile
    _isDebug = YES;
}

- (IBAction)openCarRental:(id)sender {
    [[RYRRentalManager instance].rental presentCarRentalInViewController:self];
}

- (IBAction)endpointChanged:(id)sender {
    if (self.endpointControl.selectedSegmentIndex == 0) {
        _isDebug = YES;
    } else {
        _isDebug = NO;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    InPathViewController *vc = segue.destinationViewController;
}


@end
