//
//  PaymentSummaryViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 11/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentSummaryViewController.h"
#import "PaymentSummaryTableViewCell.h"
#import "CTDesignableView.h"
#import "CTSDKSettings.h"
#import "CartrawlerSDK+NSNumber.h"
#import "BookingSummaryButton.h"
#import "CTLabel.h"
#import "CTNextButton.h"
#import "BookingSummaryViewController.h"
#import "CartrawlerSDK+UIView.h"

@interface PaymentSummaryViewController () <UITableViewDelegate, UITableViewDataSource, BookingSummaryButtonDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (strong, nonatomic) NSMutableArray *items;

@property (weak, nonatomic) IBOutlet BookingSummaryButton *bookingSummaryContainer;
@property (weak, nonatomic) IBOutlet CTLabel *totalLabel;
@property (weak, nonatomic) IBOutlet CTNextButton *nextButton;

@end

@implementation PaymentSummaryViewController
{
    BOOL summaryVisible;
    double total;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bookingSummaryContainer.delegate = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.dataSource = self;
    
    __weak typeof(self) weakSelf = self;
    [self.nextButton setText:NSLocalizedString(@"Continue", @"Continue") didTap:^{
        [weakSelf pushToDestination];
    }];
}

- (void)openSummaryTapped
{
    [self performSegueWithIdentifier:@"bookingSummary" sender:nil];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    total = 0;
    _items = [[NSMutableArray alloc] init];

    [self.items addObject:@{@"Normal" : @{@"Name" : @"Car hire", @"Price" : self.search.selectedVehicle.vehicle.totalPriceForThisVehicle}}];

    if (self.search.isBuyingInsurance) {
        [self.items addObject:@{@"Normal" : @{@"Name" : @"Damage Refund Insurance", @"Price" : self.search.insurance.premiumAmount}}];
        total += self.search.insurance.premiumAmount.doubleValue;
    }
    
    for (CTExtraEquipment *extra in self.search.selectedVehicle.vehicle.extraEquipment) {
        if (extra.qty > 0) {
            [self.items addObject:@{@"Extra" : @{@"Name" : extra.equipDescription, @"Price" : @"Pay at desk"}}];
        }
    }
    
    total += self.search.selectedVehicle.vehicle.totalPriceForThisVehicle.doubleValue;
    
    self.totalLabel.text = [@(total) numberStringWithCurrencyCode];

    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];

    self.tableView.alpha = 1;
    self.tableView.heightConstraint.constant = self.tableView.contentSize.height;
}

#pragma mark TABLE VIEW

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaymentSummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *data = self.items[indexPath.row];
    
    if (data[@"Extra"]) {
        [cell setDetailsItalic:data[@"Extra"][@"Name"]];
        } else {
        [cell setDetails:data[@"Normal"][@"Name"] price:data[@"Normal"][@"Price"]];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"bookingSummary"]) {
        BookingSummaryViewController *vc = segue.destinationViewController;
        [vc setData:self.search];
    }
}

@end
