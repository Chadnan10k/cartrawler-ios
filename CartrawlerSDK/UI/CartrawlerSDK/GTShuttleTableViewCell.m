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
#import "InclusionCollectionViewCell.h"
#import "CTAppearance.h"
#import "LocalisedStrings.h"

@interface GTShuttleTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (weak, nonatomic) IBOutlet CTLabel *shuttleName;
@property (weak, nonatomic) IBOutlet CTLabel *shuttleInfo;
@property (weak, nonatomic) IBOutlet CTLabel *baggageLabel;
@property (weak, nonatomic) IBOutlet CTLabel *passengersLabel;
@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;
@property (nonatomic, strong) NSArray <CTGroundInclusion *> *inclusions;
@property (weak, nonatomic) IBOutlet UICollectionView *inclusionsCollectionView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *inclusionHeightConstraint;

@end

@implementation GTShuttleTableViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
     self.inclusionsCollectionView.dataSource = self;
     self.inclusionsCollectionView.delegate = self;
}

- (void)setShuttle:(CTGroundShuttle *)shuttle
{
    __weak typeof (self) weakSelf = self;
    [[CTImageCache sharedInstance] cachedImage: shuttle.vehicleImage completion:^(UIImage *image) {
        weakSelf.vehicleImageView.image = image;
    }];
    
    _inclusions = shuttle.inclusions;
    
    self.shuttleName.text = shuttle.companyName;
    self.shuttleInfo.text = [LocalisedStrings serviceLevel:shuttle.serviceLevel];
    
    self.baggageLabel.text = [NSString stringWithFormat:@"%@ bags", shuttle.maxBaggage];
    self.passengersLabel.text = [NSString stringWithFormat:@"%@ passengers", shuttle.maxPassengers];
    self.priceLabel.text = [NSNumberUtils numberStringWithCurrencyCode:shuttle.totalCharge];
    
    [self.inclusionsCollectionView reloadData];
    [self.contentView updateConstraints];
    [self.contentView layoutIfNeeded];
    self.inclusionHeightConstraint.constant = [self calculateCellHeight];
    
}

- (CGFloat)calculateCellHeight
{
    CGFloat widthConstraint = self.inclusionsCollectionView.frame.size.width;
    CGFloat height = 30;
    CGFloat currentRow = 0.0;
    
    for (CTGroundInclusion *inclusion in self.inclusions) {
        CGSize textSize = [[LocalisedStrings inclusionText:inclusion.inclusion]
                           sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:[CTAppearance instance].boldFontName size:17]}];
        
        CGFloat width = (textSize.width) + 50 < self.inclusionsCollectionView.frame.size.width ?
        (textSize.width + 50) : (self.inclusionsCollectionView.frame.size.width - 50);
        
        if ((currentRow + width) >= widthConstraint) {
            height += 30;
        } else {
            currentRow += width;
        }
    }
    return height;
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.inclusions.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    InclusionCollectionViewCell *cell = (InclusionCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setText:[LocalisedStrings inclusionText:self.inclusions[indexPath.row].inclusion]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CGSize textSize = [[LocalisedStrings inclusionText:self.inclusions[indexPath.row].inclusion]
                       sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:[CTAppearance instance].boldFontName size:17]}];
    
    CGFloat width = (textSize.width) + 30 < collectionView.frame.size.width ? (textSize.width + 30) : (collectionView.frame.size.width - 30);
    
    return CGSizeMake(width, 30);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
