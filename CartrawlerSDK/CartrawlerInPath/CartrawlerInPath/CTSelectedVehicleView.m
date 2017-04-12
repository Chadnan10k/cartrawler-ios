//
//  CTSelectedVehicleView.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 21/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleView.h"
#import <CartrawlerSDK/CTUpSellBanner.h>
#import "CTCarouselFooterView.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTImageCache.h>
#import <CartrawlerSDK/CTAppearance.h>
#import "CTInPathLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CartrawlerSDK+UIImageView.h>

@interface CTSelectedVehicleView() <CTCarouselFooterDelegate>

@property (nonatomic, strong) UIImageView *vehicleImageView;
@property (nonatomic, strong) CTLabel *vehicleNameLabel;
@property (nonatomic, strong) UIView *bannerContainer;
@property (nonatomic, strong) UIView *featureContainer;
@property (nonatomic, strong) CTLabel *featureLabel;
@property (nonatomic, strong) CTCarouselFooterView *footerContainer;

@end

@implementation CTSelectedVehicleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    _bannerContainer = [self renderBanner];
    [self addSubview:self.bannerContainer];
    
    _footerContainer = [self renderFooter];
    [self addSubview:self.footerContainer];
    
    _vehicleImageView = [self renderVehicleImage];
    [self addSubview:self.vehicleImageView];
    
    _featureContainer = [self renderFeatureView];
    [self addSubview:self.featureContainer];
    
    _vehicleNameLabel = [self renderVehicleLabel];
    [self addSubview:self.vehicleNameLabel];
    
    [self layout];
    
    self.footerContainer.delegate = self;
    
    return self;
}

- (void)layout
{
    
    NSDictionary *viewDictionary = @{
                                     @"bannerContainer" : self.bannerContainer,
                                     @"footerContainer" : self.footerContainer,
                                     @"imageView" : self.vehicleImageView,
                                     @"featureContainer" : self.featureContainer,
                                     @"vehicleNameLabel" : self.vehicleNameLabel
                                     };
    //Banner
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[bannerContainer(40)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bannerContainer]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    //Footer
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[footerContainer]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[footerContainer(45)]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    //Image View
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bannerContainer]-0-[imageView(100@750)]-4-[footerContainer]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(100)]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    //Vehicle name label
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bannerContainer]-0-[vehicleNameLabel]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[vehicleNameLabel]-8-[imageView]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    //Feature container
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[vehicleNameLabel]-4-[featureContainer]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[featureContainer]-4-[imageView]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self(150)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"self" : self}]];
}

- (void)setVehicle:(CTAvailabilityItem *)item;
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
    
    [[CTImageCache sharedInstance] cachedImage:item.vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    self.vehicleNameLabel.attributedText = [self attributedVehicleString:item.vehicle.makeModelName orSimilar:item.vehicle.orSimilar];
    
    self.featureLabel.text = [self specialOfferText:item.vehicle.specialOffers];
    
    [self.footerContainer setVehicle:item.vehicle
                         buttonTitle:CTLocalizedString(CTInPathWidgetRemove)
                       disableButton:NO
                         perDayPrice:NO
                          pickupDate:nil
                         dropoffDate:nil];
}

- (UIView *)renderBanner
{
    UIView *bannerView = [UIView new];
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    bannerView.backgroundColor = [UIColor clearColor];
    
    [bannerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(40)]" options:0 metrics:nil views:@{@"view" : bannerView}]];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    CTUpSellBanner *banner = [[CTUpSellBanner alloc] init];
    [banner addToSuperview:bannerView];

    [banner setIcon:[UIImage imageNamed:@"checkmark" inBundle:bundle compatibleWithTraitCollection:nil]
    backgroundColor:[CTAppearance instance].merchandisingGreatValue
          textColor:[UIColor whiteColor]
               text:CTLocalizedString(CTInPathWidgetTitleAdded)];
    return bannerView;
}

- (CTCarouselFooterView *)renderFooter
{
    CTCarouselFooterView *footerView = [CTCarouselFooterView new];
    footerView.translatesAutoresizingMaskIntoConstraints = NO;
    return footerView;
}

- (UIImageView *)renderVehicleImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return imageView;
}

- (CTLabel *)renderVehicleLabel
{
    CTLabel *label = [CTLabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 0;
    return label;
}

- (UIView *)renderFeatureView
{
    
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIImageView *tickImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    tickImageView.image = [UIImage imageNamed:@"checkmark" inBundle:bundle compatibleWithTraitCollection:nil];
    tickImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [tickImageView applyTintWithColor:[CTAppearance instance].buttonColor];
    
    [container addSubview:tickImageView];
    
    _featureLabel = [CTLabel new];
    self.featureLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:12];
    self.featureLabel.textColor = [UIColor lightGrayColor];
    self.featureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.featureLabel.numberOfLines = 0;
    [container addSubview: self.featureLabel];
    
    NSDictionary *viewDictionary = @{
                                     @"tickImageView" : tickImageView,
                                     @"featureLabel" : self.featureLabel,
                                     };
    
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tickImageView(10)]-[featureLabel]-0-|" options:0 metrics:nil views:viewDictionary]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[featureLabel]-0-|" options:0 metrics:nil views:viewDictionary]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[tickImageView(10)]" options:0 metrics:nil views:viewDictionary]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:tickImageView attribute:NSLayoutAttributeCenterY relatedBy:0 toItem:self.featureLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:1]];
    
    return container;
}

- (NSString *)specialOfferText:(NSArray <CTSpecialOffer *> *)specialOffers
{
    
    if (specialOffers.count == 0) {
        return @"Great Price!";
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
        return specialOffers.firstObject.shortText;
    }
}

- (NSAttributedString *)attributedVehicleString:(NSString *)vehicleName orSimilar:(NSString *)orSimilar
{
    NSMutableAttributedString *mutString = [NSMutableAttributedString new];
    
    NSAttributedString *vehicleNameStr = [[NSAttributedString alloc] initWithString:vehicleName
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].boldFontName size:14],
                                                                                      NSForegroundColorAttributeName: [UIColor blackColor]}];
    [mutString appendAttributedString:vehicleNameStr];
    
    NSAttributedString *newLine = [[NSAttributedString alloc] initWithString:@"\n"];
    [mutString appendAttributedString:newLine];
    
    NSAttributedString *orSimilarStr = [[NSAttributedString alloc] initWithString:orSimilar
                                                                       attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].fontName size:12],
                                                                                    NSForegroundColorAttributeName: [UIColor grayColor]}];
    
    [mutString appendAttributedString:orSimilarStr];
    
    return mutString;
}

//MARK: CTFooterDelegate

- (void)didTapFooterButton
{
    if (self.delegate) {
        [self.delegate didTapRemoveVehicle];
    }
}

@end
