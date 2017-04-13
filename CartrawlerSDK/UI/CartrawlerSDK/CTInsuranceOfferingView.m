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
#import <CartrawlerSDK/CartrawlerSDK+UIImageView.h>

@interface CTInsuranceOfferingView()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) CTLabel *headerLabel;
@property (nonatomic, strong) CTLabel *subheaderLabel;
@property (nonatomic, strong) UIImageView *shieldImageView;
@property (nonatomic, strong) CTButton *addNowButton;
@property (nonatomic, strong) CTButton *moreDetailsButton;
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
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self addSubview:self.backgroundView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[backgroundView(0@100)]-8-|"
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
    
    _headerLabel = [[CTLabel alloc] init:17 textColor:[CTAppearance instance].iconTint textAlignment:NSTextAlignmentCenter boldFont:YES];
    self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerLabel.text = @"Upgrade Your Cover";
    self.headerLabel.numberOfLines = 1;

    _subheaderLabel = [[CTLabel alloc] init:14 textColor:[CTAppearance instance].iconTint textAlignment:NSTextAlignmentCenter boldFont:NO];
    self.subheaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subheaderLabel.text = @"Damage Refund Insurance";
    self.subheaderLabel.numberOfLines = 1;
    
    _moreDetailsButton = [[CTButton alloc] init:[UIColor clearColor] fontColor:[UIColor colorWithRed:32.0/255.0 green:145.0/255.0 blue:235.0/255.0 alpha:1] boldFont:NO borderColor:nil];
    self.moreDetailsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.moreDetailsButton setTitle:@"More details" forState:UIControlStateNormal];
    [self.moreDetailsButton setHeightConstraint:@20 priority:@1000];
    [self.moreDetailsButton addTarget:self action:@selector(termsTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.moreDetailsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    _addNowButton = [[CTButton alloc] init:[UIColor colorWithRed:32.0/255.0 green:145.0/255.0 blue:235.0/255.0 alpha:1] fontColor:[UIColor whiteColor] boldFont:YES borderColor:nil];
    self.addNowButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.addNowButton setHeightConstraint:@45 priority:@1000];
    [self.addNowButton addTarget:self action:@selector(addInsurance:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *detailContainer = [self detailContainer];
    UIView *priceContainer = [self logoAndPrice];

    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:self.backgroundView];
    layoutManager.orientation = CTLayoutManagerOrientationTopToBottom;
    layoutManager.justify = NO;
    
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.shieldImageView];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 0, 8) view:self.headerLabel];
    [layoutManager insertView:UIEdgeInsetsMake(0, 8, 16, 8) view:self.subheaderLabel];
    [layoutManager insertView:UIEdgeInsetsMake(16, 8, 24, 8) view:detailContainer];
    [layoutManager insertView:UIEdgeInsetsMake(24, 12, 32, 8) view:self.moreDetailsButton];
    [layoutManager insertView:UIEdgeInsetsMake(32, 8, 8, 8) view:priceContainer];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.addNowButton];

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
    
    [layoutManager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:[self imageAndTextView:@"checkmark" text:@"Full damage & theft excess refund"]];
    [layoutManager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:[self imageAndTextView:@"checkmark" text:@"Tyres, windows, mirrors & wheels"]];
    [layoutManager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:[self imageAndTextView:@"checkmark" text:@"Key cover & personal posessions"]];

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
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIImage *icon = [UIImage imageNamed:imageName
                               inBundle:bundle
          compatibleWithTraitCollection:nil];
    
    imageView.image = icon;
    
    [imageView setHeightConstraint:@15 priority:@100];
    [imageView setWidthConstraint:@15 priority:@1000];
    [imageView applyTintWithColor:[CTAppearance instance].iconTint];

    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = text;
    label.numberOfLines = 0;

    [layoutManager insertView:UIEdgeInsetsMake(0,4,0,16) view:imageView];
    [layoutManager insertView:UIEdgeInsetsMake(0,16,0,4) view:label];
    
    [layoutManager layoutViews];

    return view;
}

- (UIView *)logoAndPrice
{
    UIView *view = [UIView new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIImage *logo = [UIImage imageNamed:@"axa_logo"
                               inBundle:bundle
          compatibleWithTraitCollection:nil];
    
    UIImageView *imageView = [UIImageView new];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.image = logo;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setHeightConstraint:@40 priority:@1000];
    
    UIView *textContainer = [UIView new];
    textContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [textContainer setHeightConstraint:@40 priority:@1000];

    CTLabel *perDayLabel = [[CTLabel alloc] init:15 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentRight boldFont:YES];
    perDayLabel.translatesAutoresizingMaskIntoConstraints = NO;
    perDayLabel.text = @"$100.00 per day";
    
    CTLabel *totalLabel = [[CTLabel alloc] init:15 textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentRight boldFont:NO];
    totalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    totalLabel.text = @"Total $30.00";

    CTLayoutManager *priceManager = [CTLayoutManager layoutManagerWithContainer:textContainer];
    priceManager.orientation = CTLayoutManagerOrientationTopToBottom;
    priceManager.justify = YES;
    
    [priceManager insertView:UIEdgeInsetsMake(0,0,0,0) view:perDayLabel];
    [priceManager insertView:UIEdgeInsetsMake(0,0,0,0) view:totalLabel];

    [priceManager layoutViews];
    
    CTLayoutManager *manager = [CTLayoutManager layoutManagerWithContainer:view];
    manager.orientation = CTLayoutManagerOrientationLeftToRight;
    manager.justify = YES;
    
    [manager insertView:UIEdgeInsetsMake(0,0,0,0) view:imageView];
    [manager insertView:UIEdgeInsetsMake(0,0,0,0) view:textContainer];

    [manager layoutViews];
    
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
