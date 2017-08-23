//
//  CTBookingTableViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 19/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTBookingTableViewModel.h"
#import "CTAppState.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CartrawlerSDK+NSNumber.h"

@interface CTBookingTableViewModel ()
@property (nonatomic, readwrite) UIColor *primaryColor;

@property (nonatomic, readwrite) BOOL processing;
@property (nonatomic, readwrite) NSString *topMessage;
@property (nonatomic, readwrite) NSString *bottomMessage;
@property (nonatomic, readwrite) NSString *scrollMessage;

@property (nonatomic, readwrite) NSString *pickup;
@property (nonatomic, readwrite) NSString *pickupLocation;
@property (nonatomic, readwrite) NSString *pickupTime;

@property (nonatomic, readwrite) NSString *dropoff;
@property (nonatomic, readwrite) NSString *dropoffLocation;
@property (nonatomic, readwrite) NSString *dropoffTime;

@property (nonatomic, readwrite) NSString *driverDetails;
@property (nonatomic, readwrite) NSString *driverName;
@property (nonatomic, readwrite) NSString *driverEmail;
@property (nonatomic, readwrite) NSString *driverPhoneNumber;

@property (nonatomic, readwrite) NSString *insurance;
@property (nonatomic, readwrite) NSString *insuranceIncluded;

@property (nonatomic, readwrite) NSString *vehicleSummary;
@property (nonatomic, readwrite) NSString *vehicle;
@property (nonatomic, readwrite) NSString *orSimilar;
@property (nonatomic, readwrite) NSString *seats;
@property (nonatomic, readwrite) NSString *bags;
@property (nonatomic, readwrite) NSString *doors;
@property (nonatomic, readwrite) NSString *transmission;
@property (nonatomic, readwrite) NSString *extraFeature;
@property (nonatomic, readwrite) NSURL *vehicleURL;
@property (nonatomic, readwrite) NSURL *vendorURL;

@property (nonatomic, readwrite) NSString *paymentSummary;
@property (nonatomic, readwrite) NSString *carRental;
@property (nonatomic, readwrite) NSString *carRentalAmount;
@property (nonatomic, readwrite) BOOL displayInsurance;
@property (nonatomic, readwrite) NSString *insuranceCostItem;
@property (nonatomic, readwrite) NSString *insuranceAmount;
@property (nonatomic, readwrite) NSString *total;
@property (nonatomic, readwrite) NSString *totalAmount;

@property (nonatomic, readwrite) NSString *nextButton;
@end

