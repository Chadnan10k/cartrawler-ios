//
//  BookingSummaryViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "BookingSummaryViewController.h"
#import <CartrawlerAPI/CTVendor.h>
#import "CartrawlerSDK+NSDateUtils.h"
#import "CTButton.h"
#import "CTLabel.h"
#import "CTAppearance.h"
#import "CTPaymentSummaryDataSource.h"

@interface BookingSummaryViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CTPaymentSummaryDataSource *dataSource;

@end

@implementation BookingSummaryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.dataSource) {
        _dataSource = [[CTPaymentSummaryDataSource alloc] init];
    }
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
}

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)setData:(CarRentalSearch *)search
{
    if (self.dataSource) {
        [self.dataSource setData:search];
    } else {
        _dataSource = [[CTPaymentSummaryDataSource alloc] init];
        [self.dataSource setData:search];
    }
}

@end
