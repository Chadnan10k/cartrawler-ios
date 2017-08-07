//
//  CTSelectedVehicleInsuranceViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleInsuranceViewModel.h"
#import "CartrawlerSDK+NSNumber.h"
// TODO: Remove all app state imports from view model, moving to protocol

@interface CTSelectedVehicleInsuranceViewModel ()
@property (nonatomic, readwrite) BOOL insuranceAdded;
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *infoTip1;
@property (nonatomic, readwrite) NSString *infoTip2;
@property (nonatomic, readwrite) NSString *infoTip3;
@property (nonatomic, readwrite) NSString *detailsTitle;
@property (nonatomic, readwrite) NSString *imageTitle;
@property (nonatomic, readwrite) NSString *pricePerDay;
@property (nonatomic, readwrite) NSString *total;
@property (nonatomic, readwrite) NSString *addInsurance;
@end

@implementation CTSelectedVehicleInsuranceViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSelectedVehicleInsuranceViewModel *viewModel = [CTSelectedVehicleInsuranceViewModel new];
    CTSearchState *searchState = appState.searchState;
    CTSelectedVehicleState *state = appState.selectedVehicleState;
    CTInsurance *insurance = state.insurance;
    
    if (!insurance) {
        return viewModel;
    }
    viewModel.insuranceAdded = YES;
    viewModel.title = CTLocalizedString(CTRentalInsuranceOfferingHeader);
    viewModel.infoTip1 = CTLocalizedString(CTRentalInsuranceInfoTip1);
    viewModel.infoTip2 = CTLocalizedString(CTRentalInsuranceInfoTip2);
    viewModel.infoTip3 = CTLocalizedString(CTRentalInsuranceInfoTip3);
    viewModel.detailsTitle = CTLocalizedString(CTRentalInsuranceInfoButtonTitle);
    viewModel.imageTitle = @"axa";
    viewModel.pricePerDay = [self pricePerDay:insurance state:searchState];
    viewModel.total = [self total:insurance];
    viewModel.addInsurance = CTLocalizedString(CTRentalInsuranceAddButtonTitle);
    
    return viewModel;
}

+ (NSString *)pricePerDay:(CTInsurance *)insurance state:(CTSearchState *)searchState {
    return [NSString stringWithFormat:@"%@ %@", [insurance.premiumAmount pricePerDay:searchState.selectedPickupDate dropoff:searchState.selectedDropoffDate], CTLocalizedString(CTRentalInsurancePerDay)];
}

+ (NSString *)total:(CTInsurance *)insurance {
    return [NSString stringWithFormat:CTLocalizedString(CTRentalInsuranceTotal), [insurance.premiumAmount numberStringWithCurrencyCode]];
}

@end