@implementation CTBookingTableViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchState *searchState = appState.searchState;
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    CTBookingState *bookingState = appState.bookingState;
    CTBooking *booking = bookingState.bookingConfirmation;
    CTReservationsState *reservationsState = appState.reservationsState;
    
    // We use the same view for viewing existing reservations and booking confirmations
    if (reservationsState.selectedReservation) {
        return [self viewModelForReservation:appState];
    }
    
    CTBookingTableViewModel *viewModel = [CTBookingTableViewModel new];
    
    viewModel.primaryColor = appState.userSettingsState.primaryColor;
    
    viewModel.processing = bookingState.wantsBooking && !bookingState.bookingConfirmation && !bookingState.bookingConfirmationError;
    
    viewModel.topMessage = viewModel.processing ? @"We are currently processing your payment." : @"Congratulations! \n Your booking was successful.";
    viewModel.bottomMessage = viewModel.processing ? @"This may take up to 30 seconds. \nPlease sit tight." : [NSString stringWithFormat:@"Your booking reference:\n%@\n\n\n\nWe have sent a confirmation email to designer@cartrawler.com. This may take up to 15 minutes to arrive. Please review your voucher before picking up your car.", booking.confID];
    viewModel.scrollMessage = @"Scroll for details";
    
    viewModel.pickup = @"Pick-up";
    viewModel.pickupLocation = booking.puLocationName;
    viewModel.pickupTime = [NSString stringWithFormat:@"%@, %@", [searchState.selectedPickupTime simpleTimeString], [searchState.selectedPickupDate shortDescriptionFromDate]];
    
    viewModel.dropoff = @"Drop-off";
    viewModel.dropoffLocation = booking.doLocationName;
    viewModel.dropoffTime = [NSString stringWithFormat:@"%@, %@", [searchState.selectedDropoffTime simpleTimeString], [searchState.selectedDropoffDate shortDescriptionFromDate]];
    
    viewModel.driverDetails = @"Driver Details";
    viewModel.driverName = [NSString stringWithFormat:@"%@ %@", booking.customerGivenName, booking.customerSurname];
    viewModel.driverEmail = bookingState.emailAddress;
    viewModel.driverPhoneNumber = [NSString stringWithFormat:@"+%@ %@", bookingState.prefix, bookingState.phoneNumber];
    
    viewModel.insurance = @"Insurance";
    viewModel.insuranceIncluded = selectedVehicleState.insuranceAdded ? @"Included" : @"Not included";
    
    viewModel.vehicle = booking.vehMakeModelName;
    viewModel.seats = [NSString stringWithFormat:@"%@ %@", booking.vehPassengerQty, CTLocalizedString(CTRentalVehiclePassengers)];
    viewModel.doors = [NSString stringWithFormat:@"%@ %@", booking.vehDoorCount, CTLocalizedString(CTRentalVehicleDoors)];
    viewModel.bags = [NSString stringWithFormat:@"%@ %@", booking.vehBaggageQty, CTLocalizedString(CTRentalVehicleBags)];
    viewModel.transmission = booking.vehTransmissionType;
    
    viewModel.vehicleURL = appState.selectedVehicleState.selectedAvailabilityItem.vehicle.pictureURL;
    viewModel.vendorURL = booking.vendorImageUrl;
    
    viewModel.carRental = @"Car rental";
    for (CTFee *fee in booking.fees) {
        if (fee.feePurpose == CTFeeTypePayNow) {
            
        }
    }
    viewModel.total = @"Total";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:booking.currencyCode];
    viewModel.totalAmount = [NSString stringWithFormat:@"%@%@", [locale displayNameForKey:NSLocaleCurrencySymbol value:booking.currencyCode], booking.totalChargeAmount];
    return viewModel;
}

+ (instancetype)viewModelForReservation:(CTAppState *)appState {
    CTBookingTableViewModel *viewModel = [CTBookingTableViewModel new];
    viewModel.primaryColor = appState.userSettingsState.primaryColor;
    
    CTRentalBooking *booking = appState.reservationsState.selectedReservation;
    viewModel.topMessage = @"Here is your itinerary";
    viewModel.bottomMessage = [NSString stringWithFormat:@"Your booking reference:\n%@\n\n\n", booking.bookingId];
    viewModel.scrollMessage = @"Scroll for details";
    
    viewModel.pickupLocation = booking.pickupLocation;
    viewModel.dropoffLocation = booking.dropoffLocation;
    viewModel.pickupTime = [NSString stringWithFormat:@"%@, %@", [booking.pickupDate simpleTimeString], [booking.pickupDate shortDescriptionFromDate]];
    viewModel.dropoffTime = [NSString stringWithFormat:@"%@, %@", [booking.dropoffDate simpleTimeString], [booking.dropoffDate shortDescriptionFromDate]];
    viewModel.driverName = booking.driverName;
    viewModel.driverEmail = booking.driverEmail;
    viewModel.driverPhoneNumber = booking.driverPhoneNumber;
    viewModel.insuranceIncluded = booking.insuranceIncluded;
    viewModel.vehicle = booking.vehicleName;
    viewModel.seats = booking.seats;
    viewModel.bags = booking.bags;
    viewModel.doors = booking.doors;
    viewModel.transmission = booking.transmission;
    viewModel.vehicleURL = [NSURL URLWithString:booking.vehicleURL];
    viewModel.vendorURL = [NSURL URLWithString:booking.vendorURL];
    viewModel.carRentalAmount = booking.carRentalAmount;
    viewModel.insuranceAmount = booking.insuranceAmount;
    viewModel.totalAmount = booking.totalAmount;
    
    return viewModel;
}

@end
