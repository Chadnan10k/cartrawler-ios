//
//  CTLoggingController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 08/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTLoggingController.h"

@implementation CTLoggingController

- (void)logAction:(CTAction)action payload:(id)payload {
    NSLog(@"%@", [CTLoggingController descriptionForAction:action payload:payload]);
}

+ (NSString *)descriptionForAction:(CTAction)action
                           payload:(id)payload {
    NSString *message = @"";
    switch (action) {
        case CTActionInitialiseState:
            message = @"Initialise state";
            break;
        case CTActionUserSettingsSetClientID:
            message = @"Set client ID";
            break;
        case CTActionUserSettingsSetLanguageCode:
            message = @"Set language code";
            break;
        case CTActionUserSettingsSetCurrencyCode:
            message = @"Set currency code";
            break;
        case CTActionUserSettingsSetCountryCode:
            message = @"Set country code";
            break;
        case CTActionUserSettingsSetDebugMode:
            message = @"Set debug mode";
            break;
        case CTActionUserSettingsSetLoggingEnabled:
            message = @"Set logging enabled";
            break;
        case CTActionUserSettingsSetNewSession:
            message = @"Requested new session";
            break;
        case CTActionUserSettingsUserDidShake:
            message = @"Phone shake";
            break;
        case CTActionNotificationUserInputDidShow:
            message = @"User input shown";
            break;
        case CTActionNotificationUserInputDidHide:
            message = @"User input hidden";
            break;
        case CTActionAPIDidReturnEngineLoadID:
            message = @"Received engine load ID";
            break;
        case CTActionAPIDidReturnCustomerID:
            message = @"Received customer ID";
            break;
        case CTActionAPIDidReturnMatchedLocations:
            message = @"Received matched locations";
            break;
        case CTActionAPIDidReturnVehicles:
            message = @"Received matched vehicles";
            break;
        case CTActionNavigationSetParentViewController:
            message = @"Set parent view controller";
            break;
        case CTActionNavigationPresentSearchStep:
            message = @"Search step presented";
            break;
        case CTActionSearchUserDidSwipeUSPCarousel:
            message = @"USP carousel swiped to index";
            break;
        case CTActionSearchUserDidTapCloseButton:
            message = @"Search close button tapped";
            break;
        case CTActionSearchUserDidTapSettingsButton:
            message = @"Settings button tapped";
            break;
        case CTActionSearchUserDidTapPickupTextField:
            message = @"Pick-up textfield tapped";
            break;
        case CTActionSearchUserDidTapDropoffTextField:
            message = @"Drop-off textfield tapped";
            break;
        case CTActionSearchUserDidToggleReturnToSameLocation:
            message = @"Return to same location toggled";
            break;
        case CTActionSearchUserDidTapDatesTextField:
            message = @"Dates textfield tapped";
            break;
        case CTActionSearchUserDidTapPickupTimeTextField:
            message = @"Pick-up time textfield tapped";
            break;
        case CTActionSearchUserDidTapDropoffTimeTextField:
            message = @"Drop-off time textfield tapped";
            break;
        case CTActionSearchUserDidTapAgeTextField:
            message = @"Age textfield tapped";
            break;
        case CTActionSearchUserDidToggleDriverAge:
            message = @"Driver age toggled";
            break;
        case CTActionSearchUserDidTapNext:
            message = @"Search next button tapped";
            break;
        case CTActionSearchUserDidTapBack:
            message = @"Back button tapped";
            break;
        case CTActionSearchViewDidScrollAboveUserInput:
            message = @"Scroll animation complete";
            break;
        case CTActionSearchSettingsUserDidTapCloseButton:
            message = @"Close setting button tapped";
            break;
        case CTActionSearchSettingsUserDidTapCountryButton:
            message = @"Country settings button tapped";
            break;
        case CTActionSearchSettingsUserDidTapLanguageButton:
            message = @"Language settings button tapped";
            break;
        case CTActionSearchSettingsUserDidTapCurrencyButton:
            message = @"Currency settings button tapped";
            break;
        case CTActionSearchSettingsDetailsUserDidTapCancelButton:
            message = @"Settings detail cancel button tapped";
            break;
        case CTActionSearchSettingsDetailsUserDidSelectItem:
            message = @"Setting selected";
            break;
        case CTActionSearchLocationsUserDidEnterCharacters:
            message = @"Search location characters entered";
            break;
        case CTActionSearchLocationsUserDidTapCancel:
            message = @"Search locations cancel button tapped";
            break;
        case CTActionSearchLocationsUserDidTapLocation:
            message = @"Search location selected";
            break;
        case CTActionSearchCalendarUserDidTapDate:
            message = @"Search calendar date selected";
            break;
        case CTActionSearchCalendarUserDidDiscardDates:
            message = @"Search calendar dates discarded";
            break;
        case CTActionSearchCalendarUserDidTapNext:
            message = @"Search calendar next button tapped";
            break;
        case CTActionSearchCalendarUserDidTapCancel:
            message = @"Search calendar cancel button tapped";
            break;
        case CTActionSearchTimePickerUserDidSelectTime:
            message = @"Search time picker tapped";
            break;
        case CTActionSearchDriverAgeUserDidEnterCharacters:
            message = @"Age characters entered";
            break;
        case CTActionSearchInputViewUserDidSelectDone:
            message = @"Input view done tapped";
            break;
        case CTActionVehicleListUserDidTapBack:
            message = @"Vehicle list back button tapped";
            break;
        case CTActionVehicleListUserDidTapVehicle:
            message = @"Vehicle tapped";
            break;
        case CTActionVehicleListUserDidTapSort:
            message = @"Vehicle list sort button tapped";
            break;
        case CTActionVehicleListUserDidTapFilter:
            message = @"Vehicle list filter button tapped";
            break;
        case CTActionVehicleListUserDidTapSortOption:
            message = @"Vehicle list sort option tapped";
            break;
        case CTActionVehicleListScreenDidScrollToTop:
            message = @"Vehicle list scrolled to top";
            break;
        case CTActionVehicleListUserDidTapCancelSort:
            message = @"Vehicle list cancel sort tapped";
            break;
        case CTActionVehicleListUserDidTapApplyFilter:
            message = @"Vehicle list filter applied";
            break;
        case CTActionVehicleListUserDidTapCancelFilter:
            message = @"Vehicle list cancel filter tapped";
            break;
        case CTActionVehicleListUserDidTapFilterSelectAll:
            message = @"Vehicle list select all filters tapped";
            break;
        case CTActionVehicleListUserDidTapFilterOption:
            message = @"Vehicle list filter option tapped";
            break;
        case CTActionSelectedVehicleUserDidTapBack:
            message = @"Selected vehicle back button tapped";
            break;
        case CTActionSelectedVehicleUserDidTapTab:
            message = @"Selected vehicle tab tapped";
            break;
        case CTActionSelectedVehicleUserDidTapIncludedItem:
            message = @"Selected vehicle included item tapped";
            break;
        case CTActionSelectedVehicleUserDidTapInsuranceDetails:
            message = @"Insurance details tapped";
            break;
        case CTActionSelectedVehicleUserDidTapAddInsurance:
            message = @"Add insurance tapped";
            break;
        case CTActionSelectedVehicleUserDidTapViewAllExtras:
            message = @"View all extras tapped";
            break;
        case CTActionSelectedVehicleUserDidTapIncrementExtra:
            message = @"Increment extra tapped";
            break;
        case CTActionSelectedVehicleUserDidTapDecrementExtra:
            message = @"Decrement extra tapped";
            break;
        case CTActionSelectedVehicleUserDidTapExtraInfo:
            message = @"Extra info tapped";
            break;
        default:
            break;
    }

    if (payload) {
        return [NSString stringWithFormat:@"%@: %@", message, payload];
    }
    return message;
}

@end
