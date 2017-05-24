//
//  CTVehicleDetailTableViewCell.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 06/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleDetailTableViewCell.h"
#import "CTMerhandisingBanner.h"
#import "CartrawlerSDK/CTLayoutManager.h"
#import "CartrawlerSDK/CartrawlerSDK+UIView.h"
#import "CartrawlerSDK/CartrawlerSDK+NSNumber.h"
#import "CartrawlerSDK/CartrawlerSDK+UIImageView.h"
#import "CartrawlerSDK/CTImageCache.h"
#import "CartrawlerSDK/CTUpSellBanner.h"
#import "CartrawlerSDK/CTAppearance.h"
#import "CartrawlerSDK/CTLocalisedStrings.h"
#import "CartrawlerSDK/CartrawlerSDK+NSString.h"
#import "CTRentalLocalizationConstants.h"

@interface CTVehicleDetailTableViewCell()

@property (nonatomic, strong) UIView *bannerView;
@property (nonatomic, strong) UILabel *makeModelLabel;
@property (nonatomic, strong) UILabel *passengerLabel;
@property (nonatomic, strong) UILabel *bagsLabel;
@property (nonatomic, strong) UILabel *fuelLabel;
@property (nonatomic, strong) UILabel *pickupLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *vehicleImageView;
@property (nonatomic, strong) UIImageView *vendorImageView;
@property (nonatomic, strong) CTUpSellBanner *upSellBanner;
@property (nonatomic, strong) CTLayoutManager *manager;

@end

@implementation CTVehicleDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setup];
    return self;
}

- (void)setup
{
    _passengerLabel = [UILabel new];
    _bagsLabel = [UILabel new];
    _fuelLabel = [UILabel new];
    _pickupLabel = [UILabel new];
    _scoreLabel = [UILabel new];
    _priceLabel = [UILabel new];
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *containerView = [self createContainer];
    [self addSubview:containerView];
    
    [CTLayoutManager pinView:containerView
                 toSuperView:self
                     padding:UIEdgeInsetsMake(8, 8, 8, 8)];
}

