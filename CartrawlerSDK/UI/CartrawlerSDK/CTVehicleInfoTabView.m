//
//  CTVehicleInfoTabView.m
//  CartrawlerRental
//
//  Created by Alan on 04/05/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleInfoTabView.h"
#import <CartrawlerSDK/CTHeaders.h>
#import "CTRentalLocalizationConstants.h"

@interface CTVehicleInfoTabView () <CTListViewDelegate>
@property (nonatomic, strong) CTAvailabilityItem *availabilityItem;
@property (nonatomic, strong) CTListView *includedListView;
@property (nonatomic, strong) CTListView *ratingsListView;
@end

@implementation CTVehicleInfoTabView

- (instancetype)initWithAvailabilityItem:(CTAvailabilityItem *)availabilityItem containerView:(UIView *)containerView {
    self = [super init];
    if (self) {
        self.availabilityItem = availabilityItem;
        
        self.includedListView = [self includedListView:availabilityItem containerView:containerView];
        self.ratingsListView = [self ratingsListView:availabilityItem containerView:containerView];
        
        NSArray *titles = availabilityItem.vendor.rating ? @[@"INCLUDED", @"RATINGS"] : @[@"INCLUDED"];
        NSArray *views = availabilityItem.vendor.rating ? @[self.includedListView, self.ratingsListView] : @[self.includedListView];
        
        CTTabContainerView *tabContainerView = [[CTTabContainerView alloc] initWithTabTitles:titles
                                                                                       views:views
                                                                               selectedIndex:0];
        tabContainerView.animationContainerView = containerView;
        [self addSubview:tabContainerView];
        [CTLayoutManager pinView:tabContainerView toSuperView:self];
    }
    return self;
}

// MARK: Included Tab

- (CTListView *)includedListView:(CTAvailabilityItem *)availabilityItem containerView:(UIView *)containerView {
    CTListItemView *pickUpTypeHeaderView = [self pickUpTypeView:availabilityItem];
    CTExpandingView *pickUpTypeExpandingView = [[CTExpandingView alloc] initWithHeaderView:pickUpTypeHeaderView animationContainerView:containerView];
    
    CTListItemView *fuelPolicyHeaderView = [self fuelPolicyView:availabilityItem];
    CTExpandingView *fuelPolicyExpandingView = [[CTExpandingView alloc] initWithHeaderView:fuelPolicyHeaderView animationContainerView:containerView];
    
    CTListItemView *mileageAllowanceHeaderView = [self mileageAllowanceView:availabilityItem];
    CTExpandingView *mileageAllowanceExpandingView = [[CTExpandingView alloc] initWithHeaderView:mileageAllowanceHeaderView animationContainerView:containerView];
    
    CTListItemView *insuranceHeaderView = [self insuranceView:availabilityItem];
    CTExpandingView *insuranceExpandingView = [[CTExpandingView alloc] initWithHeaderView:insuranceHeaderView animationContainerView:containerView];
    
    CTListView *listView = [[CTListView alloc] initWithViews:@[pickUpTypeExpandingView, fuelPolicyExpandingView, mileageAllowanceExpandingView, insuranceExpandingView] separatorColor:nil];
    listView.delegate = self;
    
    return listView;
}

