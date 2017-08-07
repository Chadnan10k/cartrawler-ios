//
//  CTSelectedVehicleIncludedViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleIncludedViewModel.h"

@interface CTSelectedVehicleIncludedViewModel ()
@property (nonatomic, readwrite) BOOL displayInsuranceView;

@property (nonatomic, readwrite) NSString *pickupLocation;
@property (nonatomic, readwrite) NSString *fuelPolicy;
@property (nonatomic, readwrite) NSString *mileageAllowance;
@property (nonatomic, readwrite) NSString *insurance;
@property (nonatomic, readwrite) NSString *important;

@property (nonatomic, readwrite) NSString *pickupLocationDetail;
@property (nonatomic, readwrite) NSString *fuelPolicyDetail;
@property (nonatomic, readwrite) NSString *mileageAllowanceDetail;
@property (nonatomic, readwrite) NSString *insuranceDetail;
@property (nonatomic, readwrite) NSString *importantDetail;

@property (nonatomic, readwrite) BOOL pickupLocationExpanded;
@property (nonatomic, readwrite) BOOL fuelPolicyExpanded;
@property (nonatomic, readwrite) BOOL mileageAllowanceExpanded;
@property (nonatomic, readwrite) BOOL insuranceExpanded;
@property (nonatomic, readwrite) BOOL insuranceAdded;
@end

@implementation CTSelectedVehicleIncludedViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSelectedVehicleIncludedViewModel *viewModel = [CTSelectedVehicleIncludedViewModel new];
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    CTAvailabilityItem *availabilityItem = selectedVehicleState.selectedAvailabilityItem;
    
    viewModel.displayInsuranceView = selectedVehicleState.insurance;
    
    viewModel.pickupLocation = CTLocalizedString(CTRentalVehiclePickupLocation);
    viewModel.pickupLocationDetail = [CTLocalisedStrings pickupType:availabilityItem];
    
    viewModel.fuelPolicy = CTLocalizedString(CTRentalVehicleFuelPolicy);
    viewModel.fuelPolicyDetail = [CTLocalisedStrings fuelPolicy:availabilityItem.vehicle.fuelPolicy];
    
    viewModel.mileageAllowance = CTLocalizedString(CTRentalMileageAllowance);
    viewModel.mileageAllowanceDetail = availabilityItem.vehicle.rateDistance.isUnlimited ? CTLocalizedString(CTRentalMileageUnlimited) : CTLocalizedString(CTRentalMileageLimited);
    
    viewModel.insuranceDetail = CTLocalizedString(CTRentalInsuranceBasic);
    viewModel.insuranceDetail = CTLocalizedString(CTRentalInsuranceBasicDetail);
    
    viewModel.important = @"*Translation Required*";
    viewModel.importantDetail = CTLocalizedString(CTRentalInsuranceTermsConditions);
    
    viewModel.pickupLocationExpanded = selectedVehicleState.pickupLocationExpanded;
    viewModel.fuelPolicyExpanded = selectedVehicleState.fuelPolicyExpanded;
    viewModel.mileageAllowanceExpanded = selectedVehicleState.mileageAllowanceExpanded;
    viewModel.insuranceExpanded = selectedVehicleState.insuranceExpanded;
    viewModel.insuranceAdded = selectedVehicleState.insuranceAdded;
    
    
    return viewModel;
}

@end
