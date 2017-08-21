//
//  CTBookingModalViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 21/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTBookingModalViewModel.h"

@interface CTBookingModalViewModel ()
@property (nonatomic, readwrite) CTBookingTableViewModel *bookingTableViewModel;
@property (nonatomic, readwrite) UIColor *buttonColor;
@property (nonatomic, readwrite) UIColor *buttonContainerColor;
@property (nonatomic, readwrite) NSString *button;
@property (nonatomic, readwrite) BOOL buttonEnabled;
@end

@implementation CTBookingModalViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTBookingModalViewModel *viewModel = [CTBookingModalViewModel new];
    
    CTBookingState *bookingState = appState.bookingState;
    
    viewModel.bookingTableViewModel = [CTBookingTableViewModel viewModelForState:appState];
    
    
    BOOL processing = bookingState.wantsBooking && !bookingState.bookingConfirmation && !bookingState.bookingConfirmationError;
    viewModel.button = processing ? @"" : @"Back to homepage";
    viewModel.buttonColor = processing ? [UIColor clearColor] : appState.userSettingsState.secondaryColor;
    viewModel.buttonEnabled = !processing;
    viewModel.buttonContainerColor = processing ? appState.userSettingsState.primaryColor : [UIColor whiteColor];
    
    
    return viewModel;
}

@end
