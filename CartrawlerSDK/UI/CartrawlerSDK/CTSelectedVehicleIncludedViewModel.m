//
//  CTSelectedVehicleIncludedViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleIncludedViewModel.h"

@interface CTSelectedVehicleIncludedViewModel ()

@property (nonatomic, readwrite) UIColor *primaryColor;

@property (nonatomic, readwrite) NSString *pickupLocation;
@property (nonatomic, readwrite) NSString *fuelPolicy;
@property (nonatomic, readwrite) NSString *mileageAllowance;
@property (nonatomic, readwrite) NSString *insurance;
@property (nonatomic, readwrite) NSString *important;

@property (nonatomic, readwrite) NSString *pickupLocationConcise;
@property (nonatomic, readwrite) NSString *fuelPolicyConcise;
@property (nonatomic, readwrite) NSString *mileageAllowanceConcise;
@property (nonatomic, readwrite) NSString *insuranceConcise;
@property (nonatomic, readwrite) NSString *importantConcise;

@property (nonatomic, readwrite) NSString *pickupLocationDetail;
@property (nonatomic, readwrite) NSString *fuelPolicyDetail;
@property (nonatomic, readwrite) NSString *mileageAllowanceDetail;
@property (nonatomic, readwrite) NSAttributedString *insuranceDetail;
@property (nonatomic, readwrite) NSString *importantDetail;

@property (nonatomic, readwrite) BOOL pickupLocationExpanded;
@property (nonatomic, readwrite) BOOL fuelPolicyExpanded;
@property (nonatomic, readwrite) BOOL mileageAllowanceExpanded;
@property (nonatomic, readwrite) BOOL insuranceExpanded;
@end

@implementation CTSelectedVehicleIncludedViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSelectedVehicleIncludedViewModel *viewModel = [CTSelectedVehicleIncludedViewModel new];
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    CTAvailabilityItem *availabilityItem = selectedVehicleState.selectedAvailabilityItem;
    
    viewModel.primaryColor = appState.userSettingsState.primaryColor;
    
    viewModel.pickupLocation = CTLocalizedString(CTRentalVehiclePickupLocation);
    viewModel.pickupLocationConcise = [CTLocalisedStrings pickupType:availabilityItem];
    viewModel.pickupLocationDetail = [CTLocalisedStrings toolTipTextForPickupType:availabilityItem];
    
    viewModel.fuelPolicy = CTLocalizedString(CTRentalVehicleFuelPolicy);
    viewModel.fuelPolicyConcise = [CTLocalisedStrings fuelPolicy:availabilityItem.vehicle.fuelPolicy];
    viewModel.fuelPolicyDetail = [CTLocalisedStrings toolTipTextForFuelPolicy:availabilityItem.vehicle.fuelPolicy];
    
    viewModel.mileageAllowance = CTLocalizedString(CTRentalMileageAllowance);
    viewModel.mileageAllowanceConcise = availabilityItem.vehicle.rateDistance.isUnlimited ? CTLocalizedString(CTRentalMileageUnlimited) : CTLocalizedString(CTRentalMileageLimited);
    viewModel.mileageAllowanceDetail = [self textForRateDistance:availabilityItem.vehicle.rateDistance];
    
    viewModel.insurance = CTLocalizedString(CTRentalInsuranceBasic);
    viewModel.insuranceConcise = CTLocalizedString(CTRentalInsuranceBasicDetail);
    viewModel.insuranceDetail = [self textForCoverages:availabilityItem.vehicle.pricedCoverages primaryColor:appState.userSettingsState.primaryColor];
    
    viewModel.important = @"Important";
    viewModel.importantDetail = CTLocalizedString(CTRentalInsuranceTermsConditions);
    
    viewModel.pickupLocationExpanded = selectedVehicleState.pickupLocationExpanded;
    viewModel.fuelPolicyExpanded = selectedVehicleState.fuelPolicyExpanded;
    viewModel.mileageAllowanceExpanded = selectedVehicleState.mileageAllowanceExpanded;
    viewModel.insuranceExpanded = selectedVehicleState.insuranceExpanded;
    
    return viewModel;
}

+ (NSString *)textForRateDistance:(CTRateDistance *)rateDistance {
    if (rateDistance.isUnlimited) {
        return CTLocalizedString(CTRentalMileageUnlimitedDetail);
    }
    
    NSString *mileageAmount = [NSString stringWithFormat:@"%@ %@ %@", rateDistance.quantity, rateDistance.distanceUnitName, rateDistance.vehiclePeriodUnitName];
    
    return [NSString stringWithFormat:CTLocalizedString(CTRentalMileageLimitedDetail), mileageAmount];
}

+ (NSAttributedString *)textForCoverages:(NSArray *)coverages primaryColor:(UIColor *)primaryColor {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    for (CTPricedCoverage *coverage in coverages) {
        UIFont *iconFont = [UIFont fontWithName:@"V5-Mobile" size:14.f];
        NSDictionary *iconAttributesDictionary =  @{ NSForegroundColorAttributeName : primaryColor, NSFontAttributeName: iconFont };
        NSAttributedString *iconAttributesString = [[NSAttributedString alloc] initWithString:@" " attributes:iconAttributesDictionary];
        
        UIFont *textFont = [UIFont systemFontOfSize:16.f];
        NSDictionary *textAttributesDictionary=[NSDictionary dictionaryWithObject:textFont forKey:NSFontAttributeName];
        NSAttributedString *textAttributesString = [[NSAttributedString alloc] initWithString:coverage.chargeDescription attributes:textAttributesDictionary];
        
        [string appendAttributedString:iconAttributesString];
        [string appendAttributedString:textAttributesString];
        
        if (![coverages.lastObject isEqual:coverage]) {
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"] ];
        }
    }
    
    return string.copy;
}



@end
