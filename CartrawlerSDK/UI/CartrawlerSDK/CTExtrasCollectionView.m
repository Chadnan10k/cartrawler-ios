//
//  CTExtrasCollectionViewController.m
//  CartrawlerSDK
//
//  Created by Alan on 10/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTExtrasCollectionView.h"
#import "CTExtrasCarouselViewCell.h"
#import "CTExtrasListCollectionViewCell.h"
#import <CartrawlerAPI/CTExtraEquipment.h>
#import <CartrawlerSDK/CTLayoutManager.h>
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTAnalytics.h>

NSInteger const kMaxExtras = 4;
NSInteger const kDefaultExtrasCountWhenIncludedInRate = 1;

CGFloat const kCarouselInteritemSpacing = 10.0;
CGFloat const kCarouselVerticalSectionInsets = 0;
CGFloat const kCarouselHorizontalSectionInsets = 15.0;
CGFloat const kCarouselCellWidth = 170.0;
CGFloat const kCarouselCellHeight = 170.0;

CGFloat const kListCellHeight = 80.0;
CGFloat const kListCellHeightExpanded = 160.0;

@interface CTExtrasCollectionView () <CTExtrasCollectionViewCellDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic, strong) NSArray *extras;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableIndexSet *indexesOfCellsWithDetailDisplayed;
@property (nonatomic, assign) BOOL scrollViewDidBeginDragging;
@end

@implementation CTExtrasCollectionView

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    self = [super init];
    if (self) {
        self.scrollDirection = scrollDirection;
        self.collectionView =  [self collectionViewForScrollDirection:scrollDirection];
        [self addSubview:self.collectionView];
        [CTLayoutManager pinView:self.collectionView toSuperView:self];
        
        self.indexesOfCellsWithDetailDisplayed = [NSMutableIndexSet new];
    }
    return self;
}

// MARK: Collection View

- (UICollectionView *)collectionViewForScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    UICollectionView *collectionView = scrollDirection == UICollectionViewScrollDirectionHorizontal ? [self horizontalCollectionView] : [self verticalCollectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    return collectionView;
}

- (UICollectionView *)horizontalCollectionView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = kCarouselInteritemSpacing;
    layout.sectionInset = UIEdgeInsetsMake(kCarouselVerticalSectionInsets, kCarouselHorizontalSectionInsets, kCarouselVerticalSectionInsets, kCarouselHorizontalSectionInsets);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView registerClass:[CTExtrasCarouselViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    
    return collectionView;
}

- (UICollectionView *)verticalCollectionView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView registerClass:[CTExtrasListCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    collectionView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:241.0/255.0 alpha:1.0];
    
    return collectionView;
}

- (void)updateWithExtras:(NSArray *)extras {
    self.extras = extras;
    [self.collectionView reloadData];
    self.scrollViewDidBeginDragging = NO;
}

// MARK: <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.extras.count;
}

