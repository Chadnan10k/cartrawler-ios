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
    self.tableView.estimatedRowHeight = 100;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    if (self.heightChanged) {
        self.heightChanged(self.tableView.contentSize.height);
    }
}

- (void)enableScroll:(BOOL)enable
{
    self.tableView.scrollEnabled = enable;
}

@end