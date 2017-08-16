//
//  CTBookingViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 14/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTBookingViewModel.h"

@interface CTBookingViewModel ()
@property (nonatomic, readwrite) CTPaymentSummaryViewModel *paymentSummaryViewModel;

@property (nonatomic, readwrite) CTBookingTextfield selectedTextfield;

@property (nonatomic, readwrite) NSString *firstNamePlaceholder;
@property (nonatomic, readwrite) NSString *lastNamePlaceholder;
@property (nonatomic, readwrite) NSString *emailAddressPlaceholder;
@property (nonatomic, readwrite) NSString *prefixPlaceholder;
@property (nonatomic, readwrite) NSString *phoneNumberPlaceholder;
@property (nonatomic, readwrite) NSString *flightNumberPlaceholder;
@property (nonatomic, readwrite) NSString *addressLine1Placeholder;
@property (nonatomic, readwrite) NSString *addressLine2Placeholder;
@property (nonatomic, readwrite) NSString *cityPlaceholder;
@property (nonatomic, readwrite) NSString *postcodePlaceholder;
@property (nonatomic, readwrite) NSString *countryPlaceholder;

@property (nonatomic, readwrite) NSString *firstName;
@property (nonatomic, readwrite) NSString *lastName;
@property (nonatomic, readwrite) NSString *emailAddress;
@property (nonatomic, readwrite) NSString *prefix;
@property (nonatomic, readwrite) NSString *phoneNumber;
@property (nonatomic, readwrite) NSString *flightNumber;
@property (nonatomic, readwrite) NSString *addressLine1;
@property (nonatomic, readwrite) NSString *addressLine2;
@property (nonatomic, readwrite) NSString *city;
@property (nonatomic, readwrite) NSString *postcode;
@property (nonatomic, readwrite) NSString *country;

@property (nonatomic, readwrite) BOOL showAddressDetails;
@property (nonatomic, readwrite) NSNumber *keyboardHeight;
@property (nonatomic, readwrite) UIColor *buttonColor;
@end

@implementation CTBookingViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTBookingViewModel *viewModel =  [CTBookingViewModel new];
    CTBookingState *bookingState = appState.bookingState;
    
    viewModel.paymentSummaryViewModel = [CTPaymentSummaryViewModel viewModelForState:appState];
    
    viewModel.selectedTextfield = bookingState.selectedTextfield;
    
    viewModel.firstNamePlaceholder = CTLocalizedString(CTRentalUserFirstnameHint);
    viewModel.lastNamePlaceholder = CTLocalizedString(CTRentalUserSurnameHint);
    viewModel.emailAddressPlaceholder = CTLocalizedString(CTRentalUserEmailHint);
    viewModel.prefixPlaceholder = @"*Prefix";
    viewModel.phoneNumberPlaceholder = CTLocalizedString(CTRentalUserPhoneHint);
    viewModel.flightNumberPlaceholder = CTLocalizedString(CTRentalUserFlightHint);
    viewModel.addressLine1Placeholder = CTLocalizedString(CTRentalUserAddressLine1Hint);
    viewModel.addressLine2Placeholder = CTLocalizedString(CTRentalUserAddressLine2Hint);
    viewModel.cityPlaceholder = CTLocalizedString(CTRentalUserCityHint);
    viewModel.postcodePlaceholder = CTLocalizedString(CTRentalUserPostcodeHint);
    viewModel.countryPlaceholder = CTLocalizedString(CTRentalUserCountryHint);

    
    viewModel.firstName = bookingState.firstName;
    viewModel.lastName = bookingState.lastName;
    viewModel.emailAddress = bookingState.emailAddress;
    if (bookingState.prefix.length > 0) {
        viewModel.prefix = [NSString stringWithFormat:@"+%@", bookingState.prefix];
    }
    viewModel.phoneNumber = bookingState.phoneNumber;
    viewModel.country = bookingState.country.name;
    viewModel.flightNumber = bookingState.flightNumber;
    viewModel.showAddressDetails = appState.selectedVehicleState.insuranceAdded;
    
    if (bookingState.selectedTextfield != CTBookingTextfieldNone && appState.userSettingsState.keyboardShowing) {
        viewModel.keyboardHeight = appState.userSettingsState.keyboardHeight;
    }
    
    viewModel.buttonColor = appState.userSettingsState.secondaryColor;
    
    return viewModel;
}

@end
