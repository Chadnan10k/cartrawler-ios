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
#import "CartrawlerSDK/CartrawlerSDK+UIImageView.h"

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
        
        NSArray *titles = availabilityItem.vendor.rating ? @[CTLocalizedString(CTRentalTitleDetailsVehicle), CTLocalizedString(CTRentalTitleDetailsSupplier)] : @[CTLocalizedString(CTRentalTitleDetailsVehicle)];
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
    NSString *title = CTLocalizedString(CTRentalVehiclePickupLocation);
    NSString *detail = [CTLocalisedStrings pickupType:item];
    return [self itemViewWithTitle:title detail:detail imageName:@"location_airport"];
}

- (CTListItemView *)fuelPolicyView:(CTAvailabilityItem *)item {
    NSString *title = CTLocalizedString(CTRentalVehicleFuelPolicy);
    NSString *detail = [CTLocalisedStrings fuelPolicy:item.vehicle.fuelPolicy];
    return [self itemViewWithTitle:title detail:detail imageName:@"vehicle_mileage"];
}

- (CTListItemView *)mileageAllowanceView:(CTAvailabilityItem *)item {
    NSString *title = CTLocalizedString(CTRentalMileageAllowance);
    NSString *detail = item.vehicle.rateDistance.isUnlimited ? CTLocalizedString(CTRentalMileageUnlimited) : CTLocalizedString(CTRentalMileageLimited);
    return [self itemViewWithTitle:title detail:detail imageName:@"vehicle_mileage"];
}

- (CTListItemView *)insuranceView:(CTAvailabilityItem *)item {
    NSString *title = CTLocalizedString(CTRentalInsuranceBasic);
    NSString *detail = CTLocalizedString(CTRentalInsuranceBasicDetail);
    return [self itemViewWithTitle:title detail:detail imageName:@"ins_shield"];
}

- (CTListItemView *)itemViewWithTitle:(NSString *)title detail:(NSString *)detail imageName:(NSString *)imageName {
    CTListItemView *itemView = [CTListItemView new];
    itemView.titleLabel.attributedText = [self attributedStringWithBlackText:title blueText:detail];
    itemView.imageView.image = [[UIImage imageNamed:imageName inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    itemView.imageView.tintColor = [UIColor colorWithRed:6.0/255.0 green:48.0/255.0 blue:133./255.0 alpha:1.0];
    return itemView;
}

// MARK: Ratings Tab

- (CTListView *)ratingsListView:(CTAvailabilityItem *)availabilityItem containerView:(UIView *)containerView {
    
//    CTListItemView *itemView = [self supplierIconItemView:availabilityItem];
    
//    CTExpandingView *expandingView = [[CTExpandingView alloc] initWithHeaderView:itemView animationContainerView:containerView];
    
    CTRatingView *overallRatingView = [self overallRatingView:availabilityItem];
    CTRatingView *valueRatingView = [self valueRatingView:availabilityItem];
    CTRatingView *cleanlinessRatingView = [self cleanlinessRatingView:availabilityItem];
    CTRatingView *serviceRatingView = [self serviceRatingView:availabilityItem];
    CTRatingView *pickupRatingView = [self pickupRatingView:availabilityItem];
    CTRatingView *dropoffRatingView = [self dropoffRatingView:availabilityItem];
    
    CTListView *listView = [[CTListView alloc] initWithViews:@[overallRatingView, valueRatingView, cleanlinessRatingView, serviceRatingView, pickupRatingView, dropoffRatingView] separatorColor:nil];
    listView.delegate = self;
    return listView;
}

- (CTListItemView *)supplierIconItemView:(CTAvailabilityItem *)item {
    CTListItemView *itemView = [CTListItemView new];
    itemView.titleLabel.text = CTLocalizedString(CTRentalVehicleProvided);
    [[CTImageCache sharedInstance] cachedImage:item.vendor.logoURL completion:^(UIImage *image) {
        itemView.imageView.image = image;
    }];
    itemView.imageAlignment = CTListItemImageAlignmentRight;
    return itemView;
}

- (CTRatingView *)overallRatingView:(CTAvailabilityItem *)item {
    CTRatingView *ratingView = [CTRatingView new];
    ratingView.titleLabel.text = CTLocalizedString(CTRentalRatingOverall);
    
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
        switch (index) {
            case 0:
                [self expandView:expandingView withText:[CTLocalisedStrings toolTipTextForPickupType:self.availabilityItem]];
                break;
            case 1:
                [self expandView:expandingView withText:[CTLocalisedStrings toolTipTextForFuelPolicy:self.availabilityItem.vehicle.fuelPolicy]];
                break;
            case 2:
                [self expandView:expandingView withRateDistance:self.availabilityItem.vehicle.rateDistance];
                break;
            case 3:
                [self expandView:expandingView withCoverages:self.availabilityItem.vehicle.pricedCoverages];
                break;
            default:
                break;
        }
    }
}

- (void)expandView:(CTExpandingView *)expandingView withText:(NSString *)text {
    CTLabel *label = [[CTLabel alloc] init:16
                                 textColor:[UIColor blackColor]
                             textAlignment:NSTextAlignmentLeft
                                  boldFont:NO];
    label.numberOfLines = 0;
    label.text = text;
    [expandingView expandWithDetailView:label];
}

- (void)expandView:(CTExpandingView *)expandingView withRateDistance:(CTRateDistance *)rateDistance {
    [self expandView:expandingView withText:[self textForRateDistance:rateDistance]];
}

- (NSString *)textForRateDistance:(CTRateDistance *)rateDistance {
    if (rateDistance.isUnlimited) {
        return CTLocalizedString(CTRentalMileageUnlimitedDetail);
    }
    
    NSString *mileageAmount = [NSString stringWithFormat:@"%@ %@ %@", rateDistance.quantity, rateDistance.distanceUnitName, rateDistance.vehiclePeriodUnitName];
        
    return [NSString stringWithFormat:CTLocalizedString(CTRentalMileageLimitedDetail), mileageAmount];
}

- (void)expandView:(CTExpandingView *)expandingView withCoverages:(NSArray *)coverages {
    NSMutableArray *items = [NSMutableArray new];
    for (CTPricedCoverage *coverage in coverages) {
        CTListItemView *listItemView = [CTListItemView new];
        listItemView.titleLabel.text = coverage.chargeDescription;
        listItemView.imageView.image = [[UIImage imageNamed:@"checkmark" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [listItemView.imageView applyTintWithColor:[CTAppearance instance].buttonColor];
        [items addObject:listItemView];
    }
    
    CTListView *listView = [[CTListView alloc] initWithViews:items.copy separatorColor:[UIColor clearColor]];
    [expandingView expandWithDetailView:listView];
}


- (NSAttributedString *)attributedStringWithBlackText:(NSString *)blackText blueText:(NSString *)blueText {
    NSDictionary *blackAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14.0],
                                      NSForegroundColorAttributeName : [UIColor blackColor]};
    NSDictionary *blueAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14.0],
                                     NSForegroundColorAttributeName : [UIColor colorWithRed:42.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0]};
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:blackText attributes:blackAttributes];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@":  "]];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:blueText attributes:blueAttributes]];
    
    return string.copy;
}

@end
