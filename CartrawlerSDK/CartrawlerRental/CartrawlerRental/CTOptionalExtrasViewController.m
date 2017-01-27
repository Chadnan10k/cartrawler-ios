//
//  CTOptionalCTExtrasViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 17/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTOptionalExtrasViewController.h"
#import "CTOptionalExtraTableViewCell.h"
#import <CartrawlerSDK/CTNextButton.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTOptionalExtrasViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet CTNextButton *nextButton;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<CTExtraEquipment *> *extras;
@property (weak, nonatomic) IBOutlet CTLabel *conditionsLabel;
@end

@implementation CTOptionalExtrasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nextButton setText:CTLocalizedString(CTRentalCTAContinue)];
    // Do any additional setup after loading the view.
    self.tableView.allowsSelection = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 75;
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    [self.tableView registerNib:[UINib nibWithNibName:@"CTOptionalExtraTableViewCell" bundle:bundle] forCellReuseIdentifier:@"cell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.conditionsLabel.text = CTLocalizedString(CTRentalExtrasConditions);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CTAnalytics instance] tagScreen:@"Step" detail:@"vehicles-e" step:@4];

    if ([CTRentalSearch instance].insurance) {
        self.bottomSpace.constant = 0;
    } else {
        self.bottomSpace.constant = 90;
    }
    
    _extras = [CTRentalSearch instance].selectedVehicle.vehicle.extraEquipment;
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
}

- (IBAction)next:(id)sender {
    [self pushToDestination];
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
    CTOptionalExtraTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setData:self.extras[indexPath.row]];
    return cell;
}

@end
