//
//  CTExtrasViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInsuranceDetailViewController.h"
#import "CartrawlerSDK/CTLayoutManager.h"
#import "CartrawlerSDK/CartrawlerSDK+UIView.h"
#import "CartrawlerSDK/CartrawlerSDK+UIImageView.h"
#import "CartrawlerSDK/CartrawlerSDK+NSNumber.h"
#import "CartrawlerSDK/CTAppearance.h"
#import "CartrawlerSDK/CTLabel.h"
#import "CartrawlerSDK/CTButton.h"
#import "CartrawlerSDK/CTAlertViewController.h"
#import "CartrawlerSDK/CTNextButton.h"
#import "CartrawlerSDK/CTLocalisedStrings.h"
#import "CTRentalLocalizationConstants.h"

@interface CTInsuranceDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet CTNextButton *addButton;

@end

@implementation CTInsuranceDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.addButton setText:@"Add"];
    
    UIView *logoPrice = [self logoAndPriceView];
    UIView *informationView = [self informationView];
    UIView *whatsCoveredView = [self whatsCoveredView];
    UIButton *termsButton = [self termsButton];

    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:self.containerView];
    
    [layoutManager insertView:UIEdgeInsetsZero view:logoPrice];
    [layoutManager insertView:UIEdgeInsetsZero view:informationView];
    [layoutManager insertView:UIEdgeInsetsMake(0, 0, 16, 0) view:whatsCoveredView];
    [layoutManager insertView:UIEdgeInsetsMake(16, 0, 16, 0) view:termsButton];

    [layoutManager layoutViews];
    
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
    
    CTLabel *label = [[CTLabel alloc] init:14 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft boldFont:NO];
    label.text = text;
    label.numberOfLines = 0;
    
    [layoutManager insertView:UIEdgeInsetsMake(0,4,0,16) view:imageView];
    [layoutManager insertView:UIEdgeInsetsMake(0,16,0,4) view:label];
    
    [layoutManager layoutViews];
    
    return view;
}

- (UIView *)logoAndPriceView
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
    
    CTLabel *totalLabel = [[CTLabel alloc] init:15 textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentRight boldFont:NO];
    totalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString *pricePerDay = [NSString stringWithFormat:@"%@ %@", [self.search.insurance.premiumAmount pricePerDay:self.search.pickupDate dropoff:self.search.dropoffDate], CTLocalizedString(CTRentalInsurancePerDay)];
    perDayLabel.text = pricePerDay;
    
    NSString *total = [NSString stringWithFormat:CTLocalizedString(CTRentalInsuranceTotal), [self.search.insurance.premiumAmount numberStringWithCurrencyCode]];
    totalLabel.text = total;
    
    CTLayoutManager *priceManager = [CTLayoutManager layoutManagerWithContainer:textContainer];
    priceManager.orientation = CTLayoutManagerOrientationTopToBottom;
    priceManager.justify = YES;
    
    [priceManager insertView:UIEdgeInsetsZero view:perDayLabel];
    [priceManager insertView:UIEdgeInsetsZero view:totalLabel];
    
    [priceManager layoutViews];
    
    CTLayoutManager *manager = [CTLayoutManager layoutManagerWithContainer:view];
    manager.orientation = CTLayoutManagerOrientationLeftToRight;
    manager.justify = YES;
    
    [manager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:imageView];
    [manager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:textContainer];
    
    [manager layoutViews];
    
    return view;
}

- (UIView *)informationView
{
    UIView *view = [UIView new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    CTLabel *reduceLabel = [[CTLabel alloc] init:17 textColor:[CTAppearance instance].navigationBarColor textAlignment:NSTextAlignmentLeft boldFont:YES];
    [reduceLabel setHeightConstraint:@30 priority:@1000];
    reduceLabel.numberOfLines = 0;
    reduceLabel.text = CTLocalizedString(CTRentalInsuranceDetailInfoTitle);
    
    CTLabel *infoTextView = [[CTLabel alloc] init:14 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft boldFont:NO];
    infoTextView.numberOfLines = 0;
    infoTextView.text = CTLocalizedString(CTRentalInsuranceDetailInfo);
    
    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:view];
    layoutManager.justify = NO;
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:reduceLabel];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:infoTextView];

    [layoutManager layoutViews];
    
    return view;
}

- (UIView *)whatsCoveredView
{
    UIView *view = [UIView new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    CTLabel *reduceLabel = [[CTLabel alloc] init:17 textColor:[CTAppearance instance].navigationBarColor textAlignment:NSTextAlignmentLeft boldFont:YES];
    reduceLabel.text = CTLocalizedString(CTRentalInsuranceDetailTipTitle);
    
    UIView *infoOne = [self imageAndTextView:@"checkmark" text:CTLocalizedString(CTRentalInsuranceDetailTip1)];
    UIView *infoTwo = [self imageAndTextView:@"checkmark" text:CTLocalizedString(CTRentalInsuranceDetailTip2)];
    UIView *infoThree = [self imageAndTextView:@"checkmark" text:CTLocalizedString(CTRentalInsuranceDetailTip3)];
    UIView *infoFour = [self imageAndTextView:@"checkmark" text:CTLocalizedString(CTRentalInsuranceDetailTip4)];
    UIView *infoFive = [self imageAndTextView:@"checkmark" text:CTLocalizedString(CTRentalInsuranceDetailTip5)];

    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:view];
    
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:reduceLabel];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:infoOne];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:infoTwo];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:infoThree];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:infoFour];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:infoFive];

    [layoutManager layoutViews];
    
    return view;
}

- (UIButton *)termsButton
{
    CTButton *button = [[CTButton alloc] init:[UIColor clearColor]
                                    fontColor:[CTAppearance instance].navigationBarColor
                                     boldFont:NO
                                  borderColor:nil];
    [button setTitle:CTLocalizedString(CTRentalInsuranceTermsConditions) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(termsTapped:) forControlEvents:UIControlEventTouchUpInside];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    return button;
}

- (void)termsTapped:(id)sender
{
    [[UIApplication sharedApplication] openURL:self.search.insurance.termsAndConditionsURL];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//MARK: mark Analytics

- (void)tagScreen
{
//    [[CTAnalytics instance] tagScreen:@"step" detail:@"vehicles-e" step:@4];
//    [[CTAnalytics instance] tagScreen:@"ins_offer" detail:@"yes" step:@4];
//    [self sendEvent:NO customParams:@{@"eventName" : @"Insurance & Extras Step",
//                                      @"stepName" : @"Step4",
//                                      @"insuranceOffered" : @"true"
//                                      } eventName:@"Step of search" eventType:@"Step"];
}

@end
