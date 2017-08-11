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
#import "CartrawlerSDK/CTImageTextView.h"

@interface CTVehicleDetailsView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) CTLabel *headerLeftLabel;
@property (nonatomic, strong) CTLabel *headerRightLabel;
@property (nonatomic, strong) CTLabel *subheaderLeftLabel;
@property (nonatomic, strong) UIImageView *supplierImageView;
@property (nonatomic, strong) UIImageView *vehicleImageView;
@property (nonatomic, strong) UICollectionView *infoCollectionView;
@property (nonatomic, strong) CTVehicle *vehicle;
@property (nonatomic, strong) CTImageTextView *featureAlertView;

@end

@implementation CTVehicleDetailsView

- (void)setItem:(CTAvailabilityItem *)item pickupDate:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate
{
    _vehicle = item.vehicle;
    [self addData:item pickupDate:pickupDate dropoffDate:dropoffDate];
    [self createAlertFeatureView];
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
    self.headerLeftLabel.textColor = [UIColor colorWithRed:46.0/255.0 green:46.0/255.0 blue:46.0/255.0 alpha:1];

    _headerRightLabel = [CTLabel new];
    self.headerRightLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerRightLabel.textAlignment = NSTextAlignmentRight;
    self.headerRightLabel.adjustsFontSizeToFitWidth = YES;
    self.headerRightLabel.textColor = [UIColor colorWithRed:46.0/255.0 green:46.0/255.0 blue:46.0/255.0 alpha:1];

    _subheaderLeftLabel = [CTLabel new];
    self.subheaderLeftLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subheaderLeftLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:15];
    self.subheaderLeftLabel.textColor = [UIColor colorWithRed:130.0/255.0 green:135.0/255.0 blue:144.0/255.0 alpha:1];

    _supplierImageView = [UIImageView new];
    self.supplierImageView.translatesAutoresizingMaskIntoConstraints = NO;

    
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
    [self addSubview:self.supplierImageView];
    [self addSubview:self.vehicleImageView];
    [self addSubview:self.infoCollectionView];
}

- (void)createAlertFeatureView
{
    _featureAlertView = [CTImageTextView new];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    if (self.vehicle.isUSBEnabled) {
        UIImage *icon = [UIImage imageNamed:@"usb" inBundle:bundle compatibleWithTraitCollection:nil];
        [self.featureAlertView insertImage:icon withText:CTLocalizedString(CTRentalFeatureUSB)];
    }
    
    if (self.vehicle.isBluetoothEnabled) {
        UIImage *icon = [UIImage imageNamed:@"bluetooth" inBundle:bundle compatibleWithTraitCollection:nil];
        [self.featureAlertView insertImage:icon withText:CTLocalizedString(CTRentalFeatureBluetooth)];
    }
    
    if (self.vehicle.isAirConditioned) {
        UIImage *icon = [UIImage imageNamed:@"aircon" inBundle:bundle compatibleWithTraitCollection:nil];
        [self.featureAlertView insertImage:icon withText:CTLocalizedString(CTRentalVehicleAirConditioning)];
    }
    
    if (self.vehicle.isGPSIncluded) {
        UIImage *icon = [UIImage imageNamed:@"gps" inBundle:bundle compatibleWithTraitCollection:nil];
        [self.featureAlertView insertImage:icon withText:CTLocalizedString(CTRentalFeatureGPS)];
    }
    
    if (self.vehicle.isGermanModel) {
        UIImage *icon = [UIImage imageNamed:@"checkbox" inBundle:bundle compatibleWithTraitCollection:nil];
        [self.featureAlertView insertImage:icon withText:CTLocalizedString(CTRentalFeatureGermanModel)];
    }
    
    if (self.vehicle.isParkingSensorEnabled) {
        UIImage *icon = [UIImage imageNamed:@"checkbox" inBundle:bundle compatibleWithTraitCollection:nil];
        [self.featureAlertView insertImage:icon withText:CTLocalizedString(CTRentalFeatureParkingSensors)];
    }
    
    if (self.vehicle.isExceptionalFuelEconomy) {
        UIImage *icon = [UIImage imageNamed:@"fuel" inBundle:bundle compatibleWithTraitCollection:nil];
        [self.featureAlertView insertImage:icon withText:CTLocalizedString(CTRentalFeatureFuelEconomy)];
    }
    
    if (self.vehicle.isFrontDemisterEnabled) {
        UIImage *icon = [UIImage imageNamed:@"checkbox" inBundle:bundle compatibleWithTraitCollection:nil];
        [self.featureAlertView insertImage:icon withText:CTLocalizedString(CTRentalFeatureFrontDemister)];
    }
    
    UIImage *icon = [UIImage imageNamed:@"gears" inBundle:bundle compatibleWithTraitCollection:nil];
    [self.featureAlertView insertImage:icon withText:self.vehicle.transmissionType];
	
	[self.featureAlertView insertImage:nil withText:@""];
}

- (void)addData:(CTAvailabilityItem *)item pickupDate:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate
{
    //header label
    self.headerLeftLabel.text = item.vehicle.makeModelName;
    
    NSString *pricePerDay = [item.vehicle.totalPriceForThisVehicle pricePerDay:pickupDate dropoff:dropoffDate];
    
    NSMutableAttributedString *priceCompoundString = [NSMutableAttributedString new];
    
    NSAttributedString *priceString = [[NSAttributedString alloc] initWithString:pricePerDay
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
    self.subheaderLeftLabel.text = item.vehicle.orSimilar;

    [[CTImageCache sharedInstance] cachedImage:item.vendor.logoURL completion:^(UIImage *image) {
        self.supplierImageView.image = image;
    }];
    
    [[CTImageCache sharedInstance] cachedImage:item.vehicle.pictureURL completion:^(UIImage *image) {
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[header]-4-[view(35)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"header" : self.headerRightLabel,
                                                                           @"view" : self.supplierImageView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[leftDetail]-8-[rightDetail]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"leftDetail" : self.headerLeftLabel,
                                                                           @"rightDetail" : self.headerRightLabel}]];

    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[leftDetail]-8@100-[rightDetail(80)]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"leftDetail" : self.subheaderLeftLabel,
                                                                           @"rightDetail" : self.supplierImageView}]];
    
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
    
    [self bringSubviewToFront:self.supplierImageView];
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
        [self.delegate didTapMoreDetailsView:self.featureAlertView];
    }
}

@end
