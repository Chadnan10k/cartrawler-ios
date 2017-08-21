//
//  CTConfirmationViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 19/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTConfirmationViewModel.h"
#import "CTAppState.h"
#import "CartrawlerSDK+NSDateUtils.h"

@interface CTConfirmationViewModel ()
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

@property (nonatomic, readwrite) NSString *paymentSummary;
@property (nonatomic, readwrite) NSString *carRental;
@property (nonatomic, readwrite) NSString *carRentalAmount;
@property (nonatomic, readwrite) NSString *total;
@property (nonatomic, readwrite) NSString *totalAmount;

@property (nonatomic, readwrite) NSString *nextButton;
@end

@implementation CTConfirmationViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTConfirmationViewModel *viewModel = [CTConfirmationViewModel new];
    CTSearchState *searchState = appState.searchState;
    CTBookingState *bookingState = appState.bookingState;
    CTBooking *booking = bookingState.bookingConfirmation;
    
    viewModel.processing = bookingState.wantsBooking && !bookingState.bookingConfirmation && !bookingState.bookingConfirmationError;
    
    viewModel.topMessage = viewModel.processing ? @"We are currently processing your payment." : @"Congratulations! \n Your booking was successful.";
    viewModel.bottomMessage = viewModel.processing ? @"This may take up to 30 seconds. \nPlease sit tight." : [NSString stringWithFormat:@"Your booking reference:\n%@\n\n\n\nWe have sent a confirmation email to designer@cartrawler.com. This may take up to 15 minutes to arrive. Please review your voucher before picking up your car.", booking.confID];
    viewModel.scrollMessage = @"Scroll for details";
    
    viewModel.pickup = @"Pick-up";
    viewModel.pickupLocation = searchState.selectedPickupLocation.name;
    viewModel.pickupTime = [booking.puDateTime stringFromDateWithFormat:@"yyyy-MM-dd-HH:mm"];
    
    viewModel.dropoff = @"Drop-off";
    viewModel.dropoffLocation = booking.puLocationName;
    viewModel.dropoffTime = [booking.doDateTime stringFromDateWithFormat:@"yyyy-MM-dd-HH:mm"];
    
    viewModel.driverDetails = @"Driver Details";
    viewModel.driverName = [NSString stringWithFormat:@"%@ %@", booking.customerGivenName, booking.customerSurname];
    viewModel.driverEmail = booking.customerEmail;
    
    viewModel.insurance = @"Insurance";
    
    return viewModel;
}

@end
