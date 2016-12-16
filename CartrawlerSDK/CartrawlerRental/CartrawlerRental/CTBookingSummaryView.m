//
//  BookingSummaryViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTBookingSummaryView.h"
#import <CartrawlerAPI/CTVendor.h>
#import "CartrawlerSDK+NSDateUtils.h"
#import "CTButton.h"
#import "CTLabel.h"
#import "CTAppearance.h"
#import "CTPaymentSummaryDataSource.h"

@interface CTBookingSummaryView ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CTPaymentSummaryDataSource *dataSource;

@end

@implementation CTBookingSummaryView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.dataSource) {
        [self.dataSource setData:self.search];
    } else {
        _dataSource = [[CTPaymentSummaryDataSource alloc] init];
        [self.dataSource setData:self.search];
    }
    
    if (!self.dataSource) {
        _dataSource = [[CTPaymentSummaryDataSource alloc] init];
    }
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 130;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView layoutIfNeeded];
    if (self.heightChanged) {
        self.view.alpha = 0;
        [self.tableView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView layoutIfNeeded];
            self.heightChanged(self.tableView.contentSize.height);
            [UIView animateWithDuration:0.0 animations:^{
                [self.tableView layoutIfNeeded];
                [self.view layoutIfNeeded];
                self.view.alpha = 1;
                self.heightChanged(self.tableView.contentSize.height);
            }];
        });
        self.heightChanged(self.tableView.contentSize.height);
    }
}

- (void)enableScroll:(BOOL)enable
{
    self.tableView.scrollEnabled = enable;
}

@end
