//
//  CTSearchFormViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/20/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchFormViewModel.h"
#import "CTAppState.h"
#import "CTMatchedLocation.h"
#import "CartrawlerSDK+NSDateUtils.h"

@interface CTSearchFormViewModel ()
@property (nonatomic, readwrite) UIColor *backgroundColor;
@property (nonatomic, readwrite) UIColor *driverAgeCursorColor;
@property (nonatomic, readwrite) UIColor *nextButtonColor;
@property (nonatomic, readwrite) UIColor *doneButtonColor;
@property (nonatomic, readwrite) NSString *pickupLocationName;
@property (nonatomic, readwrite) NSString *returnToSameLocation;
@property (nonatomic, readwrite) NSString *returnToSameLocationCheckboxText;
@property (nonatomic, readwrite) NSString *dropoffLocationName;
@property (nonatomic, readwrite) NSString *rentalDates;
@property (nonatomic, readwrite) NSString *pickupTime;
@property (nonatomic, readwrite) NSString *dropoffTime;
@property (nonatomic, readwrite) NSDate *defaultPickerTime;
@property (nonatomic, readwrite) CTSearchFormTextField selectedTextField;
@property (nonatomic, readwrite) BOOL dropoffLocationTextfieldDisplayed;
@property (nonatomic, readwrite) BOOL driverAgeTextfieldDisplayed;
@property (nonatomic, readwrite) BOOL textfieldInputViewDisplayed;
@property (nonatomic, readwrite) NSString *driverAgeCheckboxText;
@property (nonatomic, readwrite) NSString *displayedDriverAge;
@property (nonatomic, readwrite) BOOL shakeAnimations;
@property (nonatomic, readwrite) BOOL shakePickupLocation;
@property (nonatomic, readwrite) BOOL shakeDropoffLocation;
@property (nonatomic, readwrite) BOOL shakeSelectDates;
@property (nonatomic, readwrite) BOOL shakePickupTime;
@property (nonatomic, readwrite) BOOL shakeDropoffTime;
@property (nonatomic, readwrite) BOOL shakeDriverAge;
@end

@implementation CTSearchFormViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchState *searchState = appState.searchState;
    CTSearchFormViewModel *viewModel = [CTSearchFormViewModel new];
    
    viewModel.backgroundColor = appState.userSettingsState.primaryColor;
    viewModel.driverAgeCursorColor = appState.userSettingsState.primaryColor;
    viewModel.nextButtonColor = appState.userSettingsState.secondaryColor;
    viewModel.doneButtonColor = appState.userSettingsState.primaryColor;
    
    viewModel.pickupLocationName = searchState.selectedPickupLocation.name;
    viewModel.dropoffLocationName = searchState.selectedDropoffLocation.name;
    
    viewModel.returnToSameLocation = CTLocalizedString(CTRentalSearchReturnLocationButton);
    
    if (searchState.selectedPickupDate && searchState.selectedDropoffDate) {
        viewModel.rentalDates = [NSString stringWithFormat:@"%@ - %@", [searchState.selectedPickupDate shortDescriptionFromDate], [searchState.selectedDropoffDate shortDescriptionFromDate]];
    }
    
    viewModel.pickupTime = [searchState.selectedPickupTime simpleTimeString];
    viewModel.dropoffTime = [searchState.selectedDropoffTime simpleTimeString];
    
    if (searchState.selectedTextField == CTSearchFormTextFieldPickupTime && searchState.selectedPickupTime) {
        viewModel.defaultPickerTime = searchState.selectedPickupTime;
    } else if (searchState.selectedTextField == CTSearchFormTextFieldDropoffTime && searchState.selectedDropoffTime) {
        viewModel.defaultPickerTime = searchState.selectedDropoffTime;
    } else {
        viewModel.defaultPickerTime = searchState.selectedPickupTime;
    }
    
    viewModel.returnToSameLocationCheckboxText = searchState.dropoffLocationRequired ? @"" : @""; // Checkmark
    viewModel.dropoffLocationTextfieldDisplayed = searchState.dropoffLocationRequired;
    viewModel.driverAgeCheckboxText = searchState.driverAgeRequired ? @"" : @""; // Checkmark
    viewModel.driverAgeTextfieldDisplayed = searchState.driverAgeRequired;
    
    viewModel.textfieldInputViewDisplayed =
    searchState.selectedTextField == CTSearchFormTextFieldPickupTime ||
    searchState.selectedTextField == CTSearchFormTextFieldDropoffTime ||
    searchState.selectedTextField == CTSearchFormTextFieldDriverAge;
    
    viewModel.selectedTextField = searchState.selectedTextField;
    
    viewModel.displayedDriverAge = searchState.displayedDriverAge;
    
    // TODO: Copy below pattern for bookings instaed of animateValidationFailed and separate errors
    if (searchState.wantsNextStep && searchState.validationErrors.count > 0) {
        viewModel.shakeAnimations = YES;
        for (NSNumber *failureNumber in searchState.validationErrors) {
            CTSearchFormTextField field = failureNumber.integerValue;
            switch (field) {
                case CTSearchFormTextFieldPickupLocation:
                    viewModel.shakePickupLocation = YES;
                    break;
                case CTSearchFormTextFieldDropoffLocation:
                    viewModel.shakeDropoffLocation = YES;
                    break;
                case CTSearchFormTextFieldSelectDates:
                    viewModel.shakeSelectDates = YES;
                    break;
                case CTSearchFormTextFieldPickupTime:
                    viewModel.shakePickupTime = YES;
                    break;
                case CTSearchFormTextFieldDropoffTime:
                    viewModel.shakeDropoffTime = YES;
                    break;
                case CTSearchFormTextFieldDriverAge:
                    viewModel.shakeDriverAge = YES;
                    break;
                default:
                    break;
            }
        }
    }
    
    return viewModel;
}

@end
