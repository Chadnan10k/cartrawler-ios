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

@interface GTShuttleTableViewCell()

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
}

- (void)setShuttle:(CTGroundShuttle *)shuttle
{
    [[CTImageCache sharedInstance] cachedImage: shuttle.vehicleImage completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    self.shuttleName.text = shuttle.companyName;
    self.shuttleInfo.text = [self shuttleServiceLevel:shuttle.serviceLevel];
    
    self.baggageLabel.text = [NSString stringWithFormat:@"%@", shuttle.maxBaggage];
    self.passengersLabel.text = [NSString stringWithFormat:@"%@", shuttle.maxPassengers];
    self.priceLabel.text = [NSNumberUtils numberStringWithCurrencyCode:shuttle.totalCharge];
    
    if (shuttle.inclusions.count > 0) {
        
        self.inclusionsCollectionView.hidden = NO;
        
        self.inclusionsCollectionView.dataSource = self.inclusionDataSource;
        self.inclusionsCollectionView.delegate = self.inclusionDataSource;
        [self.inclusionsCollectionView reloadData];
        
        [self.inclusionsCollectionView layoutIfNeeded];
        [self layoutIfNeeded];
        
    } else {
        self.inclusionsCollectionView.hidden = YES;
    }
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

@end
