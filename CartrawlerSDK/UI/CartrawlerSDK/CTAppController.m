//
//  CTAppController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/18/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAppController.h"
#import "CTAppState.h"
#import "CTAPIController.h"
#import "CTUserInterfaceController.h"
#import "CTValidationSearch.h"

#import "CartrawlerSDK+NSDateUtils.h"
#import "CTCSVItem.h"

@interface CTAppController ()
@property (nonatomic) CTAppState *appState;

@property (nonatomic) CTAPIController *apiController;
@property (nonatomic) CTUserInterfaceController *userInterfaceController;
@end

@implementation CTAppController

+ (void)dispatchAction:(CTAction)action payload:(id)payload {
    [[CTAppController instance] dispatchAction:action payload:payload];
}

+ (instancetype)instance {
    static CTAppController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTAppController alloc] init];
        
        sharedInstance.appState = [CTAppState new];
        sharedInstance.appState.userSettingsState = [CTUserSettingsState new];
        sharedInstance.appState.APIState = [CTAPIState new];
        sharedInstance.appState.navigationState = [CTNavigationState new];
        sharedInstance.appState.searchState = [CTSearchState new];
        sharedInstance.appState.vehicleListState = [CTVehicleListState new];
        sharedInstance.appState.selectedVehicleState = [CTSelectedVehicleState new];
        
        sharedInstance.apiController = [CTAPIController new];
        sharedInstance.userInterfaceController = [CTUserInterfaceController new];
    });
    return sharedInstance;
}

