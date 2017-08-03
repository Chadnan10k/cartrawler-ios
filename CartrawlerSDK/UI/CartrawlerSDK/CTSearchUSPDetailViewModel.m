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
            viewModel.title = @"Free cancellation and amendments";
            viewModel.detail = @"Free cancellation up to 24 hours prior to your pick up. No administration fees when you amend your booking.";
            break;
        case CTSearchUSPDetailTypeHeadset:
            viewModel.title = @"24/7 phone support";
            viewModel.detail = @"Our team is here to help 24 hours a day, 7 days a week.";
            break;
        case CTSearchUSPDetailTypeMap:
            viewModel.title = @"30,000 airports and city locations";
            viewModel.detail = @"Compare 1,500 suppliers, Choose & Save!";
            break;
        case CTSearchUSPDetailTypeSearch:
            viewModel.title = @"No hidden costs";
            viewModel.detail = @"We’ll explain any additional costs before you book your car hire. More details on what’s included? Just check the t’s & c’s of any car.";
            break;
        case CTSearchUSPDetailTypeLock:
            viewModel.title = @"Damage and theft protection";
            viewModel.detail = @"Our rentals include Collision Damage Waiver and Theft Protection.";
            break;
        default:
            break;
    }
    return viewModel;
}

@end
