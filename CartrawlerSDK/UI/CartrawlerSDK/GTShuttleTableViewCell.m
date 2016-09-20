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

@interface GTShuttleTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegate>

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
    self.shuttleInfo.text = [self shuttleServiceLevel:shuttle.serviceLevel];
    
    self.baggageLabel.text = [NSString stringWithFormat:@"%@", shuttle.maxBaggage];
    self.passengersLabel.text = [NSString stringWithFormat:@"%@", shuttle.maxPassengers];
    self.priceLabel.text = [NSNumberUtils numberStringWithCurrencyCode:shuttle.totalCharge];
    
    [self.inclusionsCollectionView reloadData];
    [self.inclusionsCollectionView layoutIfNeeded];
    [self.inclusionsCollectionView.collectionViewLayout invalidateLayout];
    [self.inclusionsCollectionView layoutIfNeeded];
    [self.inclusionsCollectionView setNeedsDisplay];
    
    //self.uiCollectionView.collectionViewLayout.collectionViewCon‌​tentSize().height
    
    NSLog(@"HEIGHT: %f", self.inclusionsCollectionView.collectionViewLayout.collectionViewContentSize.height);
    
    self.inclusionHeightConstraint.constant = self.inclusionsCollectionView.contentSize.height;
    
    for (InclusionCollectionViewCell *cell in self.inclusionsCollectionView.visibleCells) {
        NSLog(@"CELL Width: %f", cell.frame.size.width);
        
        //add width of cells until reaches collectionview width, then increment line count, reset for next line
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
    [cell setText:[self inclusionText:self.inclusions[indexPath.row].inclusion]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CGSize textSize = [[self inclusionText:self.inclusions[indexPath.row].inclusion]
                       sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:[CTAppearance instance].boldFontName size:17]}];
    
    CGFloat width = (textSize.width) + 50 < collectionView.frame.size.width ? (textSize.width + 50) : (collectionView.frame.size.width - 50);
    
    return CGSizeMake(width, 40);
}

- (NSString *)inclusionText:(Inclusion)inclusion
{
    
    switch (inclusion) {
        case InclusionAirCon: {
            return NSLocalizedString(@"Air Con", @"Air Con");
            
        }
        case InclusionBathroom: {
            return NSLocalizedString(@"Bathroom", @"Bathroom");
            
        }
        case InclusionBike: {
            return NSLocalizedString(@"Bike", @"Bike");
            
        }
        case InclusionChildSeats: {
            return NSLocalizedString(@"Child Seats", @"");
            
        }
        case InclusionDriverLanguages: {
            return NSLocalizedString(@"Driver Languages", @"");
            
        }
        case InclusionExtraPrivacyLegroom: {
            return NSLocalizedString(@"Extra Privacy & Legroom", @"");
            
        }
        case InclusionMagazines: {
            return NSLocalizedString(@"Magazines", @"");
            
        }
        case InclusionMakeModel: {
            return NSLocalizedString(@"Make model", @""); // ??
            
        }
        case InclusionNewspaper: {
            return NSLocalizedString(@"Newspaper", @"");
            
        }
        case InclusionOversizeLuggage: {
            return NSLocalizedString(@"Oversize Luggage", @"");
            
        }
        case InclusionPhoneCharger: {
            return NSLocalizedString(@"Phone Charger", @"");
            
        }
        case InclusionPowerSocket: {
            return NSLocalizedString(@"Power Socket", @"");
            
        }
        case InclusionSMS: {
            return NSLocalizedString(@"SMS", @"");
            
        }
        case InclusionSnacks: {
            return NSLocalizedString(@"Snacks", @"");
            
        }
        case InclusionTablet: {
            return NSLocalizedString(@"Tablet", @"");
            
        }
        case InclusionWaitMinutes: {
            return NSLocalizedString(@"Wait Minutes", @""); //??
            
        }
        case InclusionWheelchairAccess: {
            return NSLocalizedString(@"Wheelchair Access", @"");
            
        }
        case InclusionWifi: {
            return NSLocalizedString(@"Wifi", @"");
            
        }
        case InclusionWorkTable: {
            return NSLocalizedString(@"Work Table", @"");
            
        }
        case InclusionVideo: {
            return NSLocalizedString(@"Video", @"");
            
        }
        case InclusionWater: {
            return NSLocalizedString(@"Water", @"");
            
        }
    }
    
    return @"";
}



@end
