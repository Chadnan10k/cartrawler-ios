//
//  CTVehicleDetailsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleDetailsViewController.h"
#import "CTVehicleDetailsView.h"
#import <CartrawlerSDK/CTHeaders.h>
#import "CTInsuranceView.h"

@interface CTVehicleDetailsViewController () <CTVehicleDetailsDelegate, CTInfoTipDelegate, CTInsuranceDelegate, CTListViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet CTNextButton *nextButton;
@property (strong, nonatomic) CTAlertViewController *alertView;
@property (strong, nonatomic) CTLayoutManager *layoutManager;

//Nested views
@property (nonatomic, strong) CTVehicleDetailsView *vehicleDetailsView;
@property (nonatomic, strong) CTInfoTip *vehicleInfoTip;
@property (nonatomic, strong) CTInfoTip *extrasInfoTip;
@property (nonatomic, strong) CTInsuranceView *insuranceView;

@end

@implementation CTVehicleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nextButton setText:@"Test Next"];
    
    _layoutManager = [CTLayoutManager layoutManagerWithContainer:self.containerView];
    
    [self initVehicleDetailsView];
    [self initVehicleDetailsInfoTip];
    [self initTabMenu];
    [self initInsuranceView];
    [self initAlertView];
      
    [self.layoutManager layoutViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.vehicleDetailsView setVehicle:self.search.selectedVehicle.vehicle
                             pickupDate:self.search.pickupDate
                            dropoffDate:self.search.dropoffDate];
    
    [self.insuranceView retrieveInsurance:self.cartrawlerAPI
                                   search:self.search];

}

/**
 View Creation
 */

//MARK: Alert View Init

- (void)initAlertView
{
    _alertView = [CTAlertViewController alertControllerWithTitle:@"Test" message:@"Test"];
    self.alertView.backgroundTapDismissalGestureEnabled = YES;
    
    [self.alertView addAction:[CTAlertAction actionWithTitle:@"Test OK" handler:^(CTAlertAction *action) {
        
    }]];
}


// MARK: Vehicle Details View Init
- (void)initVehicleDetailsView
{
    _vehicleDetailsView = [CTVehicleDetailsView new];
    self.vehicleDetailsView.delegate = self;
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 0, 8, 0) view:self.vehicleDetailsView];
}

// MARK: Vehicle Info Tip
- (void)initVehicleDetailsInfoTip
{
    _vehicleInfoTip = [[CTInfoTip alloc] initWithIcon:nil text:@"Good news. Free cancellation and amendments with your booking."];
    _vehicleInfoTip.delegate = self;
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.vehicleInfoTip];
}

// MARK: Tab Menu
- (void)initTabMenu {
    CTListItemView *itemView1 = [CTListItemView new];
    itemView1.titleLabel.attributedText = [self attributedStringWithBlackText:@"Pick-up location:  " blueText:@"In terminal"];
    itemView1.imageView.image = [UIImage imageNamed:@"location_airport" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    CTListItemView *itemView2 = [CTListItemView new];
    itemView2.titleLabel.attributedText = [self attributedStringWithBlackText:@"Fuel policy:  " blueText:@"Full to full"];
    itemView2.imageView.image = [UIImage imageNamed:@"fuel" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    
    CTExpandingView *expandingView1 = [[CTExpandingView alloc] initWithHeaderView:itemView1 animationContainerView:self.view];
    CTExpandingView *expandingView2 = [[CTExpandingView alloc] initWithHeaderView:itemView2 animationContainerView:self.view];
    
    CTListView *listView1 = [[CTListView alloc] initWithViews:@[expandingView1, expandingView2] separatorColor:nil];
    listView1.delegate = self;
    listView1.tag = 1;
    
    UIImage *icon2 = [UIImage imageNamed:@"vendor_europcar"
                                inBundle:[NSBundle bundleForClass:self.class]
           compatibleWithTraitCollection:nil];
    CTListItemView *itemView3 = [CTListItemView new];
    itemView3.titleLabel.text = @"Car provided by";
    itemView3.imageView.image = icon2;
    itemView3.imageAlignment = CTListItemImageAlignmentRight;
    
    CTExpandingView *expandingView3 = [[CTExpandingView alloc] initWithHeaderView:itemView3 animationContainerView:self.view];
    
    CTRatingView *ratingView1 = [CTRatingView new];
    ratingView1.titleLabel.text = @"Overall rating";
    ratingView1.ratingLabel.text = @"Excellent 8.0";
    
    CTRatingView *ratingView2 = [CTRatingView new];
    ratingView2.titleLabel.text = @"Value for money rating";
    ratingView2.ratingLabel.text = @"7.8";
    
    CTRatingView *ratingView3 = [CTRatingView new];
    ratingView3.titleLabel.text = @"Cleanliness of car";
    ratingView3.ratingLabel.text = @"9.0";
    
    CTRatingView *ratingView4 = [CTRatingView new];
    ratingView4.titleLabel.text = @"Service at desk";
    ratingView4.ratingLabel.text = @"7.7";
    
    CTRatingView *ratingView5 = [CTRatingView new];
    ratingView5.titleLabel.text = @"Pick-up process";
    ratingView5.ratingLabel.text = @"6.9";
    
    CTListView *listView2 = [[CTListView alloc] initWithViews:@[expandingView3, ratingView1, ratingView2, ratingView3, ratingView4, ratingView5] separatorColor:nil];
    listView2.delegate = self;
    listView2.tag = 2;
    
    CTTabContainerView *tabContainerView = [[CTTabContainerView alloc] initWithTabTitles:@[@"INCLUDED", @"RATINGS"] views:@[listView1, listView2] selectedIndex:0];
    tabContainerView.animationContainerView = self.view;
    
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 0, 8, 0) view:tabContainerView];
}

