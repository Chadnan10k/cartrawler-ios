//
//  InclusionCollectionViewDataSource.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 02/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "InclusionCollectionViewDataSource.h"
#import "InclusionCollectionViewCell.h"
#import <CartrawlerAPI/CTGroundInclusion.h>
#import <CartrawlerSDK/CTAppearance.h>

@interface InclusionCollectionViewDataSource()

@property (nonatomic, strong) NSArray <CTGroundInclusion *> *inclusions;

@end

@implementation InclusionCollectionViewDataSource

- (void)setInclusions:(NSArray <CTGroundInclusion *> *)inclusions;
{
    _inclusions = inclusions;
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
    InclusionCollectionViewCell *cell = (InclusionCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                                                       forIndexPath:indexPath];
    [cell setText:[self inclusionText:self.inclusions[indexPath.row].inclusion]];
    
    [cell layoutIfNeeded];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize textSize = [[self inclusionText:self.inclusions[indexPath.row].inclusion]
                       sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:[CTAppearance instance].boldFontName size:17]}];
    return CGSizeMake(textSize.width + 50, 40);
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
