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
    // USER ACTIONS
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
    
    // SEARCH ACTIONS
    /**
     *  The user tapped the pickup textfield
     */
    CTActionSearchUserDidTapPickupTextField,
    /**
     *  The user tapped the dropoff textfield
     */
    CTActionSearchUserDidTapDropoffTextField,
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
     *  The user tapped the next button
     */
    CTActionSearchUserDidTapNext,
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
     *  The user dismissed the time picker
     */
    CTActionSearchTimePickerUserDidSelectCancel,
};
