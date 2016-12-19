//
//  CTOptionalExtrasViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 17/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTOptionalExtrasViewController.h"
#import "OptionalExtraTableViewCell.h"
#import <CartrawlerSDK/CTNextButton.h>

@interface CTOptionalExtrasViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet CTNextButton *nextButton;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<CTExtraEquipment *> *extras;
@end

@implementation CTOptionalExtrasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    [self.nextButton setText:NSLocalizedString(@"Continue", @"") didTap:^{
        [weakSelf pushToDestination];
    }];
    // Do any additional setup after loading the view.
    self.tableView.allowsSelection = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 75;
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    [self.tableView registerNib:[UINib nibWithNibName:@"OptionalExtraTableViewCell" bundle:bundle] forCellReuseIdentifier:@"cell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([CTRentalSearch instance].insurance) {
        self.bottomSpace.constant = 0;
    } else {
        self.bottomSpace.constant = 90;
    }
    
    _extras = [CTRentalSearch instance].selectedVehicle.vehicle.extraEquipment;
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.extras.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionalExtraTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setData:self.extras[indexPath.row]];
    return cell;
}

@end
