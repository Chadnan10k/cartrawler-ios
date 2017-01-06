//
//  CTSelectedVehicleView.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 21/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleView.h"
#import "CTInPathBanner.h"
#import <CartrawlerSDK/CTImageCache.h>
#import <CartrawlerSDK/CTAppearance.h>

@interface CTSelectedVehicleView()

@property (nonatomic, strong) UIImageView *vehicleImageView;
@property (nonatomic, strong) CTInPathBanner *bannerView;
@property (nonatomic, strong) UILabel *vehicleNameLabel;
@property (nonatomic, strong) UIView *bannerContainer;

@end

@implementation CTSelectedVehicleView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self addVehicleImage];
    [self addBanner];
    [self addLabel];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self addVehicleImage];
    [self addBanner];
    [self addLabel];
    return self;
}

- (void)addVehicleImage
{
    _vehicleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.vehicleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.vehicleImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.vehicleImageView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(150)]-8-|" options:0 metrics:nil views:@{@"view" : self.vehicleImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-32-[view]-16-|" options:0 metrics:nil views:@{@"view" : self.vehicleImageView}]];
    
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
    [banner addToSuperViewWithString:@"Car added" superview:self.bannerContainer];
    [banner setIcon:[UIImage imageNamed:@"checkmark" inBundle:bundle compatibleWithTraitCollection:nil]
    backgroundColor:[CTAppearance instance].merchandisingGreatValue
          textColor:[UIColor whiteColor]];
}

- (void)addLabel
{
    _vehicleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.vehicleNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.vehicleNameLabel.numberOfLines = 0;
    [self addSubview:self.vehicleNameLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[label]-8-[cars]" options:0 metrics:nil views:@{@"label" : self.vehicleNameLabel, @"cars" : self.vehicleImageView}]];
    //[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[banner]-8-[label]-8-|" options:0 metrics:nil views:@{@"label" : self.vehicleNameLabel, @"banner" : self.bannerContainer}]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.vehicleNameLabel
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.vehicleImageView
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                   constant:0]];
}

- (void)setVehicle:(CTInPathVehicle *)vehicle
{
    [[CTImageCache sharedInstance] cachedImage:vehicle.vehicleImageURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    self.vehicleNameLabel.attributedText = [self attributedVehicleString:vehicle.vehicleName orSimilar:vehicle.vehicleOrSimilar];
}

- (NSAttributedString *)attributedVehicleString:(NSString *)vehicleName orSimilar:(NSString *)orSimilar
{
    NSMutableAttributedString *mutString = [NSMutableAttributedString new];
    
    NSAttributedString *vehicleNameStr = [[NSAttributedString alloc] initWithString:vehicleName
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].boldFontName size:17],
                                                                                      NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    [mutString appendAttributedString:vehicleNameStr];
    
    NSAttributedString *newLine = [[NSAttributedString alloc] initWithString:@"\n"];
    [mutString appendAttributedString:newLine];

    NSAttributedString *orSimilarStr = [[NSAttributedString alloc] initWithString:orSimilar
                                                                        attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].fontName size:14],
                                                                                    NSForegroundColorAttributeName: [UIColor grayColor]}];
    
    [mutString appendAttributedString:orSimilarStr];
    
    return mutString;
}

@end