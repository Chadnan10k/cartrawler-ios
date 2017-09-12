//
//  CTSearchSplashViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchSplashViewModel.h"
#import "CTAppState.h"

@interface CTSearchSplashViewModel ()
@property (nonatomic, readwrite) UIColor *splashColor;
@property (nonatomic, readwrite) UIColor *illustrationColor;
@property (nonatomic, readwrite) NSString *splashText;
@property (nonatomic, readwrite) NSString *searchBoxText;
@property (nonatomic, readwrite) NSString *nextTrip;
@property (nonatomic, readwrite) NSString *bookAnotherCar;
@property (nonatomic, readwrite) NSArray <CTSearchReservationsCellModel *> *rowViewModels;
@end

@implementation CTSearchSplashViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchSplashViewModel *viewModel = [CTSearchSplashViewModel new];
    viewModel.splashColor = appState.userSettingsState.primaryColor;
    viewModel.illustrationColor = appState.userSettingsState.illustrationColor;
    viewModel.splashText = CTLocalizedString(CTSearchCompareDeals);
    viewModel.searchBoxText = CTLocalizedString(CTSearchWhatsYourPickupLocation);
    viewModel.nextTrip = CTLocalizedString(CTSearchViewYourNextTrip);
    viewModel.bookAnotherCar = CTLocalizedString(CTSearchBookAnotherCar);
    
    NSMutableArray *rowViewModels = [NSMutableArray new];
    for (CTRentalBooking *booking in appState.reservationsState.reservations) {
        CTSearchReservationsCellModel *cellModel = [CTSearchReservationsCellModel viewModelForBooking:booking
                                                                                         primaryColor:appState.userSettingsState.primaryColor
                                                    secondaryColor:appState.userSettingsState.secondaryColor];
        [rowViewModels addObject:cellModel];
    }
    viewModel.rowViewModels = rowViewModels.copy;
    
    return viewModel;
}

@end
