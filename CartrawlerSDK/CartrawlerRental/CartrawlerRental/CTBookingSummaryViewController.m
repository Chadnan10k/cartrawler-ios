//
//  CTBookingSummaryViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 21/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTBookingSummaryViewController.h"
#import "CTBookingSummaryView.h"
#import "CTNextButton.h"
@interface CTBookingSummaryViewController ()

@property (weak, nonatomic) IBOutlet CTNextButton *continueButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerBottomSpace;

@end

@implementation CTBookingSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    [self.continueButton setText:@"Continue" didTap:^{
        if (!weakSelf.destinationViewController) {
            [weakSelf dismiss];
        } else {
            [weakSelf pushToDestination];
        }
    }];
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
