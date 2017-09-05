//
//  CTSelectedVehicleRatingsViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleRatingsViewModel.h"

@interface CTSelectedVehicleRatingsViewModel ()
@property (nonatomic, readwrite) NSString *providedBy;
@property (nonatomic, readwrite) NSString *overall;
@property (nonatomic, readwrite) NSString *valueForMoney;
@property (nonatomic, readwrite) NSString *cleanliness;
@property (nonatomic, readwrite) NSString *service;
@property (nonatomic, readwrite) NSString *pickupProcess;
@property (nonatomic, readwrite) NSString *dropoffProcess;
@property (nonatomic, readwrite) NSString *averageWaitingTime;
@property (nonatomic, readwrite) NSString *customerRatings;

@property (nonatomic, readwrite) NSURL *providedByImage;
@property (nonatomic, readwrite) NSString *overallRating;
@property (nonatomic, readwrite) NSString *valueForMoneyRating;
@property (nonatomic, readwrite) NSString *cleanlinessRating;
@property (nonatomic, readwrite) NSString *serviceRating;
@property (nonatomic, readwrite) NSString *pickupProcessRating;
@property (nonatomic, readwrite) NSString *dropoffProcessRating;
@property (nonatomic, readwrite) NSString *averageWaitingTimeRating;
@end

@implementation CTSelectedVehicleRatingsViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    CTAvailabilityItem *item = selectedVehicleState.selectedAvailabilityItem;
    
    CTSelectedVehicleRatingsViewModel *viewModel = [CTSelectedVehicleRatingsViewModel new];
    viewModel.providedBy = CTLocalizedString(CTRentalVehicleProvided);
    viewModel.overall = CTLocalizedString(CTRentalRatingOverall);
    viewModel.valueForMoney = CTLocalizedString(CTRentalSupplierPrice);
    viewModel.cleanliness = CTLocalizedString(CTRentalSupplierCar);
    viewModel.service = CTLocalizedString(CTRentalSupplierDesk);
    viewModel.pickupProcess = CTLocalizedString(CTRentalSupplierPickup);
    viewModel.dropoffProcess = CTLocalizedString(CTRentalSupplierDropoff);
    viewModel.averageWaitingTime = @"Average waiting time";
    viewModel.customerRatings = [NSString stringWithFormat:@"Based on %@ customer ratings", item.vendor.rating.totalReviews];
    
    viewModel.providedByImage = item.vendor.logoURL;
    viewModel.overallRating = [self overallRating:item];
    viewModel.valueForMoneyRating = [self ratingToString:item.vendor.rating.priceScore];
    viewModel.cleanlinessRating = [self ratingToString:item.vendor.rating.carReview];
    viewModel.serviceRating = [self ratingToString:item.vendor.rating.deskReview];
    viewModel.pickupProcessRating = [self ratingToString:item.vendor.rating.pickupScore];
    viewModel.dropoffProcessRating = [self ratingToString:item.vendor.rating.dropoffReview];
    viewModel.averageWaitingTimeRating = [NSString stringWithFormat:@"%@ mins", item.vendor.rating.averageWaitTime];
    return viewModel;
}

+ (NSString *)overallRating:(CTAvailabilityItem *)item {
    double adjustedRating = item.vendor.rating.overallScore.floatValue * 2;
    NSString *ratingType;
    if (adjustedRating < 5) {
        ratingType = CTLocalizedString(CTRentalSupplierBelowAverage);
    } else if (adjustedRating < 7)  {
        ratingType = CTLocalizedString(CTRentalSupplierGood);
    } else {
        ratingType = CTLocalizedString(CTRentalSupplierExcellent);
    }
    return [NSString stringWithFormat:@"%@  %.1f", ratingType, adjustedRating];
}

+ (NSString *)ratingToString:(NSNumber *)rating {
    return [NSString stringWithFormat:@"%.1f", rating.doubleValue/10];
}

@end
