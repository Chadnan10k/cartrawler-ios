//
//  CTSearchUSPDetailViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 02/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchUSPDetailViewModel.h"

@interface CTSearchUSPDetailViewModel ()
@property (nonatomic, readwrite) CTSearchUSPDetailType detailType;
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *detail;
@end

@implementation CTSearchUSPDetailViewModel

+ (instancetype)viewModelForState:(NSNumber *)state {
    CTSearchUSPDetailViewModel *viewModel = [CTSearchUSPDetailViewModel new];
    viewModel.detailType = state.integerValue;
    
    switch (viewModel.detailType) {
        case CTSearchUSPDetailTypeCreditCard:
            viewModel.title = CTLocalizedString(CTSearchFreeCancellationAndAmendments);
            viewModel.detail = CTLocalizedString(CTSearchFreeCancellationDetail);
            break;
        case CTSearchUSPDetailTypeHeadset:
            viewModel.title = CTLocalizedString(CTSearchPhoneSupport);
            viewModel.detail = CTLocalizedString(CTSearchPhoneSupportDetail);
            break;
        case CTSearchUSPDetailTypeMap:
            viewModel.title = CTLocalizedString(CTSearchAirportsCityLocations);
            viewModel.detail = CTLocalizedString(CTSearchAirportsCityLocationsDetail);
            break;
        case CTSearchUSPDetailTypeSearch:
            viewModel.title = CTLocalizedString(CTSearchNoHiddenCosts);
            viewModel.detail = CTLocalizedString(CTSearchNoHiddenCostsDetail);
            break;
        case CTSearchUSPDetailTypeLock:
            viewModel.title = CTLocalizedString(CTSearchDamageTheftProtection);
            viewModel.detail = CTLocalizedString(CTSearchDamageTheftProtectionDetail);
            break;
        default:
            break;
    }
    return viewModel;
}

@end
