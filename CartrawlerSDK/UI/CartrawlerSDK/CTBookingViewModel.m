//
//  CTBookingViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 14/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTBookingViewModel.h"
#import "CTValidationBooking.h"
#import "CartrawlerSDK+NSNumber.h"

@interface CTBookingViewModel ()
@property (nonatomic, readwrite) CTPaymentSummaryViewModel *paymentSummaryViewModel;
@property (nonatomic, readwrite) CTBookingTextfield selectedTextfield;

@property (nonatomic, readwrite) NSString *total;
@property (nonatomic, readwrite) NSString *totalAmount;

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

@property (nonatomic, readwrite) BOOL shakeAnimations;
@property (nonatomic, readwrite) BOOL shakeFirstName;
@property (nonatomic, readwrite) BOOL shakeLastName;
@property (nonatomic, readwrite) BOOL shakeEmailAddress;
@property (nonatomic, readwrite) BOOL shakePrefix;
@property (nonatomic, readwrite) BOOL shakePhoneNumber;
@property (nonatomic, readwrite) BOOL shakeFlightNumber;
@property (nonatomic, readwrite) BOOL shakeAddressLine1;
@property (nonatomic, readwrite) BOOL shakeAddressLine2;
@property (nonatomic, readwrite) BOOL shakeCity;
@property (nonatomic, readwrite) BOOL shakePostcode;
@property (nonatomic, readwrite) BOOL shakeCountry;

@property (nonatomic, readwrite) NSAttributedString *termsAndConditions;
@property (nonatomic, readwrite) NSString *extrasReminder;

@property (nonatomic, readwrite) BOOL showAddressDetails;
@property (nonatomic, readwrite) NSNumber *keyboardHeight;
@property (nonatomic, readwrite) NSString *buttonTitle;
@property (nonatomic, readwrite) UIColor *navigationBarColor;
@property (nonatomic, readwrite) UIColor *buttonColor;
@end

@implementation CTBookingViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTBookingViewModel *viewModel =  [CTBookingViewModel new];
    CTBookingState *bookingState = appState.bookingState;
    
    viewModel.paymentSummaryViewModel = [CTPaymentSummaryViewModel viewModelForState:appState];
    viewModel.selectedTextfield = bookingState.selectedTextfield;
    viewModel.totalAmount = [self totalPrice:appState];
    
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
    viewModel.addressLine1 = bookingState.addressLine1;
    viewModel.addressLine2 = bookingState.addressLine2;
    viewModel.city = bookingState.city;
    viewModel.postcode = bookingState.postcode;
    viewModel.country = bookingState.country.name;
    
    if (appState.userSettingsState.keyboardShowing) {
        viewModel.keyboardHeight = appState.userSettingsState.keyboardHeight;
    }
    
    // TODO: Use textfield enums instead of new
    if (bookingState.wantsBooking && bookingState.animateValidationFailed) {
        viewModel.shakeAnimations = YES;
        for (NSNumber *failureNumber in [CTValidationBooking validateBookingStep:appState]) {
            CTValidationBookingFailed failure = failureNumber.integerValue;
            switch (failure) {
                case CTValidationBookingFailedFirstName:
                    viewModel.shakeFirstName = YES;
                    break;
                case CTValidationBookingFailedLastName:
                    viewModel.shakeLastName = YES;
                    break;
                case CTValidationBookingFailedEmailAddress:
                    viewModel.shakeEmailAddress = YES;
                    break;
                case CTValidationBookingFailedPrefix:
                    viewModel.shakePrefix = YES;
                    break;
                case CTValidationBookingFailedPhoneNumber:
                    viewModel.shakePhoneNumber = YES;
                    break;
                case CTValidationBookingFailedFlightNumber:
                    viewModel.shakeFlightNumber = YES;
                    break;
                case CTValidationBookingFailedAddressLine1:
                    viewModel.shakeAddressLine1 = YES;
                    break;
                case CTValidationBookingFailedAddressLine2:
                    viewModel.shakeAddressLine2 = YES;
                    break;
                case CTValidationBookingFailedCity:
                    viewModel.shakeCity = YES;
                    break;
                case CTValidationBookingFailedPostcode:
                    viewModel.shakePostcode = YES;
                    break;
                case CTValidationBookingFailedCountry:
                    viewModel.shakeCountry = YES;
                    break;
                default:
                    break;
            }
        }
    }
    
    NSAttributedString *linkString = [[NSAttributedString alloc] initWithString:CTLocalizedString(CTRentalInsuranceTermsConditions) attributes:@{NSForegroundColorAttributeName : [UIColor blueColor], NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    
    NSMutableAttributedString *termsConditionsString = [[NSMutableAttributedString alloc] initWithString:@"Tap ‘Pay’ to complete your booking and accept our "];
    [termsConditionsString appendAttributedString:linkString];
    viewModel.termsAndConditions = termsConditionsString;
    
    NSNumber *extrasTotal = [self totalForAddedExtras:appState.selectedVehicleState.addedExtras];
    if (extrasTotal.doubleValue > 0) {
        viewModel.extrasReminder = [NSString stringWithFormat:@"Don’t forget the remaining %@ will be paid at the rental desk at pick-up.", [extrasTotal numberStringWithCurrencyCode]];
    }
    
    viewModel.navigationBarColor = appState.userSettingsState.primaryColor;
    viewModel.buttonColor = appState.userSettingsState.secondaryColor;
    
    NSMutableString *buttonTitle = [[NSMutableString alloc] initWithString:extrasTotal.doubleValue > 0 ? @"Pay now " : @"Pay "];
    [buttonTitle appendString:[self totalPrice:appState]];
    viewModel.buttonTitle = buttonTitle.copy;
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

+ (NSNumber *)totalForAddedExtras:(NSMapTable *)addedExtras {
    double total = 0.0;
    
    NSEnumerator *enumerator = addedExtras.keyEnumerator;
    for (CTExtraEquipment *extra in enumerator) {
        if (!extra.isIncludedInRate && [[addedExtras objectForKey:extra] integerValue] > 0) {
            NSInteger quantity = [[addedExtras objectForKey:extra] integerValue];
            total += extra.chargeAmount.doubleValue * quantity;
        }
    }
    return [NSNumber numberWithDouble:total];
}

@end
