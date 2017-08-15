//
//  CTBookingViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 14/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTBookingViewModel.h"

@interface CTBookingViewModel ()
@property (nonatomic, readwrite) CTBookingTextfield selectedTextfield;

@property (nonatomic, readwrite) NSString *firstNamePlaceholder;
@property (nonatomic, readwrite) NSString *lastNamePlaceholder;
@property (nonatomic, readwrite) NSString *emailAddressPlaceholder;
@property (nonatomic, readwrite) NSString *prefixPlaceholder;
@property (nonatomic, readwrite) NSString *phoneNumberPlaceholder;
@property (nonatomic, readwrite) NSString *countryPlaceholder;
@property (nonatomic, readwrite) NSString *flightNumberPlaceholder;

@property (nonatomic, readwrite) NSString *firstName;
@property (nonatomic, readwrite) NSString *lastName;
@property (nonatomic, readwrite) NSString *emailAddress;
@property (nonatomic, readwrite) NSString *prefix;
@property (nonatomic, readwrite) NSString *phoneNumber;
@property (nonatomic, readwrite) NSString *country;
@property (nonatomic, readwrite) NSString *flightNumber;

@property (nonatomic, readwrite) NSNumber *keyboardHeight;
@end

@implementation CTBookingViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTBookingViewModel *viewModel =  [CTBookingViewModel new];
    CTBookingState *bookingState = appState.bookingState;
    
    viewModel.selectedTextfield = bookingState.selectedTextfield;
    
    viewModel.firstNamePlaceholder = CTLocalizedString(CTRentalUserFirstnameHint);
    viewModel.lastNamePlaceholder = CTLocalizedString(CTRentalUserSurnameHint);
    viewModel.emailAddressPlaceholder = CTLocalizedString(CTRentalUserEmailHint);
    viewModel.prefixPlaceholder = @"*Prefix";
    viewModel.phoneNumberPlaceholder = CTLocalizedString(CTRentalUserPhoneHint);
    viewModel.countryPlaceholder = CTLocalizedString(CTRentalUserCountryHint);
    viewModel.flightNumberPlaceholder = CTLocalizedString(CTRentalUserFlightHint);
    
//    self.addressTextField.placeholder = CTLocalizedString(CTRentalUserAddressLine1Hint);
//    self.address2TextField.placeholder = CTLocalizedString(CTRentalUserAddressLine2Hint);
//    self.cityTextField.placeholder = CTLocalizedString(CTRentalUserCityHint);
//    self.postcodeTextField.placeholder = CTLocalizedString(CTRentalUserPostcodeHint);

    
    viewModel.firstName = bookingState.firstName;
    viewModel.lastName = bookingState.lastName;
    viewModel.emailAddress = bookingState.emailAddress;
    if (bookingState.prefix.length > 0) {
        viewModel.prefix = [NSString stringWithFormat:@"+%@", bookingState.prefix];
    }
    viewModel.phoneNumber = bookingState.phoneNumber;
    viewModel.country = bookingState.country.name;
    viewModel.flightNumber = bookingState.flightNumber;
    
    // Don't adjust keyboard height when user interacting with payment as we don't have access to textfield events
    if (bookingState.selectedTextfield != CTBookingTextfieldPayment) {
        viewModel.keyboardHeight = appState.userSettingsState.keyboardHeight;
    }
    
    return viewModel;
}

@end
