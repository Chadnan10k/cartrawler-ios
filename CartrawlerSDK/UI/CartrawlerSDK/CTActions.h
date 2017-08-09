//
//  CTActions.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/18/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

/**
 *  Actions
 */
typedef NS_ENUM(NSUInteger, CTAction) {
    /**
     *  Initialise the state object
     */
    CTActionInitialiseState,
    
    // User Actions
    /**
     *  Sets the Client ID
     */
    CTActionUserSettingsSetClientID,
    /**
     *  Sets the Language Code
     */
    CTActionUserSettingsSetLanguageCode,
    /**
     *  Sets the Currency Code
     */
    CTActionUserSettingsSetCurrencyCode,
    /**
     *  Sets the Country Code
     */
    CTActionUserSettingsSetCountryCode,
    /**
     *  Sets the Debug Mode
     */
    CTActionUserSettingsSetDebugMode,
    /**
     *  Sets logging to the console
     */
    CTActionUserSettingsSetLoggingEnabled,
    /**
     *  Sets logging to the console
     */
    CTActionUserSettingsSetNewSession,
    /**
     *  The user shook their phone
     */
    CTActionUserSettingsUserDidShake,
    
    // Notification Actions
    /**
     *  System user input did appear
     */
    CTActionNotificationUserInputDidShow,
    /**
     *  System user input did hide
     */
    CTActionNotificationUserInputDidHide,
    
    // API Actions
    /**
     *  Sets engine 
     */
    CTActionAPIDidReturnEngineLoadID,
    /**
     *  API returned customer ID
     */
    CTActionAPIDidReturnCustomerID,
    /**
     *  API returned matched lcoations
     */
    CTActionAPIDidReturnMatchedLocations,
    /**
     *  API returned vehicles
     */
    CTActionAPIDidReturnVehicles,
    
    // NAVIGATION ACTIONS
    /**
     *  Sets the parent view controller
     */
    CTActionNavigationSetParentViewController,
    /**
     *  Requests the search step
     */
    CTActionNavigationPresentSearchStep,
    
    // Search Actions
    /**
     *  The user swiped the USP carousel
     */
    CTActionSearchUserDidSwipeUSPCarousel,
    /**
     *  The user tapped the close button
     */
    CTActionSearchUserDidTapCloseButton,
    /**
     *  The user tapped the settings button
     */
    CTActionSearchUserDidTapSettingsButton,
    /**
     *  The user tapped the pickup textfield
     */
    CTActionSearchUserDidTapPickupTextField,
    /**
     *  The user tapped the dropoff textfield
     */
    CTActionSearchUserDidTapDropoffTextField,
    /**
     *  The user toggled the return to same location switch
     */
    CTActionSearchUserDidToggleReturnToSameLocation,
    /**
     *  The user tapped the select dates textfield
     */
    CTActionSearchUserDidTapDatesTextField,
    /**
     *  The user tapped the pick-up time text field
     */
    CTActionSearchUserDidTapPickupTimeTextField,
    /**
     *  The user tapped the dropoff time text field
     */
    CTActionSearchUserDidTapDropoffTimeTextField,
    /**
     *  The user tapped the age text field
     */
    CTActionSearchUserDidTapAgeTextField,
    /**
     *  The user toggled the driver age switch
     */
    CTActionSearchUserDidToggleDriverAge,
    /**
     *  The user tapped the next button
     */
    CTActionSearchUserDidTapNext,
    /**
     *  The user tapped the back button
     */
    CTActionSearchUserDidTapBack,
    /**
     *  The view scrolled in response to a user input showing
     */
    CTActionSearchViewDidScrollAboveUserInput,
    /**
     *  The user tapped the close settings button
     */
    CTActionSearchSettingsUserDidTapCloseButton,
    /**
     *  The user tapped the country settings button
     */
    CTActionSearchSettingsUserDidTapCountryButton,
    /**
     *  The user tapped the language settings button
     */
    CTActionSearchSettingsUserDidTapLanguageButton,
    /**
     *  The user tapped the currency settings button
     */
    CTActionSearchSettingsUserDidTapCurrencyButton,
    /**
     *  The user tapped the cancel settings details button
     */
    CTActionSearchSettingsDetailsUserDidTapCancelButton,
    /**
     *  The user selected a setting item
     */
    CTActionSearchSettingsDetailsUserDidSelectItem,
    /**
     *  User has entered characters in search locations search bar
     */
    CTActionSearchLocationsUserDidEnterCharacters,
    /**
     *  User has selected cancel on search locations search bar
     */
    CTActionSearchLocationsUserDidTapCancel,
    /**
     *  User has selected a search location
     */
    CTActionSearchLocationsUserDidTapLocation,
    /**
     *  The user tapped on a date
     */
    CTActionSearchCalendarUserDidTapDate,
    /**
     *  The user discarded the dates
     */
    CTActionSearchCalendarUserDidDiscardDates,
    /**
     *  The user tapped the next button
     */
    CTActionSearchCalendarUserDidTapNext,
    /**
     *  The user selected the select dates textfield
     */
    CTActionSearchCalendarUserDidTapCancel,
    /**
     *  The user selected a time
     */
    CTActionSearchTimePickerUserDidSelectTime,
    /**
     *  The user entered characters in the driver age textfield
     */
    CTActionSearchDriverAgeUserDidEnterCharacters,
    /**
     *  The user tapped the done button on the input view
     */
    CTActionSearchInputViewUserDidSelectDone,
    
    // Vehicle List
    /**
     *  The user tapped the back button
     */
    CTActionVehicleListUserDidTapBack,
    /**
     *  The user tapped a vehicle
     */
    CTActionVehicleListUserDidTapVehicle,
    /**
     *  The user tapped the sort button
     */
    CTActionVehicleListUserDidTapSort,
    /**
     *  The user tapped the filter button
     */
    CTActionVehicleListUserDidTapFilter,
    /**
     *  The user tapped a sort option
     */
    CTActionVehicleListUserDidTapSortOption,
    /**
     *  The user tapped a sort option
     */
    CTActionVehicleListScreenDidScrollToTop,
    /**
     *  The user tapped cancel sort options
     */
    CTActionVehicleListUserDidTapCancelSort,
    /**
     *  The user tapped the apply filter button
     */
    CTActionVehicleListUserDidTapApplyFilter,
    /**
     *  The user tapped the cancel filter button
     */
    CTActionVehicleListUserDidTapCancelFilter,
    /**
     *  The user tapped select all for a filter
     */
    CTActionVehicleListUserDidTapFilterSelectAll,
    /**
     *  The user tapped a filter option
     *  Payload: (CTVehicleListFilterModel *) a filter model
     */
    CTActionVehicleListUserDidTapFilterOption,
    
    // Selected Vehicle
    /**
     *  The user tapped the back button
     *  Payload: nil
     */
    CTActionSelectedVehicleUserDidTapBack,
    /**
     *  The user tapped a tab item
     *  Payload(NSNumber *): Tab index
     */
    CTActionSelectedVehicleUserDidTapTab,
    /**
     *  The user tapped an included item
     *  Payload(NSNumber *): Item index
     */
    CTActionSelectedVehicleUserDidTapIncludedItem,
    /**
     *  The user tapped insurance details
     *  Payload: nil
     */
    CTActionSelectedVehicleUserDidTapInsuranceDetails,
    /**
     *  The user tapped add insurance button
     *  Payload: nil
     */
    CTActionSelectedVehicleUserDidTapAddInsurance,
    /**
     *  The user tapped view all extras
     */
    CTActionSelectedVehicleUserDidTapViewAllExtras,
    /**
     *  The user tapped increment button on an extra
     *  Payload(CTExtraEquipment *): Extra
     */
    CTActionSelectedVehicleUserDidTapIncrementExtra,
    /**
     *  The user tapped decrement extra
     *  Payload(CTExtraEquipment *): Extra
     */
    CTActionSelectedVehicleUserDidTapDecrementExtra,
    /**
     *  The user tapped the extra info button
     *  Payload: nil
     */
    CTActionSelectedVehicleUserDidTapExtraInfo,
    
};
