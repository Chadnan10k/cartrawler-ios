//
//  CTSearchFormViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/20/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchFormViewModel.h"
#import "CTAppState.h"
#import <CartrawlerAPI/CTMatchedLocation.h>
#import "CartrawlerSDK+NSDateUtils.h"

@interface CTSearchFormViewModel ()
@property (nonatomic, readwrite) NSString *pickupLocationName;
@property (nonatomic, readwrite) NSString *dropoffLocationName;
@property (nonatomic, readwrite) NSString *rentalDates;
@property (nonatomic, readwrite) NSString *pickupTime;
@property (nonatomic, readwrite) NSString *dropoffTime;
@property (nonatomic, readwrite) NSDate *defaultPickerTime;
@property (nonatomic, readwrite) CTSearchFormTextField selectedTextField;
@property (nonatomic, readwrite) BOOL dropoffLocationTextfieldDisplayed;
@property (nonatomic, readwrite) BOOL driverAgeTextfieldDisplayed;
@property (nonatomic, readwrite) BOOL textfieldInputViewDisplayed;
@property (nonatomic, readwrite) NSString *displayedDriverAge;
@end

@implementation CTSearchFormViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchState *searchState = appState.searchState;
    CTSearchFormViewModel *viewModel = [CTSearchFormViewModel new];
    
    viewModel.pickupLocationName = searchState.selectedPickupLocation.name;
    viewModel.dropoffLocationName = searchState.selectedDropoffLocation.name;
    
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
    
    viewModel.dropoffLocationTextfieldDisplayed = searchState.dropoffLocationRequired;
    viewModel.driverAgeTextfieldDisplayed = searchState.driverAgeRequired;
    
    viewModel.textfieldInputViewDisplayed =
    searchState.selectedTextField == CTSearchFormTextFieldPickupTime ||
    searchState.selectedTextField == CTSearchFormTextFieldDropoffTime ||
    searchState.selectedTextField == CTSearchFormTextFieldDriverAge;
    
    viewModel.selectedTextField = searchState.selectedTextField;
    
    viewModel.displayedDriverAge = searchState.displayedDriverAge;
    
    return viewModel;
}

@end
