//
//  CTVehicleDetailsView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 07/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleDetailsView.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import <CartrawlerSDK/CTImageCache.h>
#import <CartrawlerSDK/CTRentalSearch.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import "CTRentalLocalizationConstants.h"
#import "CTVehicleDetailsCollectionViewCell.h"

@interface CTVehicleDetailsView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) CTLabel *headerLeftLabel;
@property (nonatomic, strong) CTLabel *headerRightLabel;
@property (nonatomic, strong) CTLabel *subheaderLeftLabel;
@property (nonatomic, strong) CTLabel *subheaderRightLabel;
@property (nonatomic, strong) UIImageView *vehicleImageView;
@property (nonatomic, strong) UICollectionView *infoCollectionView;
@property (nonatomic, strong) CTVehicle *vehicle;

@end

@implementation CTVehicleDetailsView

- (void)setVehicle:(CTVehicle *)vehicle pickupDate:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate;
{
    _vehicle = vehicle;
    [self addData:vehicle pickupDate:pickupDate dropoffDate:dropoffDate];
}

- (instancetype)init
{
    self = [super init];
    [self createViews];
    [self applyConstraints];
    return self;
}

- (void)createViews
{
    _headerLeftLabel = [CTLabel new];
    self.headerLeftLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerLeftLabel.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:18];
    self.headerLeftLabel.adjustsFontSizeToFitWidth = YES;
    self.headerLeftLabel.textColor = [CTAppearance instance].headerTitleColor;

    _headerRightLabel = [CTLabel new];
    self.headerRightLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerRightLabel.textAlignment = NSTextAlignmentRight;
    self.headerRightLabel.adjustsFontSizeToFitWidth = YES;
    self.headerRightLabel.textColor = [CTAppearance instance].headerTitleColor;

    _subheaderLeftLabel = [CTLabel new];
    self.subheaderLeftLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subheaderLeftLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:15];
    self.subheaderLeftLabel.textColor = [CTAppearance instance].subheaderTitleColor;

    _subheaderRightLabel = [CTLabel new];
    self.subheaderRightLabel.textAlignment = NSTextAlignmentRight;
    self.subheaderRightLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subheaderRightLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:15];
    self.subheaderRightLabel.textColor = [CTAppearance instance].subheaderTitleColor;
    
    _vehicleImageView = [UIImageView new];
    self.vehicleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.vehicleImageView.contentMode = UIViewContentModeScaleAspectFit;

    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = [self cellSize];
    flowLayout.minimumLineSpacing = 16;
    flowLayout.minimumInteritemSpacing = 16;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    _infoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.infoCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.infoCollectionView.contentMode = UIViewContentModeScaleAspectFit;
    self.infoCollectionView.dataSource = self;
    self.infoCollectionView.delegate = self;
    self.infoCollectionView.backgroundColor = [UIColor whiteColor];
    
    [self.infoCollectionView registerClass:[CTVehicleDetailsCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self addSubview:self.headerLeftLabel];
    [self addSubview:self.headerRightLabel];
    [self addSubview:self.subheaderLeftLabel];
    [self addSubview:self.subheaderRightLabel];
    [self addSubview:self.vehicleImageView];
    [self addSubview:self.infoCollectionView];

}

- (void)addData:(CTVehicle *)vehicle pickupDate:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate
{
    //header label
    self.headerLeftLabel.text = vehicle.makeModelName;
    
    NSNumber *pricePerDay = [self pricePerDay:vehicle
                                   pickupDate:pickupDate
                                  dropoffDate:dropoffDate];
    
    NSMutableAttributedString *priceCompoundString = [NSMutableAttributedString new];
    
    NSAttributedString *priceString = [[NSAttributedString alloc] initWithString:[pricePerDay numberStringWithCurrencyCode]
                                                                      attributes:@{NSFontAttributeName :
                                                                                       [UIFont fontWithName:[CTAppearance instance].boldFontName
                                                                                                       size:18]
                                                                                   }];
    
    NSAttributedString *perDayString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", CTLocalizedString(CTRentalExtrasPerDay)]
                                                                      attributes:@{NSFontAttributeName :
                                                                                       [UIFont fontWithName:[CTAppearance instance].boldFontName
                                                                                                       size:15]
                                                                                   }];
    [priceCompoundString appendAttributedString:priceString];
    [priceCompoundString appendAttributedString:perDayString];

    self.headerRightLabel.attributedText = priceCompoundString;
    
    //subheader label
    self.subheaderLeftLabel.text = vehicle.orSimilar;
    self.subheaderRightLabel.text = [NSString stringWithFormat:@"%@ %@", CTLocalizedString(CTRentalSummaryTotal), [vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode]];

    
    [[CTImageCache sharedInstance] cachedImage:vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];

    [self.infoCollectionView reloadData];
}

- (void)applyConstraints
{

    //subheader left detail label
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[header]-0-[view]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"header" : self.headerLeftLabel,
                                                                           @"view" : self.subheaderLeftLabel}]];
    //subheader right detail
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[header]-0-[view]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"header" : self.headerRightLabel,
                                                                           @"view" : self.subheaderRightLabel}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[leftDetail]-8-[rightDetail]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"leftDetail" : self.headerLeftLabel,
                                                                           @"rightDetail" : self.headerRightLabel}]];

    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[leftDetail]-8-[rightDetail]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"leftDetail" : self.subheaderLeftLabel,
                                                                           @"rightDetail" : self.subheaderRightLabel}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[imageView]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"imageView" : self.vehicleImageView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subheader]-8-[imageView(120)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"imageView" : self.vehicleImageView,
                                                                           @"subheader" : self.subheaderLeftLabel}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[collectionView]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"collectionView" : self.infoCollectionView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView]-8-[collectionView(60)]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"imageView" : self.vehicleImageView,
                                                                           @"collectionView" : self.infoCollectionView}]];
}

// MARK: Price Per Day

- (NSNumber *)pricePerDay:(CTVehicle *)vehicle pickupDate:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:pickupDate
                                                          toDate:dropoffDate
                                                         options:0];
    return [NSNumber numberWithFloat: vehicle.totalPriceForThisVehicle.floatValue / ([components day] ?: 1)];
}

- (void)prepareForInterfaceBuilder
{
    [self createViews];
    [self applyConstraints];
}

// MARK: UICollectionViewDelegate

- (CGSize)cellSize
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = (screenRect.size.width / 4) -16;
    return CGSizeMake(width, 60);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CTVehicleDetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setIndex:indexPath.row vehicle:self.vehicle];
    return cell;
}

 - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate) {
        [self.delegate didTapMoreDetailsView];
    }
}

@end
