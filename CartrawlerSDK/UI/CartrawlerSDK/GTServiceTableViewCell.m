//
//  GTServiceTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 14/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTServiceTableViewCell.h"
#import "CTLabel.h"
#import "CTImageCache.h"
#import "NSNumberUtils.h"
#import "CTAppearance.h"
#import "InclusionCollectionViewCell.h"
#import "LocalisedStrings.h"

@interface GTServiceTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (weak, nonatomic) IBOutlet CTLabel *carTypeLabel;
@property (weak, nonatomic) IBOutlet CTLabel *baggageLabel;
@property (weak, nonatomic) IBOutlet CTLabel *passengersLabel;
@property (weak, nonatomic) IBOutlet CTLabel *greetingLabel;
@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;
@property (weak, nonatomic) IBOutlet CTLabel *companyLabel;
@property (nonatomic, strong) NSArray <CTGroundInclusion *> *inclusions;
@property (weak, nonatomic) IBOutlet UICollectionView *inclusionsCollectionView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *inclusionHeightConstraint;

@end

@implementation GTServiceTableViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.inclusionsCollectionView.dataSource = self;
    self.inclusionsCollectionView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setService:(CTGroundService *)service
{
    __weak typeof (self) weakSelf = self;
    [[CTImageCache sharedInstance] cachedImage: service.vehicleImage completion:^(UIImage *image) {
        weakSelf.vehicleImageView.image = image;
    }];
    
    _inclusions = service.inclusions;

    self.carTypeLabel.text = [LocalisedStrings serviceLevel:service.serviceLevel];
    self.companyLabel.text = service.companyName;
    self.baggageLabel.text = [NSString stringWithFormat:@"%@ bags", service.maxBaggage];
    self.passengersLabel.text = [NSString stringWithFormat:@"%@ passengers", service.maxPassengers];
    
    if (service.meetAndGreet) {
        NSAttributedString *pickupType = [[NSAttributedString alloc] initWithString:@"Meet and Greet: "
                                                                         attributes:@{NSFontAttributeName:
                                                                                          [UIFont fontWithName:@"Avenir-HeavyOblique" size:14]}];
        
        NSAttributedString *pickupInfo = [[NSAttributedString alloc] initWithString:@"Your driver will be waiting for you in the arrivals area"
                                                                         attributes:@{NSFontAttributeName:
                                                                                          [UIFont fontWithName:@"Avenir-Oblique" size:14]}];
        
        
        NSMutableAttributedString *pickupStr = [[NSMutableAttributedString alloc] init];
        
        [pickupStr appendAttributedString:pickupType];
        [pickupStr appendAttributedString:pickupInfo];
        self.greetingLabel.attributedText = pickupStr;
    } else {
        NSAttributedString *pickupType = [[NSAttributedString alloc] initWithString:@"Curbside: "
                                                                         attributes:@{NSFontAttributeName:
                                                                                          [UIFont fontWithName:@"Avenir-HeavyOblique" size:14]}];
        
        NSAttributedString *pickupInfo = [[NSAttributedString alloc] initWithString:@"Call driver on courtesy telephone to arrange pick-up point"
                                                                         attributes:@{NSFontAttributeName:
                                                                                          [UIFont fontWithName:@"Avenir-Oblique" size:14]}];
        
        
        NSMutableAttributedString *pickupStr = [[NSMutableAttributedString alloc] init];
        
        [pickupStr appendAttributedString:pickupType];
        [pickupStr appendAttributedString:pickupInfo];
        self.greetingLabel.attributedText = pickupStr;
    }
    
    self.priceLabel.text = [NSNumberUtils numberStringWithCurrencyCode:service.totalCharge];
    
    [self.inclusionsCollectionView reloadData];
    [self.contentView updateConstraints];
    [self.contentView layoutIfNeeded];
    self.inclusionHeightConstraint.constant = [self calculateCellHeight];
}

- (CGFloat)calculateCellHeight
{
    if (self.inclusions.count == 0) {
        return 0;
    } else {
    
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
