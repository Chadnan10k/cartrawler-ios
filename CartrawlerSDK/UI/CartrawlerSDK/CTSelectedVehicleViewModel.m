//
//  CTSelectedVehicleViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleViewModel.h"
#import "CartrawlerSDK+NSNumber.h"

@interface CTSelectedVehicleViewModel ()
@property (nonatomic, readwrite) UIColor *navigationBarColor;
@property (nonatomic, readwrite) BOOL showPaymentSummary;
@property (nonatomic, readwrite) NSString *total;
@property (nonatomic, readwrite) NSString *totalAmount;
@property (nonatomic, readwrite) BOOL showToastView;
@property (nonatomic, readwrite) NSString *toast;
@property (nonatomic, readwrite) NSString *toastOK;
@property (nonatomic, readwrite) CTPaymentSummaryViewModel *paymentSummaryViewModel;
@property (nonatomic, readwrite) CTSelectedVehicleInfoViewModel *selectedVehicleInfoViewModel;
@property (nonatomic, readwrite) CTSelectedVehicleTabViewModel *selectedVehicleTabViewModel;
@property (nonatomic, readwrite) CTSelectedVehicleInsuranceViewModel *selectedVehicleInsuranceViewModel;
@property (nonatomic, readwrite) CTSelectedVehicleExtrasViewModel *selectedVehicleExtrasViewModel;
@property (nonatomic, readwrite) UIColor *buttonColor;
@end
@implementation CTSelectedVehicleViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSelectedVehicleViewModel *viewModel = [CTSelectedVehicleViewModel new];
    viewModel.totalAmount = [self totalPrice:appState];
    viewModel.showPaymentSummary = appState.selectedVehicleState.showPaymentSummary;
    viewModel.navigationBarColor = appState.userSettingsState.primaryColor;
    viewModel.showToastView = appState.selectedVehicleState.showToastView;
    viewModel.toast = @"Your total includes extras, but you will pay for them when you pick-up your car.";
    viewModel.toastOK = CTLocalizedString(CTRentalErrorOk);
    viewModel.paymentSummaryViewModel = [CTPaymentSummaryViewModel viewModelForState:appState];
    viewModel.selectedVehicleInfoViewModel = [CTSelectedVehicleInfoViewModel viewModelForState:appState];
    viewModel.selectedVehicleTabViewModel = [CTSelectedVehicleTabViewModel viewModelForState:appState];
    viewModel.selectedVehicleInsuranceViewModel = [CTSelectedVehicleInsuranceViewModel viewModelForState:appState];
    viewModel.selectedVehicleExtrasViewModel = [CTSelectedVehicleExtrasViewModel viewModelForState:appState];
    viewModel.buttonColor = appState.userSettingsState.secondaryColor;
    return viewModel;
}

// TODO: Extract calculation logic, repeated elsewhere
// TODO: Specify parameters, not state
+ (NSString *)totalPrice:(CTAppState *)appState {
    if (appState.selectedVehicleState.insuranceAdded) {
        return [[NSNumber numberWithFloat:appState.selectedVehicleState.selectedAvailabilityItem.vehicle.totalPriceForThisVehicle.floatValue + appState.selectedVehicleState.insurance.premiumAmount.floatValue] numberStringWithCurrencyCode];
    } else {
        return [appState.selectedVehicleState.selectedAvailabilityItem.vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode];
    }
}

@end
