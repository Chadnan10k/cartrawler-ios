//
//  VehicleFeaturesDataSource.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 25/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleInclusionsDataSource.h"
#import "CTInclusionCollectionViewCell.h"
#import <CartrawlerSDK/CTAppearance.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTVehicleInclusionsDataSource()

@property (nonatomic, strong) NSArray <CTPricedCoverage *> *coverages;
@property (nonatomic, strong) NSArray <CTExtraEquipment *> *extras;

@end

@implementation CTVehicleInclusionsDataSource
- (void)setData:(NSArray <CTPricedCoverage *> *)coverages extras:(NSArray <CTPricedCoverage *> *)extras;
{
    _coverages = coverages;
    
    NSMutableArray *tempExtras = [NSMutableArray new];
    for(CTExtraEquipment *extra in extras) {
        if (extra.isIncludedInRate) {
            [tempExtras addObject:extra];
        }
    }
    
    _extras = tempExtras;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.coverages.count;
    } else {
        return self.extras.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CTInclusionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                                        forIndexPath:indexPath];
        [cell setData:self.coverages[indexPath.row].chargeDescription];
        return cell;
    } else {
        CTInclusionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                                        forIndexPath:indexPath];
        [cell setData:self.extras[indexPath.row].equipDescription];
        return cell;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8,0,0,0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize textSize;
    
    if (indexPath.section == 0) {
        textSize = [self.coverages[indexPath.row].chargeDescription
                    sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:[CTAppearance instance].fontName size:14]}];
    } else {
        textSize = [self.extras[indexPath.row].equipDescription
                    sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:[CTAppearance instance].fontName size:14]}];
    }
    
    CGFloat width = (collectionView.frame.size.width/2)-16;
    CGFloat height = 0;
    
    if (textSize.width < width) {
        height = 20;
    } else {
        height = 18 * ceil(textSize.width / width);
    }

    return CGSizeMake(width, height);
}

- (NSString *)tooltipTextForPricedCoverage:(CTPricedCoverage *)coverage
{
    if ([coverage.coverageType isEqualToString:@"6"]) {//CDW
        return @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";
    }
    
    if ([coverage.coverageType isEqualToString:@"47"]) {//TW
        return @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";
    }
    
    if ([coverage.coverageType isEqualToString:@"50"]) {//TP
        return @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";
    }
    
    return CTLocalizedString(CTRentalVehicleVehicleInclusion);
}

@end
