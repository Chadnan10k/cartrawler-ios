//
//  CTCarouselCollectionViewCell.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 24/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCarouselCollectionViewCell.h"
#import "CTInPathBanner.h"
#import "CTCarouselFooterView.h"
#import <CartrawlerSDK/CTImageCache.h>
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTLabel.h>
#import "CTInPathLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CartrawlerSDK+UIImageView.h>

@interface CTCarouselCollectionViewCell()

@property (nonatomic, strong) UIImageView *vehicleImageView;
@property (nonatomic, strong) UILabel *vehicleNameLabel;
@property (nonatomic, strong) UIView *bannerContainer;
@property (nonatomic, strong) CTCarouselFooterView *footerContainer;
@property (strong, nonatomic) CTLabel *featureLabel;
@property (strong, nonatomic) UIImageView *tickImageView;

@end

@implementation CTCarouselCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self addBanner];
    [self addFooter];
    [self addVehicleImage];
    [self addLabel];
    [self addFeatureTextView];
    
    return self;
}

- (void)setVehicle:(CTAvailabilityItem *)vehicle
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
    
    [[CTImageCache sharedInstance] cachedImage:vehicle.vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    self.vehicleNameLabel.attributedText = [self attributedVehicleString:vehicle.vehicle.makeModelName orSimilar:vehicle.vehicle.orSimilar];
}

- (void)addBanner
{
    _bannerContainer = [[UIView alloc] initWithFrame:CGRectZero];
    self.bannerContainer.translatesAutoresizingMaskIntoConstraints = NO;
    self.bannerContainer.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bannerContainer];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.bannerContainer}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view(40)]" options:0 metrics:nil views:@{@"view" : self.bannerContainer}]];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    CTInPathBanner *banner = [[CTInPathBanner alloc] init];
    [banner addToSuperViewWithString:@"Deal of the day" superview:self.bannerContainer];
    [banner setIcon:[UIImage imageNamed:@"checkmark" inBundle:bundle compatibleWithTraitCollection:nil]
    backgroundColor:[UIColor colorWithRed:191.0/255.0 green:61.0/255.0 blue:43.0/255.0 alpha:1]
          textColor:[UIColor whiteColor]];
}

- (void)addFooter
{
    _footerContainer = [CTCarouselFooterView new];
    self.footerContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.footerContainer];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.footerContainer}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(45)]-0-|" options:0 metrics:nil views:@{@"view" : self.footerContainer}]];
}

- (void)addVehicleImage
{
    _vehicleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.vehicleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.vehicleImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.vehicleImageView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[banner]-0-[view(100@750)]-4-[footer]" options:0 metrics:nil views:@{@"banner" : self.bannerContainer, @"view" : self.vehicleImageView, @"footer" : self.footerContainer}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(100)]-8-|" options:0 metrics:nil views:@{@"view" : self.vehicleImageView}]];
    
}

- (void)addLabel
{
    _vehicleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.vehicleNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.vehicleNameLabel.numberOfLines = 0;
    [self addSubview:self.vehicleNameLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[label]-8-[cars]" options:0 metrics:nil views:@{@"label" : self.vehicleNameLabel, @"cars" : self.vehicleImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[banner]-4-[label]" options:0 metrics:nil views:@{@"label" : self.vehicleNameLabel, @"banner" : self.bannerContainer, @"footer" : self.footerContainer}]];
    
}

- (void)addFeatureTextView
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    _tickImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.tickImageView.image = [UIImage imageNamed:@"checkmark" inBundle:bundle compatibleWithTraitCollection:nil];
    self.tickImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tickImageView applyTintWithColor:[CTAppearance instance].buttonColor];
    
    [self addSubview:self.tickImageView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view(10)]" options:0 metrics:nil views:@{@"view" : self.tickImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-8-[view(10)]" options:0 metrics:nil views:@{@"view" : self.tickImageView, @"label" : self.vehicleNameLabel}]];
    
    _featureLabel = [CTLabel new];
    self.featureLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:12];
    self.featureLabel.textColor = [UIColor lightGrayColor];
    self.featureLabel.text = @"Free GPS";
    self.featureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.featureLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[star]-4-[textView]-4-[cars]" options:0 metrics:nil views:@{@"textView" : self.featureLabel, @"star" : self.tickImageView, @"cars" : self.vehicleImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-4-[textView]" options:0 metrics:nil views:@{@"textView" : self.featureLabel, @"label" : self.vehicleNameLabel, @"footer" : self.footerContainer}]];
    [self.featureLabel sizeToFit];
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

- (void)animateVehicle
{
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0.1 options:0 animations:^{
        self.vehicleImageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.vehicleImageView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }];
}


@end
