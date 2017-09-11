//
//  CTTermsConditionsViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 11/09/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import "CTTermsConditionsViewModel.h"

@interface CTTermsConditionsViewModel ()
@property (nonatomic, readwrite) UIColor *primaryColor;
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *close;
@property (nonatomic, readwrite) NSArray <CTTermAndCondition *> *termsAndConditions;
@end

@implementation CTTermsConditionsViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTTermsConditionsViewModel *viewModel = [CTTermsConditionsViewModel new];
    CTAPIState *APIState = appState.APIState;
    viewModel.primaryColor = appState.userSettingsState.primaryColor;
    viewModel.title = CTLocalizedString(CTRentalTitleConditions);
    viewModel.close = CTLocalizedString(CTRentalCTAClose);
    viewModel.termsAndConditions = APIState.termsAndConditions.termsAndConditions;
    return viewModel;
}

@end
