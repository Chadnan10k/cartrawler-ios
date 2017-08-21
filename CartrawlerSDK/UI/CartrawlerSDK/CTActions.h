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
    /**
     *  API returned vehicle fetch error
     */
    CTActionAPIDidReturnVehiclesError,
    /**
     *  API returned vehicle insurance
     */
    CTActionAPIDidReturnInsurance,
    /**
     *  API returned vehicle insurance error
     */
    CTActionAPIDidReturnInsuranceError,
    
    // NAVIGATION ACTIONS
    /**
     *  Sets the parent view controller
     */
    CTActionNavigationSetParentViewController,
    /**
     *  Requests the search step
     */
    CTActionNavigationPresentSearchStep,
    /**
     *  Modal view completed presentation
     */
    CTActionNavigationModalDidPresent,
    /**
     *  Modal view dismissed
     */
    CTActionNavigationModalDidDismiss,
    
    // Search Actions
    /**
     *  The user selected an existing reservation
     *  Payload: a CTRentalBooking object
     */
    CTActionSearchUserDidSelectReservation,
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
    /**
     *  User dismissed error alert
     */
    CTActionSearchUserDidDismissVehicleFetchError,
    
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
    /**
     *  The user tapped the next button
     *  Payload: nil
     */
    CTActionSelectedVehicleUserDidTapNext,
    
    // Booking
    /**
     *  The system created a payment container view
     *  Payload: a payment container view
     */
    CTActionBookingPaymentContainerViewDidLoad,
    /**
     *  The user tapped the first name textfield
     *  Payload: nil
     */
    CTActionBookingUserDidTapFirstName,
    /**
     *  The user tapped the last name textfield
     *  Payload: nil
     */
    CTActionBookingUserDidTapLastName,
    /**
     *  The user tapped the email address textfield
     *  Payload: nil
     */
    CTActionBookingUserDidTapEmailAddress,
    /**
     *  The user tapped the prefix textfield
     *  Payload: nil
     */
    CTActionBookingUserDidTapPrefix,
    /**
     *  The user tapped the phone number textfield
     *  Payload: nil
     */
    CTActionBookingUserDidTapPhoneNumber,
    /**
     *  The user tapped the flight number textfield
     *  Payload: nil
     */
    CTActionBookingUserDidTapFlightNumber,
    /**
     *  The user tapped the address line 1 textfield
     *  Payload: nil
     */
    CTActionBookingUserDidTapAddressLine1,
    /**
     *  The user tapped the address line 2 textfield
     *  Payload: nil
     */
    CTActionBookingUserDidTapAddressLine2,
    /**
     *  The user tapped the city textfield
     *  Payload: nil
     */
    CTActionBookingUserDidTapCity,
    /**
     *  The user tapped the postcode textfield
     *  Payload: nil
     */
    CTActionBookingUserDidTapPostcode,
    /**
     *  The user tapped the country textfield
     *  Payload: nil
     */
    CTActionBookingUserDidTapCountry,
    /**
     *  The user tapped rental conditions
     *  Payload: nil
     */
    CTActionBookingUserDidTapRentalConditions,
    /**
     *  The user tapped terms and conditions
     *  Payload: nil
     */
    CTActionBookingUserDidTapTermsAndConditions,
    /**
     *  The user entered characters
     *  Payload(NSString *): textfield input
     */
    CTActionBookingUserDidEnterCharacters,
    /**
     *  The user selected cancel on the input view
     *  Payload: nil
     */
    CTActionBookingInputViewUserDidSelectCancel,
    /**
     *  The user ended editing a textfield
     *  Payload: nil
     */
    CTActionBookingUserDidEndEditingTextfield,
    /**
     *  The user selected done on the input view
     *  Payload: nil
     */
    CTActionBookingInputViewUserDidSelectDone,
    /**
     *  The user tapped the next button
     *  Payload: nil
     */
    CTActionBookingUserDidTapNext,
    /**
     *  The user tapped the back button
     *  Payload: nil
     */
    CTActionBookingUserDidTapBack,
    /**
     *  The user tapped the back button
     *  Payload: nil
     */
    CTActionBookingValidationAnimationFinished,
    /**
     *  The payment API returned success
     *  Payload: nil
     */
    CTActionBookingAPIReturnedSuccess,
    /**
     *  The payment API returned an error
     *  Payload: the error
     */
    CTActionBookingAPIReturnedError,
    /**
     *  The user tapped next on the booking confirmation page
     *  Payload: nil
     */
    CTActionBookingConfirmationUserTappedNext,
    
};
