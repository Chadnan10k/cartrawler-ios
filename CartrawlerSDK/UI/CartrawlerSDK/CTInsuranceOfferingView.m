//
//  CTInsuranceOfferingView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 09/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

//
//  CTInsuranceView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 08/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTInsuranceOfferingView.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTButton.h>
#import <CartrawlerSDK/CTTextView.h>
#import <CartrawlerSDK/CTHTMLParser.h>
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerAPI/CTInsurance.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import <CartrawlerSDK/CTLayoutManager.h>
#import <CartrawlerSDK/CartrawlerSDK+UIView.h>

@interface CTInsuranceOfferingView()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) CTLabel *headerLabel;
@property (nonatomic, strong) CTLabel *subheaderLabel;
@property (nonatomic, strong) UIImageView *shieldImageView;
@property (nonatomic, strong) CTButton *addNowButton;
@property (nonatomic, strong) UIButton *moreDetailsButton;
@property (nonatomic, strong) UIView *accordionView;
@property (nonatomic, strong) CTTextView *textView;
@property (nonatomic, strong) CTInsurance *insurance;
@property (nonatomic) BOOL isOpen;

@end

@implementation CTInsuranceOfferingView

- (instancetype)init
{
    self = [super init];
    [self createBackgroundView];
    [self buildAddInsuranceState];
    return self;
}

- (void)updateInsurance:(CTInsurance *)insurance
{
    _insurance = insurance;
    [self updateText];
}

- (void)updateText
{
    NSString *addNowText = [NSString stringWithFormat:CTLocalizedString(CTRentalInsuranceAddButtonTitle), self.insurance.premiumAmount.numberStringWithCurrencyCode];
    [self.addNowButton setTitle:addNowText forState:UIControlStateNormal];
}


- (void)createBackgroundView
{
    _backgroundView = [UIView new];
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundView.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:144.0/255.0 blue:228.0/255.0 alpha:1];
    [self addSubview:self.backgroundView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[backgroundView(0@100)]-0-|"
                                                                 options:0 metrics:nil
                                                                   views:@{@"backgroundView" : self.backgroundView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[backgroundView]-0-|"
                                                                 options:0 metrics:nil
                                                                   views:@{@"backgroundView" : self.backgroundView}]];
}

- (void)buildAddInsuranceState
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    _shieldImageView = [[UIImageView alloc] init];
    self.shieldImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.shieldImageView.translatesAutoresizingMaskIntoConstraints = NO;
    UIImage *shieldImage = [UIImage imageNamed:@"shield_offer" inBundle:bundle compatibleWithTraitCollection:nil];
    self.shieldImageView.image = shieldImage;
    [self.shieldImageView setHeightConstraint:@35 priority:@1000];
    
    _headerLabel = [CTLabel new];
    self.headerLabel.useBoldFont = YES;
    self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerLabel.text = @"Test header";
    self.headerLabel.numberOfLines = 1;
    self.headerLabel.textAlignment = NSTextAlignmentCenter;
    [self.headerLabel setHeightConstraint:@30 priority:@1000];

    _subheaderLabel = [CTLabel new];
    self.subheaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subheaderLabel.text = @"Test header";
    self.subheaderLabel.numberOfLines = 1;
    self.subheaderLabel.textAlignment = NSTextAlignmentCenter;
    [self.subheaderLabel setHeightConstraint:@30 priority:@1000];
    
    _moreDetailsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreDetailsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.moreDetailsButton setTitle:@"more info" forState:UIControlStateNormal];
    self.moreDetailsButton.backgroundColor = [UIColor redColor];
    [self.moreDetailsButton setHeightConstraint:@20 priority:@1000];

    
    UIView *detailContainer = [self detailContainer];

    
    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:self.backgroundView];
    layoutManager.orientation = CTLayoutManagerOrientationTopToBottom;
    layoutManager.justify = NO;
    
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.shieldImageView];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 0, 8) view:self.headerLabel];
    [layoutManager insertView:UIEdgeInsetsMake(0, 8, 8, 8) view:self.subheaderLabel];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:detailContainer];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.moreDetailsButton];

    [layoutManager layoutViews];
    
}

- (UIView *)detailContainer
{
    UIView *view = [UIView new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view setHeightConstraint:@50 priority:@100];
    
    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:view];
    layoutManager.orientation = CTLayoutManagerOrientationTopToBottom;
    layoutManager.justify = NO;
    
    [layoutManager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:[self imageAndTextView:@"checkmark" text:@"some small desc"]];
    [layoutManager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:[self imageAndTextView:@"checkmark" text:@"some small desc"]];
    [layoutManager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:[self imageAndTextView:@"checkmark" text:@"some small desc"]];

    [layoutManager layoutViews];
    
    return view;
}

- (UIView *)imageAndTextView:(NSString *)imageName text:(NSString *)text
{
    UIView *view = [UIView new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:view];
    layoutManager.orientation = CTLayoutManagerOrientationLeftToRight;
    layoutManager.justify = NO;
    
    UIImageView *imageView = [UIImageView new];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIImage *icon = [UIImage imageNamed:imageName
                               inBundle:bundle
          compatibleWithTraitCollection:nil];
    
    imageView.image = icon;
    
    [imageView setHeightConstraint:@25 priority:@1000];
    [imageView setWidthConstraint:@25 priority:@1000];
    
    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = text;
    [label setHeightConstraint:@25 priority:@1000];

    [layoutManager insertView:UIEdgeInsetsMake(4,4,4,4) view:imageView];
    [layoutManager insertView:UIEdgeInsetsMake(4,4,4,4) view:label];
    
    [layoutManager layoutViews];

    return view;
}



- (void)addInsurance:(id)sender
{
    if (self.addAction) {
        self.addAction();
    }
}

- (void)termsTapped:(id)sender
{
    if (self.termsAndConditionsAction) {
        self.termsAndConditionsAction();
    }
}

@end
