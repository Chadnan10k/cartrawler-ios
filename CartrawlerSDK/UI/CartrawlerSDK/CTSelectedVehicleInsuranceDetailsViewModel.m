//
//  CTSelectedVehicleInsuranceDetailsViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 23/08/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleInsuranceDetailsViewModel.h"
#import "CartrawlerSDK+NSNumber.h"

@interface CTSelectedVehicleInsuranceDetailsViewModel ()
@property (nonatomic, readwrite) UIColor *primaryColor;
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *logo;
@property (nonatomic, readwrite) NSString *perDay;
@property (nonatomic, readwrite) NSString *total;
@property (nonatomic, readwrite) NSString *reduceLiability;
@property (nonatomic, readwrite) NSString *reduceLiabilityDetails;
@property (nonatomic, readwrite) NSString *whatsCovered;
@property (nonatomic, readwrite) NSAttributedString *whatsCoveredDetails;
@property (nonatomic, readwrite) NSString *termsAndConditions;
@end

@implementation CTSelectedVehicleInsuranceDetailsViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSelectedVehicleInsuranceDetailsViewModel *viewModel = [CTSelectedVehicleInsuranceDetailsViewModel new];
    CTSearchState *searchState = appState.searchState;
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    
    viewModel.primaryColor = appState.userSettingsState.primaryColor;
    viewModel.title = CTLocalizedString(CTRentalInsuranceInfoButtonTitle);
    viewModel.logo = @"axa_logo";
    viewModel.perDay = [NSString stringWithFormat:@"%@ %@", [selectedVehicleState.insurance.premiumAmount pricePerDay:searchState.selectedPickupDate dropoff:searchState.selectedDropoffDate], CTLocalizedString(CTRentalInsurancePerDay)];
    viewModel.total =  [NSString stringWithFormat:@"%@ %@", CTLocalizedString(CTRentalInsuranceTotal), [selectedVehicleState.insurance.premiumAmount numberStringWithCurrencyCode]];
    
    
    viewModel.reduceLiability = CTLocalizedString(CTRentalInsuranceDetailInfoTitle);
    viewModel.reduceLiabilityDetails = CTLocalizedString(CTRentalInsuranceDetailInfo);
    
    viewModel.whatsCovered = CTLocalizedString(CTRentalInsuranceDetailTipTitle);
    viewModel.whatsCoveredDetails = [self whatsCoveredDetailsWithPrimaryColor:viewModel.primaryColor];
    
    viewModel.termsAndConditions = CTLocalizedString(CTRentalInsuranceTermsConditions);
    
    return viewModel;
}

//TODO: Extract presentation shared logic
+ (NSAttributedString *)whatsCoveredDetailsWithPrimaryColor:(UIColor *)primaryColor {
    NSArray *details = @[CTLocalizedString(CTRentalInsuranceDetailTip1), CTLocalizedString(CTRentalInsuranceDetailTip2), CTLocalizedString(CTRentalInsuranceDetailTip3), CTLocalizedString(CTRentalInsuranceDetailTip4), CTLocalizedString(CTRentalInsuranceDetailTip5)];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    for (NSString *detail in details) {
        UIFont *textFont = [UIFont systemFontOfSize:16.f];
        NSDictionary *textAttributesDictionary=[NSDictionary dictionaryWithObject:textFont forKey:NSFontAttributeName];
        NSAttributedString *textAttributesString = [[NSAttributedString alloc] initWithString:detail attributes:textAttributesDictionary];
        
        UIFont *iconFont = [UIFont fontWithName:@"V5-Mobile" size:14.f];
        NSDictionary *iconAttributesDictionary =  @{ NSForegroundColorAttributeName : primaryColor, NSFontAttributeName: iconFont };
        NSAttributedString *iconAttributesString = [[NSAttributedString alloc] initWithString:@" " attributes:iconAttributesDictionary];
        
        [string appendAttributedString:iconAttributesString];
        [string appendAttributedString:textAttributesString];
        
        if (![details.lastObject isEqual:detail]) {
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"] ];
        }
    }
    
    return string.copy;
}

@end
