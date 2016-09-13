//
//  GTShuttleTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 08/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTShuttleTableViewCell.h"
#import "CTImageCache.h"
#import "CTLabel.h"
#import "NSNumberUtils.h"
#import "InclusionsTableViewCell.h"

@interface GTShuttleTableViewCell() <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (weak, nonatomic) IBOutlet CTLabel *shuttleName;
@property (weak, nonatomic) IBOutlet CTLabel *shuttleInfo;
@property (weak, nonatomic) IBOutlet CTLabel *baggageLabel;
@property (weak, nonatomic) IBOutlet CTLabel *passengersLabel;
@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;
@property (nonatomic, strong) NSArray <CTGroundInclusion *> *inclusions;

@end

@implementation GTShuttleTableViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    for (NSLayoutConstraint *constraint in self.inclusionsCollectionView.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            _inclusionHeightConstraint = constraint;
            break;
        }
    }
    
    self.inclusionsTableView.dataSource = self;
    self.inclusionsTableView.rowHeight = UITableViewAutomaticDimension;
    self.inclusionsTableView.estimatedRowHeight = 32;
}

- (void)setShuttle:(CTGroundShuttle *)shuttle
{
    [[CTImageCache sharedInstance] cachedImage: shuttle.vehicleImage completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    _inclusions = shuttle.inclusions;
    
    self.shuttleName.text = shuttle.companyName;
    self.shuttleInfo.text = [self shuttleServiceLevel:shuttle.serviceLevel];
    
    self.baggageLabel.text = [NSString stringWithFormat:@"%@", shuttle.maxBaggage];
    self.passengersLabel.text = [NSString stringWithFormat:@"%@", shuttle.maxPassengers];
    self.priceLabel.text = [NSNumberUtils numberStringWithCurrencyCode:shuttle.totalCharge];
    
    [self.inclusionsTableView reloadData];
    [self.inclusionsTableView setNeedsLayout];
    [self.inclusionsTableView layoutIfNeeded];
    [self.inclusionsTableView reloadData];
    self.tableViewHeight.constant = self.inclusionsTableView.contentSize.height;
    [self.inclusionsTableView updateConstraintsIfNeeded];
    
}

- (NSString *)shuttleType:(ShuttleType)type
{
    switch (type) {
        case ShuttleTypeTrain:
            return @"Train";
        default:
            return @"Unknown";
    }
}

- (NSString *)shuttleServiceLevel:(ServiceLevel)type
{
    switch (type) {
        case ServiceLevelNone:
            return @"Unknown";
        case ServiceLevelEconomy:
            return @"Economy";
        case ServiceLevelStandard:
            return @"Standard";
        case ServiceLevelBusiness:
            return @"Business";
        case ServiceLevelLuxury:
            return @"Luxury";
        case ServiceLevelPremium:
            return @"Premium";
        case ServiceLevelStandardClass:
            return @"Standard Class";
        case ServiceLevelFirstClass:
            return @"First Class";
        default:
            return @"Unknown";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.inclusions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InclusionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setText:self.inclusions[indexPath.row].inclusion];
    return cell;
}


@end
