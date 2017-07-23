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

@interface CTAppController ()
@property (nonatomic) CTAppState *appState;

@property (nonatomic) CTAPIController *apiController;
@property (nonatomic) CTUserInterfaceController *userInterfaceController;
@end

@implementation CTAppController

+ (void)dispatchAction:(CTAction)action payload:(id)payload {
    [[CTAppController instance] dispatchAction:action payload:payload];
}

+ (instancetype)instance
{
    static CTAppController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTAppController alloc] init];
        
        sharedInstance.appState = [CTAppState new];
        sharedInstance.appState.userSettingsState = [CTUserSettingsState new];
        sharedInstance.appState.APIState = [CTAPIState new];
        sharedInstance.appState.navigationState = [CTNavigationState new];
        sharedInstance.appState.searchState = [CTSearchState new];
        
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
    
    switch (action) {
        // USER SETTINGS ACTIONS
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
            
            break;
            
        // NAVIGATION ACTIONS
        case CTActionNavigationSetParentViewController:
            navigationState.parentViewController = payload;
            break;
        case CTActionNavigationPresentSearchStep:
            navigationState.desiredStep++;
            break;
        
        // SEARCH ACTIONS
        case CTActionSearchUserDidTapPickupTextField:
            searchState.selectedTextField = CTSearchFormTextFieldPickupLocation;
            break;
        case CTActionSearchUserDidTapDropoffTextField:
            searchState.selectedTextField = CTSearchFormTextFieldDropoffLocation;
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
        case CTActionSearchUserDidTapNext:
            //navigationState.desiredStep++;
            [self.apiController requestVehicleAvailabilityWithState:appState];
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
            searchState.selectedTextField = CTSearchFormTextFieldNone;
            break;
        case CTActionSearchTimePickerUserDidSelectCancel:
            searchState.selectedTextField = CTSearchFormTextFieldNone;
            break;
        default:
            break;
    }
    [self.userInterfaceController updateWithAppState:appState];
}

@end
