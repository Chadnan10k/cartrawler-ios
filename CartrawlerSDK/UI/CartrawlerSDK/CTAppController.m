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
#import "CTNotificationsController.h"
#import "CTLoggingController.h"
#import "CTPaymentController.h"
#import "CTValidationSearch.h"

#import "CartrawlerSDK+NSDateUtils.h"
#import "CTCSVItem.h"

@interface CTAppController ()
@property (nonatomic) CTAppState *appState;

@property (nonatomic) CTAPIController *apiController;
@property (nonatomic) CTUserInterfaceController *userInterfaceController;
@property (nonatomic) CTNotificationsController *notificationsController;
@property (nonatomic) CTLoggingController *loggingController;
@property (nonatomic) CTPaymentController *paymentController;
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
    CTBookingState *bookingState = appState.bookingState;
    
    [self.loggingController logAction:action payload:payload];
    
    switch (action) {
        case CTActionInitialiseState:
            self.appState = [CTAppState new];
            self.appState.userSettingsState = [CTUserSettingsState new];
            self.appState.APIState = [CTAPIState new];
            self.appState.navigationState = [CTNavigationState new];
            self.appState.searchState = [CTSearchState new];
            self.appState.vehicleListState = [CTVehicleListState new];
            // TODO: Only create states when needed above
            
            self.apiController = [CTAPIController new];
            self.userInterfaceController = [CTUserInterfaceController new];
            self.notificationsController = [CTNotificationsController new];
            self.loggingController = [CTLoggingController new];
            
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
        case CTActionUserSettingsUserDidShake:
            switch (userSettingsState.selectedStyle) {
                case CTUserSettingsStyleNoStyle:
                    userSettingsState.selectedStyle = CTUserSettingsStyleGeneric;
                    userSettingsState.primaryColor = [UIColor colorWithRed:0 green:0.51 blue:0.5 alpha:1.0];
                    userSettingsState.secondaryColor = [UIColor colorWithRed:0 green:0.24 blue:0.44 alpha:1.0];
                    userSettingsState.illustrationColor = userSettingsState.primaryColor;
                    break;
                case CTUserSettingsStyleGeneric:
                    userSettingsState.selectedStyle = CTUserSettingsStyleRyanair;
                    userSettingsState.primaryColor = [UIColor colorWithRed:0.05 green:0.22 blue:0.57 alpha:1.0];
                    userSettingsState.secondaryColor = [UIColor colorWithRed:0.94 green:0.78 blue:0.27 alpha:1.0];
                    userSettingsState.illustrationColor = userSettingsState.secondaryColor;
                    break;
                case CTUserSettingsStyleRyanair:
                    userSettingsState.selectedStyle = CTUserSettingsStyleNoStyle;
                    userSettingsState.primaryColor = [UIColor colorWithRed:0.16 green:0.66 blue:0.88 alpha:1.0];
                    userSettingsState.secondaryColor = [UIColor colorWithRed:0.13 green:0.27 blue:0.43 alpha:1.0];
                    userSettingsState.illustrationColor = userSettingsState.primaryColor;
                    break;
                default:
                    break;
            }
            break;
            
        // Notification Actions
        case CTActionNotificationUserInputDidShow:
            userSettingsState.keyboardShowing = YES;
            userSettingsState.keyboardHeight = payload;
            break;
        case CTActionNotificationUserInputDidHide:
            userSettingsState.keyboardShowing = NO;
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
            
            BOOL userWantsNextStep = searchState.wantsNextStep;
            BOOL isLatestRequest = [payload objectForKey:APIState.availabilityRequestTimestamp] != nil;
            
            if (userWantsNextStep && isLatestRequest) {
                NSLog(@"Got here");
                navigationState.modalViewControllers = @[];
                navigationState.currentNavigationStep = CTNavigationStepVehicleList;
                searchState.wantsNextStep = NO;
            } else {
                NSLog(@"Here");
            }
            break;
        case CTActionAPIDidReturnVehiclesError:
            searchState.vehicleSearchError = payload;
            if (searchState.wantsNextStep) {
                navigationState.modalViewControllers = @[];
            }
            break;
        case CTActionAPIDidReturnInsurance:
            selectedVehicleState.insurance = payload;
            break;
        case CTActionAPIDidReturnInsuranceError:
            
            break;
            
        // Navigation Actions
        case CTActionNavigationSetParentViewController:
            navigationState.parentViewController = payload;
            break;
        case CTActionNavigationPresentSearchStep:
            navigationState.currentNavigationStep = CTNavigationStepSearch;
            
            // Initialise user settings state
            // TODO: Extract, this is redundant
            userSettingsState.primaryColor = [UIColor colorWithRed:0.16 green:0.66 blue:0.88 alpha:1.0];
            userSettingsState.secondaryColor = [UIColor colorWithRed:0.13 green:0.27 blue:0.43 alpha:1.0];
            userSettingsState.illustrationColor = userSettingsState.primaryColor;
            
            // Initialise search state
            searchState.selectedPickupTime = [NSDate dateWithHour:10 minute:0];
            searchState.selectedDropoffTime = [NSDate dateWithHour:10 minute:0];
            break;
        case CTActionNavigationModalDidPresent:
            NSLog(@"%@", navigationState.modalViewControllers);
            break;
        case CTActionNavigationModalDidDismiss:
            if (searchState.wantsNextStep && searchState.vehicleSearchError) {
                navigationState.modalViewControllers = @[@(CTNavigationModalSearchVehicleFetchError)];
            }
            break;
        
        // Search Actions
        case CTActionSearchUserDidSwipeUSPCarousel:
            searchState.uspPageIndex = [payload integerValue];
            break;
        case CTActionSearchUserDidTapCloseButton:
            navigationState.currentNavigationStep = CTNavigationStepNone;
            break;
        case CTActionSearchUserDidTapSettingsButton:
            navigationState.modalViewControllers = @[@(CTNavigationModalSearchSettings)];
            break;
        case CTActionSearchUserDidTapPickupTextField:
            searchState.wantsNextStep = NO;
            navigationState.modalViewControllers = @[@(CTNavigationModalSearchLocations)];
            searchState.selectedTextField = CTSearchFormTextFieldPickupLocation;
            break;
        case CTActionSearchUserDidTapDropoffTextField:
            searchState.wantsNextStep = NO;
            searchState.selectedTextField = CTSearchFormTextFieldDropoffLocation;
            break;
        case CTActionSearchUserDidToggleReturnToSameLocation:
            searchState.wantsNextStep = NO;
            searchState.dropoffLocationRequired = !searchState.dropoffLocationRequired;
            break;
        case CTActionSearchUserDidTapDatesTextField:
            searchState.wantsNextStep = NO;
            navigationState.modalViewControllers = @[@(CTNavigationModalSearchCalendar)];
            searchState.displayedPickupDate = nil;
            searchState.displayedDropoffDate = nil;
            break;
        case CTActionSearchUserDidTapPickupTimeTextField:
            searchState.wantsNextStep = NO;
            searchState.scrollAboveUserInput = YES;
            searchState.selectedTextField = CTSearchFormTextFieldPickupTime;
            break;
        case CTActionSearchUserDidTapDropoffTimeTextField:
            searchState.wantsNextStep = NO;
            searchState.scrollAboveUserInput = YES;
            searchState.selectedTextField = CTSearchFormTextFieldDropoffTime;
            break;
        case CTActionSearchUserDidTapAgeTextField:
            searchState.wantsNextStep = NO;
            searchState.selectedTextField = CTSearchFormTextFieldDriverAge;
            break;
        case CTActionSearchUserDidToggleDriverAge:
            searchState.wantsNextStep = NO;
            searchState.driverAgeRequired = !searchState.driverAgeRequired;
            searchState.selectedTextField = searchState.driverAgeRequired ? CTSearchFormTextFieldDriverAge : CTSearchFormTextFieldNone;
            searchState.scrollAboveUserInput = searchState.driverAgeRequired;
            
            [self requestVehicleAvailability:appState];
            break;
        case CTActionSearchUserDidTapNext:
            searchState.selectedTextField = CTSearchFormTextFieldNone;
            searchState.wantsNextStep = YES;
            
            if ([CTValidationSearch validateSearchStep:searchState]) {
                if ([APIState.matchedAvailabilityItems objectForKey:APIState.availabilityRequestTimestamp]) {
                    navigationState.currentNavigationStep = CTNavigationStepVehicleList;
                    searchState.wantsNextStep = NO;
                } else if (searchState.vehicleSearchError) {
                    navigationState.modalViewControllers = @[@(CTNavigationModalSearchVehicleFetchError)];
                } else {
                    navigationState.modalViewControllers = @[@(CTNavigationModalSearchInterstitial)];
                }
            }
            break;
        case CTActionSearchUserDidTapBack:
            navigationState.currentNavigationStep = CTNavigationStepNone;
            break;
        case CTActionSearchViewDidScrollAboveUserInput:
            searchState.scrollAboveUserInput = NO;
            return;
        case CTActionSearchSettingsUserDidTapCloseButton:
            navigationState.modalViewControllers = @[];
            break;
        case CTActionSearchSettingsUserDidTapCountryButton:
            searchState.selectedSettings = CTSearchSearchSettingsCountry;
            navigationState.modalViewControllers = @[@(CTNavigationModalSearchSettings), @(CTNavigationModalSearchSettingsSelection)];
            break;
        case CTActionSearchSettingsUserDidTapLanguageButton:
            searchState.selectedSettings = CTSearchSearchSettingsLanguage;
            navigationState.modalViewControllers = @[@(CTNavigationModalSearchSettings), @(CTNavigationModalSearchSettingsSelection)];
            break;
        case CTActionSearchSettingsUserDidTapCurrencyButton:
            searchState.selectedSettings = CTSearchSearchSettingsCurrency;
            navigationState.modalViewControllers = @[@(CTNavigationModalSearchSettings), @(CTNavigationModalSearchSettingsSelection)];
            break;
        case CTActionSearchSettingsDetailsUserDidTapCancelButton:
            if (navigationState.currentNavigationStep == CTNavigationStepSearch) {
                navigationState.modalViewControllers = @[@(CTNavigationModalSearchSettings)];
            }
            if (navigationState.currentNavigationStep == CTNavigationStepBooking) {
                navigationState.modalViewControllers = @[];
                bookingState.selectedTextfield = CTBookingTextfieldNone;
            }
            
            break;
        case CTActionSearchSettingsDetailsUserDidSelectItem:
            switch (searchState.selectedSettings) {
                case CTSearchSearchSettingsCountry:
                    if (navigationState.currentNavigationStep == CTNavigationStepSearch) {
                        userSettingsState.countryCode = [[(CTCSVItem *)payload code] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [self requestVehicleAvailability:appState];
                        navigationState.modalViewControllers = @[@(CTNavigationModalSearchSettings)];
                    }
                    if (navigationState.currentNavigationStep == CTNavigationStepBooking) {
                        bookingState.country = payload;
                        navigationState.modalViewControllers = @[];
                        bookingState.selectedTextfield = CTBookingTextfieldPayment;
                    }
                    break;
                case CTSearchSearchSettingsLanguage:
                    // TODO: Fix the inversion of code and name in the language CSV
                    userSettingsState.languageCode = [[(CTCSVItem *)payload name] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    [self requestVehicleAvailability:appState];
                    navigationState.modalViewControllers = @[@(CTNavigationModalSearchSettings)];
                    break;
                case CTSearchSearchSettingsCurrency:
                    userSettingsState.currencyCode = [[(CTCSVItem *)payload code] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    [self requestVehicleAvailability:appState];
                    navigationState.modalViewControllers = @[@(CTNavigationModalSearchSettings)];
                    break;
                default:
                    break;
            }
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
            navigationState.modalViewControllers = @[];
            break;
        case CTActionSearchLocationsUserDidTapLocation:
            if (searchState.selectedTextField == CTSearchFormTextFieldPickupLocation) {
                searchState.selectedPickupLocation = payload;
            }
            if (searchState.selectedTextField == CTSearchFormTextFieldDropoffLocation) {
                searchState.selectedDropoffLocation = payload;
            }
            searchState.searchBarText = @"";
            navigationState.modalViewControllers = @[];
            searchState.selectedTextField = CTSearchFormTextFieldNone;
            
            [self requestVehicleAvailability:appState];
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
            navigationState.modalViewControllers = @[];
            
            [self requestVehicleAvailability:appState];
            break;
        case CTActionSearchCalendarUserDidTapCancel:
            searchState.selectedTextField = CTSearchFormTextFieldNone;
            navigationState.modalViewControllers = @[];
            break;
        case CTActionSearchTimePickerUserDidSelectTime:
            if (searchState.selectedTextField == CTSearchFormTextFieldPickupTime) {
                searchState.selectedPickupTime = payload;
            }
            if (searchState.selectedTextField == CTSearchFormTextFieldDropoffTime) {
                searchState.selectedDropoffTime = payload;
            }
            
            [self requestVehicleAvailability:appState];
            break;
        case CTActionSearchDriverAgeUserDidEnterCharacters:
            if ([(NSString *)payload length] <= 2) {
                searchState.displayedDriverAge = payload;
            }
            [self requestVehicleAvailability:appState];
            break;
        case CTActionSearchInputViewUserDidSelectDone:
            searchState.selectedTextField = CTSearchFormTextFieldNone;
            break;
        case CTActionSearchUserDidDismissVehicleFetchError:
            searchState.wantsNextStep = NO;
            navigationState.modalViewControllers = @[];
            break;
        
        // Vehicle List Actions
        case CTActionVehicleListUserDidTapBack:
            navigationState.currentNavigationStep = CTNavigationStepSearch;
            appState.vehicleListState = [CTVehicleListState new];
            break;
        case CTActionVehicleListUserDidTapVehicle: {
            appState.selectedVehicleState = [CTSelectedVehicleState new];
            appState.selectedVehicleState.selectedAvailabilityItem = payload;
            appState.selectedVehicleState.addedExtras = [NSMutableArray new];
            appState.selectedVehicleState.flippedExtras = [NSMutableArray new];
            [appState.selectedVehicleState.selectedAvailabilityItem.vehicle.extraEquipment enumerateObjectsUsingBlock:^(CTExtraEquipment * _Nonnull extra, NSUInteger idx, BOOL * _Nonnull stop) {
                appState.selectedVehicleState.addedExtras[idx] = extra.isIncludedInRate ? @1 : @0;
                appState.selectedVehicleState.flippedExtras[idx] = @0;
            }];
            navigationState.currentNavigationStep = CTNavigationStepSelectedVehicle;
            [self.apiController requestInsuranceForSelectedVehicleWithState:appState];
        }
            break;
        case CTActionVehicleListUserDidTapSort:
            vehicleListState.selectedView = CTVehicleListSelectedViewSort;
            break;
        case CTActionVehicleListUserDidTapFilter:
            navigationState.modalViewControllers = @[@(CTNavigationModalVehicleListFilter)];
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
            navigationState.modalViewControllers = @[];
            break;
        case CTActionVehicleListUserDidTapApplyFilter:
            navigationState.modalViewControllers = @[];
            vehicleListState.scrollToTop = YES;
            break;
        case CTActionVehicleListUserDidTapFilterOption:
            if ([vehicleListState.selectedFilters containsObject:payload]) {
                [vehicleListState.selectedFilters removeObject:payload];
            } else {
                [vehicleListState.selectedFilters addObject:payload];
            }
            break;
            
        // Selected Vehicle Actions
        case CTActionSelectedVehicleUserDidTapBack:
            navigationState.currentNavigationStep = CTNavigationStepVehicleList;
            appState.selectedVehicleState = nil;
            break;
        case CTActionSelectedVehicleUserDidTapTab:
            selectedVehicleState.selectedTab = [payload integerValue];
            break;
        case CTActionSelectedVehicleUserDidTapIncludedItem:
            switch ([payload integerValue]) {
                case CTSelectedVehicleExpandedPickupLocation:
                    selectedVehicleState.pickupLocationExpanded = !selectedVehicleState.pickupLocationExpanded;
                    break;
                case CTSelectedVehicleExpandedFuelPolicy:
                    selectedVehicleState.fuelPolicyExpanded = !selectedVehicleState.fuelPolicyExpanded;
                    break;
                case CTSelectedVehicleExpandedMileageAllowance:
                    selectedVehicleState.mileageAllowanceExpanded = !selectedVehicleState.mileageAllowanceExpanded;
                    break;
                case CTSelectedVehicleExpandedInsurance:
                    selectedVehicleState.insuranceExpanded = !selectedVehicleState.insuranceExpanded;
                    break;
                default:
                    break;
            }
            break;
        case CTActionSelectedVehicleUserDidTapInsuranceDetails:
            break;
        case CTActionSelectedVehicleUserDidTapAddInsurance:
            selectedVehicleState.insuranceAdded = !selectedVehicleState.insuranceAdded;
            break;
        case CTActionSelectedVehicleUserDidTapViewAllExtras:
            break;
        case CTActionSelectedVehicleUserDidTapIncrementExtra: {
            NSInteger index = [selectedVehicleState.selectedAvailabilityItem.vehicle.extraEquipment indexOfObject:payload];
            NSNumber *count = selectedVehicleState.addedExtras[index];
            if (count.integerValue < 4) {
                selectedVehicleState.addedExtras[index] = @(count.integerValue + 1);
            }
        }
            break;
        case CTActionSelectedVehicleUserDidTapDecrementExtra: {
            NSInteger index = [selectedVehicleState.selectedAvailabilityItem.vehicle.extraEquipment indexOfObject:payload];
            NSNumber *count = selectedVehicleState.addedExtras[index];
            NSInteger minimumQuantity = [(CTExtraEquipment *)payload isIncludedInRate] ? 1 : 0;
            if (count.integerValue > minimumQuantity) {
                selectedVehicleState.addedExtras[index] = @(count.integerValue - 1);
            }
        }
            break;
        case CTActionSelectedVehicleUserDidTapExtraInfo: {
            NSInteger index = [selectedVehicleState.selectedAvailabilityItem.vehicle.extraEquipment indexOfObject:payload];
            BOOL flipped = selectedVehicleState.flippedExtras[index].integerValue;
            selectedVehicleState.flippedExtras[index] =  @(!flipped);
            break;
        }
        case CTActionSelectedVehicleUserDidTapNext:
            navigationState.currentNavigationStep = CTNavigationStepBooking;
            appState.bookingState = [CTBookingState new];
            break;
            
        // Booking
        
        case CTActionBookingPaymentContainerViewDidLoad:
            self.paymentController = [[CTPaymentController alloc] initWithContainerView:payload];
            break;
        case CTActionBookingUserDidTapFirstName:
            bookingState.selectedTextfield = CTBookingTextfieldFirstName;
            break;
        case CTActionBookingUserDidTapLastName:
            bookingState.selectedTextfield = CTBookingTextfieldLastName;
            break;
        case CTActionBookingUserDidTapEmailAddress:
            bookingState.selectedTextfield = CTBookingTextfieldEmailAddress;
            break;
        case CTActionBookingUserDidTapPrefix:
            bookingState.selectedTextfield = CTBookingTextfieldPrefix;
            break;
        case CTActionBookingUserDidTapPhoneNumber:
            bookingState.selectedTextfield = CTBookingTextfieldPhoneNumber;
            break;
        case CTActionBookingUserDidTapFlightNumber:
            bookingState.selectedTextfield = CTBookingTextfieldFlightNumber;
            break;
        case CTActionBookingUserDidTapAddressLine1:
            bookingState.selectedTextfield = CTBookingTextfieldAddressLine1;
            break;
        case CTActionBookingUserDidTapAddressLine2:
            bookingState.selectedTextfield = CTBookingTextfieldAddressLine2;
            break;
        case CTActionBookingUserDidTapCity:
            bookingState.selectedTextfield = CTBookingTextfieldCity;
            break;
        case CTActionBookingUserDidTapPostcode:
            bookingState.selectedTextfield = CTBookingTextfieldPostcode;
            break;
        case CTActionBookingUserDidTapCountry:
            bookingState.selectedTextfield = CTBookingTextfieldCountry;
            navigationState.modalViewControllers = @[@(CTNavigationModalSearchSettingsSelection)];
            // TODO: Extract to shared state
            searchState.selectedSettings = CTSearchSearchSettingsCountry;
            break;
        case CTActionBookingUserDidTapRentalConditions:
            break;
        case CTActionBookingUserDidTapTermsAndConditions:
            break;
        case CTActionBookingUserDidEnterCharacters:
            switch (bookingState.selectedTextfield) {
                case CTBookingTextfieldFirstName:
                    bookingState.firstName = payload;
                    break;
                case CTBookingTextfieldLastName:
                    bookingState.lastName = payload;
                    break;
                case CTBookingTextfieldEmailAddress:
                    bookingState.emailAddress = payload;
                    break;
                case CTBookingTextfieldPrefix:
                    bookingState.prefix = [payload stringByReplacingOccurrencesOfString:@"+" withString:@""];
                    break;
                case CTBookingTextfieldPhoneNumber:
                    bookingState.phoneNumber = payload;
                    break;
                case CTBookingTextfieldFlightNumber:
                    bookingState.flightNumber = payload;
                    break;
                case CTBookingTextfieldAddressLine1:
                    bookingState.addressLine1 = payload;
                    break;
                case CTBookingTextfieldAddressLine2:
                    bookingState.addressLine2 = payload;
                    break;
                case CTBookingTextfieldCity:
                    bookingState.city = payload;
                    break;
                case CTBookingTextfieldPostcode:
                    bookingState.postcode = payload;
                    break;
                default:
                    break;
            }
            break;
        case CTActionBookingInputViewUserDidSelectCancel:
            bookingState.selectedTextfield = CTBookingTextfieldNone;
            break;
        case CTActionBookingUserDidEndEditingTextfield:
            bookingState.selectedTextfield = CTBookingTextfieldNone;
            break;
        case CTActionBookingInputViewUserDidSelectDone:
            if (bookingState.selectedTextfield == CTBookingTextfieldFlightNumber) {
                bookingState.selectedTextfield = selectedVehicleState.insuranceAdded ? CTBookingTextfieldAddressLine1 : CTBookingTextfieldPayment;
                break;
            }
            bookingState.selectedTextfield++;
            break;
        case CTActionBookingUserDidTapNext:
              [self.paymentController makePaymentWithState:appState];
            break;
        case CTActionBookingUserDidTapBack:
            navigationState.currentNavigationStep = CTNavigationStepSelectedVehicle;
            appState.bookingState = nil;
            break;
        default:
            break;
    }
    [self.userInterfaceController updateWithAppState:appState];
}

- (void)requestVehicleAvailability:(CTAppState *)appState {
    CTSearchState *searchState = appState.searchState;
    CTAPIState *APIState = appState.APIState;
    if ([CTValidationSearch validateSearchStep:searchState]) {
        searchState.vehicleSearchError = nil;
        APIState.availabilityRequestTimestamp = [NSDate currentTimestamp];
        [self.apiController requestVehicleAvailabilityWithState:appState];
    } else {
        APIState.availabilityRequestTimestamp = nil;
    }
}

@end