- (void)dispatchAction:(CTAction)action payload:(id)payload {
    CTAppState *appState = self.appState;
    CTUserSettingsState *userSettingsState = appState.userSettingsState;
    CTAPIState *APIState = appState.APIState;
    CTNavigationState *navigationState = appState.navigationState;
    CTSearchState *searchState = appState.searchState;
    CTVehicleListState *vehicleListState = appState.vehicleListState;
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    
    switch (action) {
        // User Settings Actions
        case CTActionUserSettingsSetClientID:
            userSettingsState.clientID = payload;
            break;
        case CTActionUserSettingsSetLanguageCode:
            userSettingsState.languageCode = payload ?: @"en";
            break;
        case CTActionUserSettingsSetCountryCode:
            userSettingsState.countryCode = payload;
            break;
        case CTActionUserSettingsSetCurrencyCode:
            userSettingsState.currencyCode = payload;
            break;
        case CTActionUserSettingsSetDebugMode:
            userSettingsState.debugMode = [(NSNumber *)payload boolValue];
            break;
        case CTActionUserSettingsSetLoggingEnabled:
            userSettingsState.loggingEnabled = [(NSNumber *)payload boolValue];
            break;
        case CTActionUserSettingsSetNewSession:
            [self.apiController setNewSessionWithState:userSettingsState];
            break;
            
        // API Actions
        case CTActionAPIDidReturnEngineLoadID:
            APIState.engineLoadID = payload;
            return;
        case CTActionAPIDidReturnCustomerID:
            APIState.customerID = payload;
            return;
        case CTActionAPIDidReturnMatchedLocations:
            [APIState.matchedLocations setValue:payload forKey:searchState.searchBarText];
            break;
        case CTActionAPIDidReturnVehicles:
            APIState.matchedAvailabilityItems = payload;
            break;
            
        // Navigation Actions
        case CTActionNavigationSetParentViewController:
            navigationState.parentViewController = payload;
            break;
        case CTActionNavigationPresentSearchStep:
            navigationState.desiredStep++;
            
            // Initialise search state
            searchState.selectedPickupTime = [NSDate dateWithHour:10 minute:0];
            searchState.selectedDropoffTime = [NSDate dateWithHour:10 minute:0];
            break;
        case CTActionSearchUserDidTapBack:
            navigationState.desiredStep--;
            break;
        
        // Search Actions
        case CTActionSearchUserDidTapSettingsButton:
            searchState.selectedTextField = CTSearchFormSettingsButton;
            break;
        case CTActionSearchUserDidTapPickupTextField:
            searchState.selectedTextField = CTSearchFormTextFieldPickupLocation;
            break;
        case CTActionSearchUserDidTapDropoffTextField:
            searchState.selectedTextField = CTSearchFormTextFieldDropoffLocation;
            break;
        case CTActionSearchUserDidToggleReturnToSameLocation:
            searchState.dropoffLocationRequired = ![(NSNumber *)payload boolValue];
            break;
        case CTActionSearchUserDidTapDatesTextField:
            searchState.selectedTextField = CTSearchFormTextFieldSelectDates;
            searchState.displayedPickupDate = nil;
            searchState.displayedDropoffDate = nil;
            break;
        case CTActionSearchUserDidTapPickupTimeTextField:
            searchState.selectedTextField = CTSearchFormTextFieldPickupTime;
            break;
        case CTActionSearchUserDidTapDropoffTimeTextField:
            searchState.selectedTextField = CTSearchFormTextFieldDropoffTime;
            break;
        case CTActionSearchUserDidTapAgeTextField:
            searchState.selectedTextField = CTSearchFormTextFieldDriverAge;
            break;
        case CTActionSearchUserDidToggleDriverAge:
            searchState.driverAgeRequired = ![(NSNumber *)payload boolValue];
            searchState.selectedTextField = searchState.driverAgeRequired ? CTSearchFormTextFieldDriverAge : CTSearchFormTextFieldNone;
            if ([CTValidationSearch validateSearchStep:searchState]) {
                APIState.matchedAvailabilityItems = nil;
                [self.apiController requestVehicleAvailabilityWithState:appState];
            }
            break;
        case CTActionSearchUserDidTapNext:
            searchState.selectedTextField = CTSearchFormTextFieldNone;
            navigationState.desiredStep++;
            break;
        case CTActionSearchSettingsUserDidTapCloseButton:
            searchState.selectedTextField = CTSearchSearchSettingsNone;
            break;
        case CTActionSearchSettingsUserDidTapCountryButton:
            searchState.selectedSettings = CTSearchSearchSettingsCountry;
            break;
        case CTActionSearchSettingsUserDidTapLanguageButton:
            searchState.selectedSettings = CTSearchSearchSettingsLanguage;
            break;
        case CTActionSearchSettingsUserDidTapCurrencyButton:
            searchState.selectedSettings = CTSearchSearchSettingsCurrency;
            break;
        case CTActionSearchSettingsDetailsUserDidTapCancelButton:
            searchState.selectedSettings = CTSearchSearchSettingsNone;
            break;
        case CTActionSearchSettingsDetailsUserDidSelectItem:
            switch (searchState.selectedSettings) {
                case CTSearchSearchSettingsCountry:
                    userSettingsState.countryCode = [[(CTCSVItem *)payload code] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    break;
                case CTSearchSearchSettingsLanguage:
                    // TODO: Fix the inversion of code and name in the language CSV
                    userSettingsState.languageCode = [[(CTCSVItem *)payload name] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    break;
                case CTSearchSearchSettingsCurrency:
                    userSettingsState.currencyCode = [[(CTCSVItem *)payload code] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    break;
                default:
                    break;
            }
            if ([CTValidationSearch validateSearchStep:searchState]) {
                APIState.matchedAvailabilityItems = nil;
                [self.apiController requestVehicleAvailabilityWithState:appState];
            }
            searchState.selectedSettings = CTSearchSearchSettingsNone;
            break;
        case CTActionSearchLocationsUserDidEnterCharacters:
            searchState.searchBarText = payload;
            if (searchState.searchBarText.length > 2) {
                [self.apiController fetchSearchLocationsWithState:appState];
            }
            break;
        case CTActionSearchLocationsUserDidTapCancel:
            searchState.searchBarText = @"";
            searchState.selectedTextField = CTSearchFormTextFieldNone;
            break;
        case CTActionSearchLocationsUserDidTapLocation:
            if (searchState.selectedTextField == CTSearchFormTextFieldPickupLocation) {
                searchState.selectedPickupLocation = payload;
            }
            if (searchState.selectedTextField == CTSearchFormTextFieldDropoffLocation) {
                searchState.selectedDropoffLocation = payload;
            }
            searchState.searchBarText = @"";
            searchState.selectedTextField = CTSearchFormTextFieldNone;
            
            if ([CTValidationSearch validateSearchStep:searchState]) {
                APIState.matchedAvailabilityItems = nil;
                [self.apiController requestVehicleAvailabilityWithState:appState];
            }
            break;
        case CTActionSearchCalendarUserDidTapDate:
            if (!searchState.displayedPickupDate) {
                searchState.displayedPickupDate = payload;
            } else if ([searchState.displayedPickupDate compare:payload] == NSOrderedAscending) {
                searchState.displayedDropoffDate = payload;
            } else if ([searchState.displayedPickupDate compare:payload] == NSOrderedDescending) {
                searchState.displayedPickupDate = payload;
            }
            break;
        case CTActionSearchCalendarUserDidDiscardDates:
            searchState.displayedPickupDate = nil;
            searchState.displayedDropoffDate = nil;
            break;
        case CTActionSearchCalendarUserDidTapNext:
            searchState.selectedPickupDate = searchState.displayedPickupDate;
            searchState.selectedDropoffDate = searchState.displayedDropoffDate;
            searchState.selectedTextField = CTSearchFormTextFieldNone;
            
            if ([CTValidationSearch validateSearchStep:searchState]) {
                APIState.vehicleRequestID++;
                APIState.matchedAvailabilityItems = nil;
                [self.apiController requestVehicleAvailabilityWithState:appState];
            }
            break;
        case CTActionSearchCalendarUserDidTapCancel:
            searchState.selectedTextField = CTSearchFormTextFieldNone;
            break;
        case CTActionSearchTimePickerUserDidSelectTime:
            if (searchState.selectedTextField == CTSearchFormTextFieldPickupTime) {
                searchState.selectedPickupTime = payload;
            }
            if (searchState.selectedTextField == CTSearchFormTextFieldDropoffTime) {
                searchState.selectedDropoffTime = payload;
            }
            
            if ([CTValidationSearch validateSearchStep:searchState]) {
                APIState.matchedAvailabilityItems = nil;
                [self.apiController requestVehicleAvailabilityWithState:appState];
            }
            break;
        case CTActionSearchDriverAgeUserDidEnterCharacters:
            if ([(NSString *)payload length] <= 2) {
                searchState.displayedDriverAge = payload;
            }
            
            if ([CTValidationSearch validateSearchStep:searchState]) {
                APIState.matchedAvailabilityItems = nil;
                [self.apiController requestVehicleAvailabilityWithState:appState];
            }
            break;
        case CTActionSearchInputViewUserDidSelectDone:
            searchState.selectedTextField = CTSearchFormTextFieldNone;
            break;
        
        // Vehicle List Actions
        case CTActionVehicleListUserDidTapVehicle:
            selectedVehicleState.selectedAvailabilityItem = payload;
            break;
        case CTActionVehicleListUserDidTapSort:
            vehicleListState.selectedView = CTVehicleListSelectedViewSort;
            break;
        case CTActionVehicleListUserDidTapFilter:
            vehicleListState.selectedView = CTActionVehicleListUserDidTapFilter;
            break;
        case CTActionVehicleListUserDidTapSortOption:
            vehicleListState.selectedView = CTVehicleListSelectedViewNone;
            if (vehicleListState.selectedSort != [payload integerValue]) {
                vehicleListState.selectedSort = [payload integerValue];
                vehicleListState.scrollToTop = YES;
            }
            break;
        case CTActionVehicleListScreenDidScrollToTop:
            vehicleListState.scrollToTop = NO;
            return;
        case CTActionVehicleListUserDidTapCancelSort:
            vehicleListState.selectedView = CTVehicleListSelectedViewNone;
            break;
        case CTActionVehicleListUserDidTapCancelFilter:
            vehicleListState.selectedView = CTVehicleListSelectedViewNone;
            break;
        case CTActionVehicleListUserDidTapApplyFilter:
            vehicleListState.selectedView = CTVehicleListSelectedViewNone;
            break;
        case CTActionVehicleListUserDidTapFilterOption:
            if ([vehicleListState.selectedFilters containsObject:payload]) {
                [vehicleListState.selectedFilters removeObject:payload];
            } else {
                [vehicleListState.selectedFilters addObject:payload];
            }
            break;
        default:
            break;
    }
    [self.userInterfaceController updateWithAppState:appState];
}

@end