- (void)setItem:(CTAvailabilityItem *)item pickupDate:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate;
{
    self.makeModelLabel.attributedText = [NSString attributedText:item.vehicle.makeModelName boldColor:[UIColor blackColor] boldSize:17 regularText:item.vehicle.orSimilar regularColor:[UIColor lightGrayColor] regularSize:15 useSpace:YES];
    [[CTImageCache sharedInstance] cachedImage:item.vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    [[CTImageCache sharedInstance] cachedImage:item.vendor.logoURL completion:^(UIImage *image) {
        self.vendorImageView.image = image;
    }];
    
    if (item.vehicle.merchandisingTag != CTMerchandisingTagUnknown || [self specialOfferText:item.vehicle.specialOffers]) {
        NSNumber *indexOfView = [self.manager indexOfObject:self.bannerView];
        if (indexOfView == nil) {
            self.upSellBanner.alpha = 1;
            [self.manager insertViewAtIndex:0 padding:UIEdgeInsetsMake(4,0,4,0) view:self.bannerView];
            [self setBannerText:item];
        } else {
            self.upSellBanner.alpha = 1;
            [self setBannerText:item];
        }
        
    } else {
        
        NSNumber *indexOfView = [self.manager indexOfObject:self.bannerView];
        if (indexOfView != nil) {
            self.upSellBanner.alpha = 0;
            [self.manager removeAtIndex:indexOfView.integerValue];
        }
    }

    self.passengerLabel.text = [NSString stringWithFormat:@"%@ %@", item.vehicle.passengerQty.stringValue, CTLocalizedString(CTRentalVehiclePassengers)];
    self.bagsLabel.text = [NSString stringWithFormat:@"%@ %@", item.vehicle.baggageQty.stringValue, CTLocalizedString(CTRentalVehicleBags)];
    self.fuelLabel.text = [CTLocalisedStrings fuelPolicy:item.vehicle.fuelPolicy];
    self.pickupLabel.text = [CTLocalisedStrings pickupType:item];
    
    self.scoreLabel.attributedText = [NSString attributedText:[@(item.vendor.rating.overallScore.doubleValue * 2) decimalPlaces:1]
                                                boldColor:[CTAppearance instance].iconTint
                                                 boldSize:17
                                              regularText:@"/10"
                                             regularColor:[UIColor lightGrayColor]
                                              regularSize:17
                                                 useSpace:NO];
    
    self.priceLabel.attributedText = [NSString attributedText:[item.vehicle.totalPriceForThisVehicle pricePerDay:pickupDate dropoff:dropoffDate]
                                                boldColor:[CTAppearance instance].iconTint
                                                 boldSize:21
                                              regularText:@""
                                             regularColor:[UIColor lightGrayColor]
                                              regularSize:17
                                                 useSpace:NO];

    [self updateLabelHeight:self.passengerLabel];
    [self updateLabelHeight:self.bagsLabel];
    [self updateLabelHeight:self.fuelLabel];
    [self updateLabelHeight:self.pickupLabel];
}

- (UIView *)createContainer
{
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    container.backgroundColor = [UIColor whiteColor];
    container.layer.cornerRadius = 5;
    container.layer.borderWidth = 0.5;
    container.layer.borderColor = [UIColor lightGrayColor].CGColor;
    container.layer.masksToBounds = YES;
    
    _bannerView = [self createBannerContainer];
    
    _manager = [CTLayoutManager layoutManagerWithContainer:container];

    [self.manager insertView:UIEdgeInsetsMake(4, 8, 4, 8) view:[self createNameContainer]];
    [self.manager insertView:UIEdgeInsetsMake(4, 8, 0, 8) view:[self createDetailsBlock]];
    [self.manager insertView:UIEdgeInsetsMake(0, 8, 8, 8) view:[self createFooterContainer]];

    [self.manager layoutViews];
    
    return container;
}

- (UIView *)createBannerContainer
{
    UIView *banner = [UIView new];
    banner.translatesAutoresizingMaskIntoConstraints = NO;
    [banner setHeightConstraint:@40 priority:@750];

    _upSellBanner = [CTUpSellBanner new];    
    [self.upSellBanner addToSuperview:banner];
    return banner;
}

- (UIView *)createNameContainer
{
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    _makeModelLabel = [UILabel new];
    [container addSubview:self.makeModelLabel];
    [CTLayoutManager pinView:self.makeModelLabel toSuperView:container];
    return container;
}

- (UIView *)createDetailsBlock
{
    
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *detailsView = [UIView new];
    detailsView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CTLayoutManager *detailsViewManager = [CTLayoutManager layoutManagerWithContainer:detailsView];
    detailsViewManager.orientation = CTLayoutManagerOrientationTopToBottom;
    detailsViewManager.justify = NO;
    [detailsViewManager insertView:UIEdgeInsetsMake(4, 0, 4, 8) view:[self createImageTextView:self.passengerLabel iconName: @"people"]];
    [detailsViewManager insertView:UIEdgeInsetsMake(4, 0, 4, 8) view:[self createImageTextView:self.bagsLabel iconName: @"baggage"]];
    [detailsViewManager insertView:UIEdgeInsetsMake(4, 0, 4, 8) view:[self createImageTextView:self.fuelLabel iconName: @"fuel"]];
    [detailsViewManager insertView:UIEdgeInsetsMake(4, 0, 4, 8) view:[self createImageTextView:self.pickupLabel iconName: @"location"]];
    [detailsViewManager layoutViews];
    
    _vehicleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.vehicleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.vehicleImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.vendorImageView setHeightConstraint:@100 priority:@750];
    
    CTLayoutManager *manager = [CTLayoutManager layoutManagerWithContainer:container];
    manager.orientation = CTLayoutManagerOrientationLeftToRight;
    manager.justify = YES;
    [manager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:detailsView];
    [manager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:self.vehicleImageView];
    
    [manager layoutViews];
    
    return container;
}

