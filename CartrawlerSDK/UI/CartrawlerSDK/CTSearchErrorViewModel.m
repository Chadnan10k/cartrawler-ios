//
//  CTSearchErrorViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 09/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchErrorViewModel.h"
#import "CTAppController.h"

@implementation CTSearchErrorViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchState *searchState = appState.searchState;
    CTErrorResponse *error = searchState.vehicleSearchError;
    
    CTAlertAction *action = [CTAlertAction actionWithTitle:@"OK" handler:^(CTAlertAction *action) {
        [CTAppController dispatchAction:CTActionSearchUserDidDismissVehicleFetchError payload:nil];
    }];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:error.errorMessage];
    CTSearchErrorViewModel *viewModel = [[CTSearchErrorViewModel alloc] initWithTitle:@"Error" message:string action:action];
    return viewModel;
}

@end
