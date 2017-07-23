//
//  ViewController.m
//  TestApp
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ViewController.h"
#import "StandaloneViewController.h"
#import <CartrawlerSDK/CartrawlerSDK.h>


#import "RYRRentalManager.h"
#import "InPathViewController.h"

@interface ViewController ()
@property (nonatomic) CartrawlerSDK *sdk;
@property (weak, nonatomic) IBOutlet UISegmentedControl *endpointControl;

@property (nonatomic) BOOL isDebug;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad]; //643826 ryr desktop 642619 ryr mobile
    _isDebug = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.endpointControl.selectedSegmentIndex = [RYRRentalManager instance].currentEndpoint;
}

- (IBAction)openCarRental:(id)sender {
    self.sdk = [[CartrawlerSDK alloc] initWithlanguageCode:@"en" sandboxMode:YES];
    [self.sdk setNewSession];
    [self.sdk presentInParentViewController:self];
    
//    [[RYRRentalManager instance].rental presentCarRentalInViewController:self withClientID:@"642619"];
}

- (IBAction)endpointChanged:(id)sender {
    if (self.endpointControl.selectedSegmentIndex == 0) {
        _isDebug = YES;
    } else {
        _isDebug = NO;
    }
    [[RYRRentalManager instance] changeEndpoint:!self.isDebug];
}



@end
