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

@property (nonatomic, strong) UILabel *vehicleNameLabel;
@property (nonatomic, strong) UIView *bannerContainer;

@end

@implementation CTSelectedVehicleView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self addBanner];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self addBanner];
    return self;
}


- (void)addBanner
{
    _bannerContainer = [[UIView alloc] initWithFrame:CGRectZero];
    self.bannerContainer.translatesAutoresizingMaskIntoConstraints = NO;
	self.bannerContainer.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bannerContainer];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view" : self.bannerContainer}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[view]" options:0 metrics:nil views:@{@"view" : self.bannerContainer}]];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    CTInPathBanner *banner = [[CTInPathBanner alloc] init];
    [banner addToSuperViewWithString:CTLocalizedString(CTInPathWidgetTitleAdded) superview:self];
    [banner setIcon:[UIImage imageNamed:@"added_checkmark" inBundle:bundle compatibleWithTraitCollection:nil]
    backgroundColor:[UIColor whiteColor]
          textColor:[UIColor blackColor]];
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

@end