- (UICollectionViewCell <CTExtrasCollectionViewCellProtocol> *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell <CTExtrasCollectionViewCellProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    CTExtraEquipment *extra = self.extras[indexPath.row];
    cell.title = extra.equipDescription;
    if (extra.isIncludedInRate) {
        cell.chargeAmount = @"Included for free";
    } else {
        NSString *charge = [extra.chargeAmount numberStringWithCurrencyCode];
        cell.chargeAmount = [NSString stringWithFormat:@"%@ %@", charge, CTLocalizedString(CTRentalExtrasPerRental)];
    }
    cell.chargeAmountHighlighted = extra.isIncludedInRate;
    
    cell.detail = [self detailForExtra:extra];
    
    BOOL decrementEnabled = (!extra.isIncludedInRate && extra.qty != 0);
    [cell setDecrementEnabled:decrementEnabled];
    
    BOOL incrementEnabled = (!extra.isIncludedInRate && extra.qty != kMaxExtras);
    [cell setIncrementEnabled:incrementEnabled];
    
    BOOL detailDisplayed = [self.indexesOfCellsWithDetailDisplayed containsIndex:indexPath.row];
    [cell setDetailDisplayed:detailDisplayed animated:NO];
    
    NSInteger count = extra.isIncludedInRate ? kDefaultExtrasCountWhenIncludedInRate : extra.qty;
    [cell setCount:count];
    
    if ([cell respondsToSelector:@selector(setImage:)]) {
        NSString *imageName = [self imageNameForExtra:extra];
        UIImage *image = [[UIImage imageNamed:imageName inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [cell setImage:image];
    }
    
    return cell;
}

- (NSString *)imageNameForExtra:(CTExtraEquipment *)extra {
    switch (extra.equipmentType) {
        case CTExtraEquipmentTypeAdditionalDriver:
            return @"additional-driver";
        case CTExtraEquipmentTypeBoosterSeat:
            return @"booster-seat";
        case CTExtraEquipmentTypeBreathalyser:
            return @"breathalyzer";
        case CTExtraEquipmentTypeNavigationSystem:
        case CTExtraEquipmentTypeNavigationalPhone:
        case CTExtraEquipmentTypeGPS:
            return @"gps";
        case CTExtraEquipmentTypeInfantSeat:
            return @"infant-seat";
        case CTExtraEquipmentTypeLuggageRack:
            return @"luggage-rack";
        case CTExtraEquipmentTypeMobilePhone:
            return @"mobile-phone";
        case CTExtraEquipmentTypeSkiRack:
            return @"ski-rack";
        case CTExtraEquipmentTypeSnowChains:
            return @"snow-chains";
        case CTExtraEquipmentTypeSnowTires:
            return @"snow-tires";
        case CTExtraEquipmentTypeToddlerSeat:
            return @"toddler-seat";
        case CTExtraEquipmentTypeTollTag:
            return @"toll-tag";
        case CTExtraEquipmentTypeWifi:
            return @"wifi";
        case CTExtraEquipmentTypeWinterPackage:
            return @"winterpackage";
        default:
            return @"booster-seat";
            break;
    }
}

- (NSString *)detailForExtra:(CTExtraEquipment *)extra {
    switch (extra.equipmentType) {
        case CTExtraEquipmentTypeAdditionalDriver:
            return CTLocalizedString(CTRentalDetailAdditionalDriver);
        case CTExtraEquipmentTypeBoosterSeat:
            return CTLocalizedString(CTRentalDetailBoosterSeat);
        case CTExtraEquipmentTypeBreathalyser:
            return CTLocalizedString(CTRentalDetailBreathalyser);
        case CTExtraEquipmentTypeNavigationSystem:
            return CTLocalizedString(CTRentalDetailNavigationSystem);
        case CTExtraEquipmentTypeNavigationalPhone:
            return CTLocalizedString(CTRentalDetailNavigationalPhone);
        case CTExtraEquipmentTypeGPS:
            return CTLocalizedString(CTRentalDetailGPS);
        case CTExtraEquipmentTypeInfantSeat:
            return CTLocalizedString(CTRentalDetailInfantSeat);
        case CTExtraEquipmentTypeLuggageRack:
            return CTLocalizedString(CTRentalDetailLuggageRack);
        case CTExtraEquipmentTypeMobilePhone:
            return CTLocalizedString(CTRentalDetailMobilePhone);
        case CTExtraEquipmentTypeSkiRack:
            return CTLocalizedString(CTRentalDetailSkiRack);
        case CTExtraEquipmentTypeSnowChains:
            return CTLocalizedString(CTRentalDetailSnowChains);
        case CTExtraEquipmentTypeSnowTires:
            return CTLocalizedString(CTRentalDetailSnowTires);
        case CTExtraEquipmentTypeToddlerSeat:
            return CTLocalizedString(CTRentalDetailToddlerSeat);
        case CTExtraEquipmentTypeTollTag:
            return CTLocalizedString(CTRentalDetailTollTag);
        case CTExtraEquipmentTypeWifi:
            return CTLocalizedString(CTRentalDetailWifi);
        case CTExtraEquipmentTypeWinterPackage:
            return CTLocalizedString(CTRentalDetailWinterPackage);
        default:
            return CTLocalizedString(CTRentalExtrasPaidAtDesk);
            break;
    }
}


// MARK: UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        return CGSizeMake(kCarouselCellWidth, kCarouselCellHeight);
    }
    
    CGFloat height = [self.indexesOfCellsWithDetailDisplayed containsIndex:indexPath.row] ? kListCellHeightExpanded : kListCellHeight;
    return CGSizeMake(self.collectionView.frame.size.width, height);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal && !self.scrollViewDidBeginDragging) {
        self.scrollViewDidBeginDragging = YES;
        [[CTAnalytics instance] tagScreen:@"extras" detail:@"scroll" step:nil];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        return;
    }
    
    [[CTAnalytics instance] tagScreen:@"extras" detail:@"all_clk" step:nil];
    
    UICollectionViewCell <CTExtrasCollectionViewCellProtocol> *cell = (UICollectionViewCell <CTExtrasCollectionViewCellProtocol> *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    if ([self.indexesOfCellsWithDetailDisplayed containsIndex:indexPath.row]) {
        [self.indexesOfCellsWithDetailDisplayed removeIndex:indexPath.row];
        [cell setDetailDisplayed:NO animated:YES];
    } else {
        [self.indexesOfCellsWithDetailDisplayed addIndex:indexPath.row];
        [cell setDetailDisplayed:YES animated:YES];
    }
    
    [collectionView performBatchUpdates:nil completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate) {
        double percentage = scrollView.contentOffset.x / (scrollView.contentSize.width - scrollView.frame.size.width);
        NSInteger index = percentage * self.extras.count;
        [self.delegate collectionView:self didScrollToIndex:index];
    }
}

