//
//  CTBookingErrorViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 17/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTBookingErrorViewModel.h"
#import "CTAppController.h"

@implementation CTBookingErrorViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTBookingState *bookingState = appState.bookingState;
    CTBooking *bookingConfirmation = bookingState.bookingConfirmation;
    NSError *error = bookingState.bookingConfirmationError;
    
    CTAlertAction *action = [CTAlertAction actionWithTitle:@"OK" handler:^(CTAlertAction *action) {
        [CTAppController dispatchAction:CTActionSearchUserDidDismissVehicleFetchError payload:nil];
    }];
    
    NSString *title;
    NSString *message;
    if (bookingConfirmation) {
        title = @"Success";
        message = [NSString stringWithFormat:@"Booking Confirmation: %@", bookingConfirmation.confID];
    } else if (bookingState.bookingConfirmationError) {
        title = @"Error";
        message = error.userInfo[@"Errors"][@"Error"][@"@ShortText"];
    }
    
    
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:message];
    
    CTBookingErrorViewModel *viewModel = [[CTBookingErrorViewModel alloc] initWithTitle:title message:text action:action];
    return viewModel;
}

@end
