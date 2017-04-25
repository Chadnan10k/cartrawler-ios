//
//  CTPaymentSummaryCompactView.m
//  CartrawlerRental
//
//  Created by Alan on 19/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTPaymentSummaryCompactView.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTButton.h>
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import "CTRentalLocalizationConstants.h"

@interface CTPaymentSummaryCompactView ()
@property (nonatomic, strong) CTButton *viewAllButton;
@property (nonatomic, strong) CTLabel *costLabel;
@property (nonatomic, strong) UIImageView *chevron;
@end

@implementation CTPaymentSummaryCompactView

// MARK: View Creation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:40.0/255.0 blue:101.0/255.0 alpha:1.0];
        
        self.viewAllButton = [self createButton];
        [self addSubview:self.viewAllButton];
        
        self.costLabel = [self createCostLabel];
        [self addSubview:self.costLabel];
        
        self.chevron = [self createChevron];
        [self addSubview:self.chevron];
        
        [self applyConstraints];
    }
    return self;
}

- (CTButton *)createButton {
    CTButton *viewAllButton = [CTButton new];
    [viewAllButton setTitle:CTLocalizedString(CTRentalOtherCars) forState:UIControlStateNormal];
    viewAllButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    viewAllButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    return viewAllButton;
}

- (CTLabel *)createCostLabel {
    CTLabel *costLabel = [[CTLabel alloc] init:15
                                     textColor:[UIColor whiteColor]
                                 textAlignment:NSTextAlignmentRight
                                      boldFont:YES];
    costLabel.translatesAutoresizingMaskIntoConstraints = NO;
    return costLabel;
}

- (UIImageView *)createChevron {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    UIImage *chevronImage = [[UIImage imageNamed:@"down_arrow" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImageView *chevron = [[UIImageView alloc] initWithImage:chevronImage];
    chevron.tintColor = [UIColor whiteColor];
    chevron.translatesAutoresizingMaskIntoConstraints = NO;
    
    return chevron;
}

- (void)applyConstraints {
    NSDictionary *views = @{@"costLabel": self.costLabel, @"chevron": self.chevron, @"viewAllButton": self.viewAllButton};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[viewAllButton(90)]-[costLabel]-20-[chevron(15)]-20-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.costLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.costLabel
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:30.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewAllButton
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.costLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewAllButton
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:35.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.chevron
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.costLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.chevron
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.chevron
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:0.0]];
}

// MARK: View Update

- (void)updateWithVehicle:(CTVehicle *)vehicle {
    self.costLabel.text = [NSString stringWithFormat:@"%@:  %@", CTLocalizedString(CTRentalCarRentalTotal), [vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode]];
}

@end