// MARK: CTExtrasCollectionViewCellDelegate

- (void)cellDidTapInfo:(UICollectionViewCell <CTExtrasCollectionViewCellProtocol> *)cell {
    NSInteger index = [self.collectionView indexPathForCell:cell].row;
    [self.indexesOfCellsWithDetailDisplayed addIndex:index];
    [cell setDetailDisplayed:YES animated:YES];
}

- (void)cellDidTapClose:(UICollectionViewCell <CTExtrasCollectionViewCellProtocol> *)cell {
    NSInteger index = [self.collectionView indexPathForCell:cell].row;
    [self.indexesOfCellsWithDetailDisplayed removeIndex:index];
    [cell setDetailDisplayed:NO animated:YES];
}

- (void)cellDidTapIncrement:(UICollectionViewCell <CTExtrasCollectionViewCellProtocol> *)cell {
    NSInteger index = [self.collectionView indexPathForCell:cell].row;
    CTExtraEquipment *extra = self.extras[index];
    
    if (extra.isIncludedInRate) {
        return;
    }
    
    if (extra.qty < kMaxExtras) {
        extra.qty++;
        [cell setDecrementEnabled:YES];
        cell.count = extra.qty;
    }
    
    if (extra.qty == kMaxExtras) {
        [cell setIncrementEnabled:NO];
    }
    [self.delegate collectionViewDidAddExtra:self];
}

- (void)cellDidTapDecrement:(UICollectionViewCell <CTExtrasCollectionViewCellProtocol> *)cell {
    NSInteger index = [self.collectionView indexPathForCell:cell].row;
    CTExtraEquipment *extra = self.extras[index];
    
    if (extra.isIncludedInRate) {
        return;
    }
    
    if (extra.qty > 0) {
        extra.qty--;
        [cell setIncrementEnabled:YES];
        cell.count = extra.qty;
    }
    
    if (extra.qty == 0) {
        [cell setDecrementEnabled:NO];
    }
}

@end
