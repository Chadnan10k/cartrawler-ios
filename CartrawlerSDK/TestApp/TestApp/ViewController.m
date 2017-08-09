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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.endpointControl.selectedSegmentIndex = [RYRRentalManager instance].currentEndpoint;
	
	[CTSDKSettings instance].customAttributes = [[NSMutableDictionary alloc] init];
	[[CTSDKSettings instance].customAttributes setObject:@"er89952d1334" forKey:@"myAppId"];
	[[CTSDKSettings instance].customAttributes setObject:@"T26RJX" forKey:@"orderId"];
	[[CTSDKSettings instance].customAttributes setObject:@"89952133413890617305233409049160176604" forKey:@"visitorId"];
}

- (IBAction)openCarRental:(id)sender {
    [[RYRRentalManager instance].rental presentCarRentalInViewController:self withClientID:@"642619"];
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
