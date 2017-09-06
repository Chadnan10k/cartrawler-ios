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
@property (nonatomic, readwrite) UIColor *primaryColor;
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *infoTip1;
@property (nonatomic, readwrite) NSString *infoTip2;
@property (nonatomic, readwrite) NSString *infoTip3;
@property (nonatomic, readwrite) NSString *detailsTitle;
@property (nonatomic, readwrite) NSString *logo;
@property (nonatomic, readwrite) NSString *pricePerDay;
@property (nonatomic, readwrite) NSString *total;
@property (nonatomic, readwrite) NSAttributedString *addInsurance;
@property (nonatomic, readwrite) UIColor *buttonColor;
@end

@implementation CTSelectedVehicleInsuranceViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSelectedVehicleInsuranceViewModel *viewModel = [CTSelectedVehicleInsuranceViewModel new];
    CTSearchState *searchState = appState.searchState;
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    CTInsurance *insurance = selectedVehicleState.insurance;
    
    if (!insurance) {
        return nil;
    }
    viewModel.primaryColor = appState.userSettingsState.primaryColor;
    viewModel.title = CTLocalizedString(CTRentalInsuranceOfferingHeader);
    viewModel.infoTip1 = CTLocalizedString(CTRentalInsuranceInfoTip1);
    viewModel.infoTip2 = CTLocalizedString(CTRentalInsuranceInfoTip2);
    viewModel.infoTip3 = CTLocalizedString(CTRentalInsuranceInfoTip3);
    viewModel.detailsTitle = CTLocalizedString(CTRentalInsuranceInfoButtonTitle);
    viewModel.logo = @"axa_logo";
    viewModel.pricePerDay = [self pricePerDay:insurance state:searchState];
    viewModel.total = [self total:insurance];
    viewModel.addInsurance = selectedVehicleState.insuranceAdded ? [self addedString] : [self addString];
    viewModel.buttonColor = selectedVehicleState.insuranceAdded ? [UIColor colorWithRed:0/255.0 green:167.0/255.0 blue:60/255.0 alpha:1.0] : viewModel.primaryColor;
    
    return viewModel;
}

+ (NSString *)pricePerDay:(CTInsurance *)insurance state:(CTSearchState *)searchState {
    return [NSString stringWithFormat:@"%@ %@", [insurance.premiumAmount pricePerDay:searchState.selectedPickupDate dropoff:searchState.selectedDropoffDate], CTLocalizedString(CTRentalInsurancePerDay)];
}

+ (NSString *)total:(CTInsurance *)insurance {
    return [NSString stringWithFormat:@"%@ %@", CTLocalizedString(CTRentalInsuranceTotal), [insurance.premiumAmount numberStringWithCurrencyCode]];
}
    
+ (NSAttributedString *)addString {
    NSMutableAttributedString *addString = [[NSMutableAttributedString alloc] initWithString:CTLocalizedString(CTRentalInsuranceAddButtonTitle)];
    [addString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, addString.length)];
    return addString.copy;
}
    
+ (NSAttributedString *)addedString {
    NSMutableAttributedString *addedString = [[NSMutableAttributedString alloc] initWithString:CTLocalizedString(CTRentalInsuranceAddedButtonTitle)];
    NSMutableAttributedString *tickString = [[NSMutableAttributedString alloc] initWithString:@"  "];
    [tickString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"V5-Mobile" size:14] range:NSMakeRange(0, tickString.length)];
    [tickString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, tickString.length)];
    [addedString appendAttributedString:tickString];
    
    return addedString.copy;
}

@end
