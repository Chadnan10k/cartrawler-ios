//
//  CTTermsConditionsDetailViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 11/09/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import "CTTermsConditionsDetailViewModel.h"
#import "CTTermAndCondition.h"

@interface CTTermsConditionsDetailViewModel ()
@property (nonatomic, readwrite) UIColor *primaryColor;
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *close;
@property (nonatomic, readwrite) NSString *detail;
@end

@implementation CTTermsConditionsDetailViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTTermsConditionsDetailViewModel *viewModel = [CTTermsConditionsDetailViewModel new];
    
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    CTTermAndCondition *termAndCondition = selectedVehicleState.selectedTermAndCondition;
    
    viewModel.primaryColor = appState.userSettingsState.primaryColor;
    viewModel.title = termAndCondition.titleText;
    viewModel.close = CTLocalizedString(CTRentalCTAClose);
    viewModel.detail = termAndCondition.bodyText;
    
    return viewModel;
}

@end