- (CTListItemView *)pickUpTypeView:(CTAvailabilityItem *)item {
    CTListItemView *itemView = [CTListItemView new];
    NSString *title = @"Pick-up location:";
    NSString *detail = [CTLocalisedStrings pickupType:item];
    itemView.titleLabel.attributedText = [self attributedStringWithBlackText:title blueText:detail];
    itemView.imageView.image = [UIImage imageNamed:@"location_airport" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    return itemView;
}

- (CTListItemView *)fuelPolicyView:(CTAvailabilityItem *)item {
    CTListItemView *itemView = [CTListItemView new];
    NSString *title = @"Fuel policy:";
    NSString *detail = [CTLocalisedStrings fuelPolicy:item.vehicle.fuelPolicy];
    itemView.titleLabel.attributedText = [self attributedStringWithBlackText:title blueText:detail];
    itemView.imageView.image = [UIImage imageNamed:@"location_airport" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    return itemView;
}

- (CTListItemView *)mileageAllowanceView:(CTAvailabilityItem *)item {
    CTListItemView *itemView = [CTListItemView new];
    NSString *title = @"Mileage Allowance:";
    NSString *detail = @"";
    for (CTVehicleCharge *charge in item.vehicle.vehicleCharges) {
        if ([charge.chargePurpose isEqualToString:@"618.VCP.X"]) {
            detail = @"Limited mileage";
        }
        if ([charge.chargePurpose isEqualToString:@"609.VCP.X"]) {
            detail = @"Unlimited";
        }
    }
    itemView.titleLabel.attributedText = [self attributedStringWithBlackText:title blueText:detail];
    itemView.imageView.image = [UIImage imageNamed:@"location_airport" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    return itemView;
}

- (CTListItemView *)insuranceView:(CTAvailabilityItem *)item {
    CTListItemView *itemView = [CTListItemView new];
    NSString *title = @"Insurance:";
    NSString *detail = @"Basic Cover";
    itemView.titleLabel.attributedText = [self attributedStringWithBlackText:title blueText:detail];
    itemView.imageView.image = [UIImage imageNamed:@"location_airport" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    return itemView;
}

// MARK: Ratings Tab

- (CTListView *)ratingsListView:(CTAvailabilityItem *)availabilityItem containerView:(UIView *)containerView {
    CTListItemView *itemView3 = [self supplierIconItemView:availabilityItem];
    CTExpandingView *expandingView3 = [[CTExpandingView alloc] initWithHeaderView:itemView3 animationContainerView:containerView];
    CTRatingView *overallRatingView = [self overallRatingView:availabilityItem];
    CTRatingView *valueRatingView = [self valueRatingView:availabilityItem];
    CTRatingView *cleanlinessRatingView = [self cleanlinessRatingView:availabilityItem];
    CTRatingView *serviceRatingView = [self serviceRatingView:availabilityItem];
    CTRatingView *pickupRatingView = [self pickupRatingView:availabilityItem];
    CTRatingView *dropoffRatingView = [self dropoffRatingView:availabilityItem];
    
    CTListView *listView = [[CTListView alloc] initWithViews:@[expandingView3, overallRatingView, valueRatingView, cleanlinessRatingView, serviceRatingView, pickupRatingView, dropoffRatingView] separatorColor:nil];
    listView.delegate = self;
    return listView;
}

- (CTListItemView *)supplierIconItemView:(CTAvailabilityItem *)item {
    UIImage *icon2 = [UIImage imageNamed:@"vendor_europcar"
                                inBundle:[NSBundle bundleForClass:self.class]
           compatibleWithTraitCollection:nil];
    CTListItemView *itemView = [CTListItemView new];
    itemView.titleLabel.text = @"Car provided by";
    itemView.imageView.image = icon2;
    itemView.imageAlignment = CTListItemImageAlignmentRight;
    return itemView;
}

- (CTRatingView *)overallRatingView:(CTAvailabilityItem *)item {
    CTRatingView *ratingView = [CTRatingView new];
    ratingView.titleLabel.text = @"Overall rating";
    
    double adjustedRating = item.vendor.rating.overallScore.floatValue * 2;
    NSString *ratingType;
    if (adjustedRating < 5) {
        ratingType = CTLocalizedString(CTRentalSupplierBelowAverage);
    } else if (adjustedRating < 7)  {
        ratingType = CTLocalizedString(CTRentalSupplierGood);
    } else {
        ratingType = CTLocalizedString(CTRentalSupplierExcellent);
    }
    ratingView.ratingLabel.text = [NSString stringWithFormat:@"%@  %.1f", ratingType, adjustedRating];

    return ratingView;
}

- (CTRatingView *)valueRatingView:(CTAvailabilityItem *)item {
    CTRatingView *ratingView = [CTRatingView new];
    ratingView.titleLabel.text = CTLocalizedString(CTRentalSupplierPrice);
    ratingView.ratingLabel.text = [NSString stringWithFormat:@"%.1f",
                                   item.vendor.rating.priceScore.doubleValue/10];
    return ratingView;
}

- (CTRatingView *)cleanlinessRatingView:(CTAvailabilityItem *)item {
    CTRatingView *ratingView = [CTRatingView new];
    ratingView.titleLabel.text = CTLocalizedString(CTRentalSupplierCar);
    ratingView.ratingLabel.text = [NSString stringWithFormat:@"%.1f",
                                   item.vendor.rating.carReview.doubleValue/10];
    return ratingView;
}

- (CTRatingView *)serviceRatingView:(CTAvailabilityItem *)item {
    CTRatingView *ratingView = [CTRatingView new];
    ratingView.titleLabel.text = CTLocalizedString(CTRentalSupplierDesk);
    ratingView.ratingLabel.text = [NSString stringWithFormat:@"%.1f",
                                   item.vendor.rating.deskReview.doubleValue/10];
    return ratingView;
}

- (CTRatingView *)pickupRatingView:(CTAvailabilityItem *)item {
    CTRatingView *ratingView = [CTRatingView new];
    ratingView.titleLabel.text = CTLocalizedString(CTRentalSupplierPickup);
    ratingView.ratingLabel.text = [NSString stringWithFormat:@"%.1f",
                                   item.vendor.rating.pickupScore.doubleValue/10];
    return ratingView;
}

- (CTRatingView *)dropoffRatingView:(CTAvailabilityItem *)item {
    CTRatingView *ratingView = [CTRatingView new];
    ratingView.titleLabel.text = CTLocalizedString(CTRentalSupplierDropoff);
    ratingView.ratingLabel.text = [NSString stringWithFormat:@"%.1f",
                                   item.vendor.rating.dropoffReview.doubleValue/10];
    return ratingView;
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
    
    if ([listView isEqual:self.includedListView]) {
        NSMutableArray *items = [NSMutableArray new];
        for (CTPricedCoverage *coverage in self.availabilityItem.vehicle.pricedCoverages) {
            CTListItemView *listItemView = [CTListItemView new];
            listItemView.titleLabel.text = coverage.chargeDescription;
            listItemView.imageView.image = [[UIImage imageNamed:@"checkmark" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [items addObject:listItemView];
        }
        
        CTListView *listView = [[CTListView alloc] initWithViews:items.copy separatorColor:[UIColor clearColor]];
        [expandingView expandWithDetailView:listView];
    }
    
    if ([listView isEqual:self.ratingsListView]) {
        CTLabel *label = [[CTLabel alloc] init:16
                                     textColor:[UIColor blackColor]
                                 textAlignment:NSTextAlignmentLeft
                                      boldFont:NO];
        label.numberOfLines = 0;
        label.text = @"Europcar is one of the worlds leading car rental companies that offer innovative services and quality in a simple and transparent way.";
        [expandingView expandWithDetailView:label];
    }
}


- (NSAttributedString *)attributedStringWithBlackText:(NSString *)blackText blueText:(NSString *)blueText {
    NSDictionary *blackAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0],
                                      NSForegroundColorAttributeName : [UIColor blackColor]};
    NSDictionary *blueAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0],
                                     NSForegroundColorAttributeName : [UIColor colorWithRed:42.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0]};
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:blackText attributes:blackAttributes];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"  "]];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:blueText attributes:blueAttributes]];
    
    return string.copy;
}

@end