- (NSAttributedString *)attributedStringWithBlackText:(NSString *)blackText blueText:(NSString *)blueText {
    NSDictionary *blackAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0],
                                      NSForegroundColorAttributeName : [UIColor blackColor]};
    NSDictionary *blueAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0],
                                     NSForegroundColorAttributeName : [UIColor colorWithRed:42.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0]};
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:blackText attributes:blackAttributes];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:blueText attributes:blueAttributes]];
    
    return string.copy;
}

// MARK: Insurance View
- (void)initInsuranceView
{
    _insuranceView = [CTInsuranceView new];
    self.insuranceView.delegate = self;
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 0, 8, 0) view:self.insuranceView];
}


/**
 View Delegates
 */

// MARK: CTVehicleDetailsDelegate
- (void)didTapMoreDetailsView
{
    [self presentViewController:self.alertView animated:YES completion:nil];
}

// MARK: CTInfoTipDelegate
- (void)infoTipWasTapped:(CTInfoTip *)infoTip
{
    if (infoTip == self.extrasInfoTip) {
        [self.navigationController pushViewController:self.optionalRoute animated:YES];
    }
}

// MARK: CTInsurance Delegate
- (void)didAddInsurance:(CTInsurance *)insurance
{
    self.search.insurance = insurance;
    self.search.isBuyingInsurance = YES;
}

- (void)didRemoveInsurance
{
    self.search.insurance = nil;
    self.search.isBuyingInsurance = NO;
}

// MARK: CTListView Delegate

- (void)listView:(CTListView *)listView didSelectView:(CTExpandingView *)expandingView atIndex:(NSInteger)index  {
    if (![expandingView isKindOfClass:CTExpandingView.class]) {
        return;
    }
    
    if (expandingView.expanded) {
        [expandingView contract];
        return;
    }
    
    if (listView.tag == 1) {
        CTListItemView *listItemView1 = [CTListItemView new];
        listItemView1.titleLabel.text = @"Third party liability";
        listItemView1.imageView.image = [[UIImage imageNamed:@"checkmark" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        CTListItemView *listItemView2 = [CTListItemView new];
        listItemView2.titleLabel.text = @"Theft protection";
        listItemView2.imageView.image = [[UIImage imageNamed:@"checkmark" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        CTListItemView *listItemView3 = [CTListItemView new];
        listItemView3.titleLabel.text = @"Collision damage waiver";
        listItemView3.imageView.image = [[UIImage imageNamed:@"checkmark" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        CTListView *listView = [[CTListView alloc] initWithViews:@[listItemView1, listItemView2, listItemView3] separatorColor:[UIColor clearColor]];
        [expandingView expandWithDetailView:listView];
    }
    
    if (listView.tag == 2) {
        CTLabel *label = [[CTLabel alloc] init:16
                                     textColor:[UIColor blackColor]
                                 textAlignment:NSTextAlignmentLeft
                                      boldFont:NO];
        label.numberOfLines = 0;
        label.text = @"Europcar is one of the worlds leading car rental companies that offer innovative services and quality in a simple and transparent way.";
        [expandingView expandWithDetailView:label];
    }
    
}

- (void)didTapTermsAndConditions:(NSURL *)termsURL
{
    
}

// MARK: Actions
- (IBAction)backTapped:(id)sender
{
    if (self.navigationController.viewControllers.firstObject == self) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)nextTapped:(id)sender
{
    if (self.destinationViewController) {
        [self pushToDestination];
    } else {
        [self dismiss];
    }
}


@end