- (UIView *)createImageTextView:(UILabel *)label iconName:(NSString *)iconName
{
    UIView *view = [UIView new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    UIImage *icon = [UIImage imageNamed:iconName
                                        inBundle:bundle
                   compatibleWithTraitCollection:nil];
    
    UIImageView *imageView = [UIImageView new];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [imageView setHeightConstraint:@20 priority:@1000];
    imageView.image = icon;
    [imageView applyTintWithColor:[CTAppearance instance].iconTint];
    
    label.font = [UIFont fontWithName:[CTAppearance instance].fontName size:14];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 0;
    [label sizeToFit];
    [view addSubview:imageView];
    [view addSubview:label];

    NSLayoutConstraint *imageVerticalConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                                               attribute:NSLayoutAttributeCenterY
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:view
                                                                               attribute:NSLayoutAttributeCenterY
                                                                              multiplier:1
                                                                                constant:0];
    
    NSDictionary *viewDict = @{@"imageView" : imageView, @"label" : label, @"view" : view};
    [view addConstraint:imageVerticalConstraint];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView(20)]-8-[label]-4-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDict]];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[label]-4-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDict]];

    [label setHeightConstraint:@([self textHeight:label]) priority:@1000];
    return view;
}

- (UIView *)createFooterContainer
{
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    [container setHeightConstraint:@50 priority:@1000];
    
    _scoreLabel = [UILabel new];
    self.scoreLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:self.scoreLabel];
    
    _vendorImageView = [UIImageView new];
    self.vendorImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.vendorImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:self.vendorImageView];

    _priceLabel = [UILabel new];
    self.priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    [container addSubview:self.priceLabel];
    
    UILabel *perDayLabel = [UILabel new];
    perDayLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:perDayLabel];
    perDayLabel.numberOfLines = 1;
    perDayLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:14];
    perDayLabel.text = CTLocalizedString(CTRentalExtrasPerDay);
    perDayLabel.textAlignment = NSTextAlignmentRight;
    
    NSDictionary *viewsDict = @{
                                @"scoreLabel" : self.scoreLabel,
                                @"supplierImage" : self.vendorImageView,
                                @"priceLabel" : self.priceLabel,
                                @"perDayLabel" : perDayLabel,
                                };
    
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scoreLabel]-8-[supplierImage(50)]" options:0 metrics:nil views:viewsDict]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[priceLabel]-0-|" options:0 metrics:nil views:viewsDict]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[perDayLabel]-0-|" options:0 metrics:nil views:viewsDict]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[priceLabel]-0-[perDayLabel(20)]-4-|" options:0 metrics:nil views:viewsDict]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[supplierImage(20)]" options:0 metrics:nil views:viewsDict]];

    NSLayoutConstraint *scoreVerticalConstraint = [NSLayoutConstraint constraintWithItem:self.scoreLabel
                                                                               attribute:NSLayoutAttributeCenterY
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:container
                                                                               attribute:NSLayoutAttributeCenterY
                                                                              multiplier:1
                                                                                constant:0];
    NSLayoutConstraint *imageVerticalConstraint = [NSLayoutConstraint constraintWithItem:self.vendorImageView
                                                                               attribute:NSLayoutAttributeCenterY
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:container
                                                                               attribute:NSLayoutAttributeCenterY
                                                                              multiplier:1
                                                                                constant:0];
    
    [container addConstraints:@[scoreVerticalConstraint, imageVerticalConstraint]];
    return container;
}

- (void)updateLabelHeight:(UILabel *)label
{
    [label cartrawlerConstraintForAttribute:NSLayoutAttributeHeight].constant = [self textHeight:label];
}

- (CGFloat)textHeight:(UILabel *)label
{
    CGFloat maxWidth = (self.frame.size.width / 2) - 48; //the 48 accounts for the padding trailing and leading to the label
    CGRect rect = [label.text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                  attributes:@{NSFontAttributeName:label.font}
                                     context:nil];
    CGFloat textHeight = rect.size.height;
    return ceil(textHeight);
}

- (void)setBannerText:(CTAvailabilityItem *)item
{
    if ([self specialOfferText:item.vehicle.specialOffers]) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        UIImage *icon = [UIImage imageNamed:@"bolt"
                                   inBundle:bundle
              compatibleWithTraitCollection:nil];
        [self.upSellBanner setIcon:icon
                   backgroundColor:[UIColor colorWithRed:207.0/255.0 green:46.0/255.0 blue:29.0/255.0 alpha:1]
                         textColor:[UIColor whiteColor]
                              text:[self specialOfferText:item.vehicle.specialOffers]];
    } else {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        UIImage *icon = [UIImage imageNamed:@"star"
                                   inBundle:bundle
              compatibleWithTraitCollection:nil];
        [self.upSellBanner setIcon:icon
                   backgroundColor:[self merchandisingColor:item.vehicle.merchandisingTag]
                         textColor:[UIColor whiteColor]
                              text:[self merchandisingText:item.vehicle.merchandisingTag]];
    }
}

