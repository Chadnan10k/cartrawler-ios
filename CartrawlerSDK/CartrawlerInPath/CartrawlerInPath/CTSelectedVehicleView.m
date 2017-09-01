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
#import "CTInPathLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTSelectedVehicleView()

@property (nonatomic, strong) UIImageView *vehicleImageView;
@property (nonatomic, strong) CTInPathBanner *bannerView;
@property (nonatomic, strong) UILabel *vehicleNameLabel;
@property (nonatomic, strong) UIView *bannerContainer;
@property (nonatomic, strong) UIView *divisorLine;

@end

@implementation CTSelectedVehicleView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
//    [self addVehicleImage];
    [self addBanner];
//	[self addDivisorLine];
    [self addLabel];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
//    [self addVehicleImage];
    [self addBanner];
//	[self addDivisorLine];
    [self addLabel];
    return self;
}

- (void)addVehicleImage
{
    _vehicleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.vehicleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.vehicleImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.vehicleImageView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[view(84@750)]-16-|" options:0 metrics:nil views:@{@"view" : self.vehicleImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(148)]-8-|" options:0 metrics:nil views:@{@"view" : self.vehicleImageView}]];
    
}

- (void)addBanner
{
    _bannerContainer = [[UIView alloc] initWithFrame:CGRectZero];
    self.bannerContainer.translatesAutoresizingMaskIntoConstraints = NO;
    self.bannerContainer.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bannerContainer];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.bannerContainer}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]" options:0 metrics:nil views:@{@"view" : self.bannerContainer}]];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    CTInPathBanner *banner = [[CTInPathBanner alloc] init];
    [banner addToSuperViewWithString:CTLocalizedString(CTInPathWidgetTitleAdded) superview:self.bannerContainer];
    [banner setIcon:[UIImage imageNamed:@"added_checkmark" inBundle:bundle compatibleWithTraitCollection:nil]
    backgroundColor:[UIColor whiteColor]
          textColor:[UIColor blackColor]];
}

- (void)addDivisorLine
{
//	_divisorLine = [[UIView alloc] initWithFrame:CGRectZero];
//	self.divisorLine.translatesAutoresizingMaskIntoConstraints = NO;
//	self.divisorLine.backgroundColor = [UIColor lightGrayColor];
//	[self addSubview:self.divisorLine];
//	
//	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[view]-5-|" options:0 metrics:nil views:@{@"view" : self.divisorLine}]];
//	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(1)]-55-|" options:0 metrics:nil views:@{@"view" : self.divisorLine}]];
}

- (void)addLabel
{
    _vehicleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.vehicleNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.vehicleNameLabel.numberOfLines = 0;
    [self addSubview:self.vehicleNameLabel];
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[label]-0-|" options:0 metrics:nil views:@{@"label" : self.vehicleNameLabel}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[banner]-8-[label]-8-|" options:0 metrics:nil views:@{@"label" : self.vehicleNameLabel, @"banner" : self.bannerContainer}]];
}

- (void)setVehicle:(CTInPathVehicle *)vehicle
{
//    [[CTImageCache sharedInstance] cachedImage:vehicle.vehicleImageURL completion:^(UIImage *image) {
//        self.vehicleImageView.image = image;
//    }];
//    self.vehicleNameLabel.attributedText = [self attributedVehicleString:@"total" orSimilar:[NSString stringWithFormat:@"%@", vehicle.totalCost]];
}

- (NSAttributedString *)attributedVehicleString:(NSString *)vehicleName totalPrice:(NSString *)totalPrice
{
	
	NSMutableAttributedString *mutString = [NSMutableAttributedString new];
	
	NSAttributedString *vehicleNameStr = [[NSAttributedString alloc] initWithString:vehicleName
																		 attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].fontName size:14],
																					  NSForegroundColorAttributeName: [UIColor grayColor]}];
	
	[mutString appendAttributedString:vehicleNameStr];
	
	NSAttributedString *newLine = [[NSAttributedString alloc] initWithString:@"\n"];
	[mutString appendAttributedString:newLine];
	
	NSAttributedString *orSimilarStr = [[NSAttributedString alloc] initWithString:totalPrice
																	   attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].boldFontName size:17],
																					NSForegroundColorAttributeName: [UIColor blackColor]}];
	
	[mutString appendAttributedString:orSimilarStr];
	
	return mutString;
}

- (NSAttributedString *)attributedVehicleString:(NSString *)vehicleName orSimilar:(NSString *)orSimilar
{
    NSMutableAttributedString *mutString = [NSMutableAttributedString new];
	
    NSAttributedString *vehicleNameStr = [[NSAttributedString alloc] initWithString:vehicleName
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].fontName size:14],
                                                                                      NSForegroundColorAttributeName: [UIColor grayColor]}];
    
    [mutString appendAttributedString:vehicleNameStr];
    
    NSAttributedString *newLine = [[NSAttributedString alloc] initWithString:@"\n"];
    [mutString appendAttributedString:newLine];

    NSAttributedString *orSimilarStr = [[NSAttributedString alloc] initWithString:orSimilar
                                                                        attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].boldFontName size:17],
                                                                                    NSForegroundColorAttributeName: [UIColor blackColor]}];
    
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
