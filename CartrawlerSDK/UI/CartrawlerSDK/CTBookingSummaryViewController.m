//
//  CTBookingSummaryViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 21/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTBookingSummaryViewController.h"
#import "CTBookingSummaryView.h"

@interface CTBookingSummaryViewController ()

@end

@implementation CTBookingSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CTBookingSummaryView *summaryView = segue.destinationViewController;
    summaryView.search = self.search;
}

@end