- (NSString *)specialOfferText:(NSArray <CTSpecialOffer *> *)specialOffers
{
    
    if (specialOffers.count == 0) {
        return nil;
    }
    
    CTSpecialOffer *choosenOffer;
    BOOL priorityOfferFound = NO;
    for (CTSpecialOffer *so in specialOffers) {
        if (so.type == CTSpecialOfferTypeCartrawlerCash ||
            so.type == CTSpecialOfferTypePercentageDiscount ||
            so.type == CTSpecialOfferTypePercentageDiscountBranded ||
            so.type == CTSpecialOfferTypeGenericDiscount ||
            so.type == CTSpecialOfferTypeGenericDiscountBranded)
        {
            choosenOffer = so;
            priorityOfferFound = YES;
        }
    }
    
    if (priorityOfferFound) {
        return choosenOffer.shortText;
    } else {
        return nil;
    }
}


- (NSString *)merchandisingText:(CTMerchandisingTag)merchandisingTag
{
    switch (merchandisingTag) {
        case CTMerchandisingTagBusiness:
            return CTLocalizedString(CTRentalVehicleMerchandisingBusiness);
            
        case CTMerchandisingTagCityBreak:
            return CTLocalizedString(CTRentalVehicleMerchandisingCityBreak);
            
        case CTMerchandisingTagFamilySize:
            return CTLocalizedString(CTRentalVehicleMerchandisingFamilySize);
            
        case CTMerchandisingTagBestSeller:
            return CTLocalizedString(CTRentalVehicleMerchandisingBestSeller);
            
        case CTMerchandisingTagGreatValue:
            return CTLocalizedString(CTRentalVehicleMerchandisingGreatValue);
            break;
            
        case CTMerchandisingTagQuickestQueue:
            return CTLocalizedString(CTRentalVehicleMerchandisingQuickestQueue);
            break;
            
        case CTMerchandisingTagRecommended:
            return CTLocalizedString(CTRentalVehicleMerchandisingRecommended);
            break;
            
        case CTMerchandisingTagUpgradeTo:
            return CTLocalizedString(CTRentalVehicleMerchandisingUpgradeTo);
            break;
            
        case CTMerchandisingTagOnBudget:
            return CTLocalizedString(CTRentalVehicleMerchandisingOnBudget);
            break;
            
        case CTMerchandisingTagBestReviewed:
            return CTLocalizedString(CTRentalVehicleMerchandisingBestReviewed);
            break;
            
        case CTMerchandisingTagUnknown:
            return @"";
            break;
    }
}

- (UIColor *)merchandisingColor:(CTMerchandisingTag)merchandisingTag
{
    switch (merchandisingTag) {
        case CTMerchandisingTagBusiness:
            return [UIColor colorWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:1];
            
        case CTMerchandisingTagCityBreak:
            return [UIColor colorWithRed:4.0/255.0 green:119.0/255.0 blue:188.0/255.0 alpha:1];
            
        case CTMerchandisingTagFamilySize:
            return [UIColor colorWithRed:189.0/255.0 green:15.0/255.0 blue:134.0/255.0 alpha:1];
            
        case CTMerchandisingTagBestSeller:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            
        case CTMerchandisingTagGreatValue:
            return [UIColor colorWithRed:41.0/255.0 green:173.0/255.0 blue:79.0/255.0 alpha:1];
            
        case CTMerchandisingTagQuickestQueue:
            return [UIColor colorWithRed:255.0/255.0 green:90.0/255.0 blue:0.0/255.0 alpha:1];
            
        case CTMerchandisingTagRecommended:
            return [UIColor colorWithRed:254.0/255.0 green:67.0/255.0 blue:101.0/255.0 alpha:1];
            
        case CTMerchandisingTagUpgradeTo:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            
        case CTMerchandisingTagOnBudget:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            
        case CTMerchandisingTagBestReviewed:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            
        case CTMerchandisingTagUnknown:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
    }
}


@end
