//
//  CTVehicleListViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListViewModel.h"
#import "CTAppState.h"
#import <CartrawlerAPI/CTAvailabilityItem.h>
#import "CTVehicleListTableViewModel.h"
#import "CartrawlerSDK+NSString.h"

@interface CTVehicleListViewModel ()
@property (nonatomic, readwrite) NSString *leftLabelText;
@property (nonatomic, readwrite) NSAttributedString *rightLabelText;
@property (nonatomic, readwrite) NSArray <CTVehicleListTableViewModel *> *rowViewModels;

@property (nonatomic, readwrite) NSString *sortTitle;
@property (nonatomic, readwrite) NSArray *sortOptions;
@property (nonatomic, readwrite) NSString *cancelTitle;
@property (nonatomic, readwrite) CTVehicleListSort selectedSort;

@end

@implementation CTVehicleListViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTVehicleListViewModel *viewModel = [CTVehicleListViewModel new];
    CTAPIState *APIState = appState.APIState;
    CTVehicleListState *vehicleListState = appState.vehicleListState;
    
    if (APIState.matchedAvailabilityItems.count > 0) {
        viewModel.leftLabelText = [self leftLabelTextForState:APIState];
        viewModel.rightLabelText = [self rightLabelAttributedTextForState:vehicleListState];
        viewModel.rowViewModels = [self rowViewModelsForState:appState];
        
        viewModel.selectedSort = vehicleListState.selectedSort;
        viewModel.selectedView = vehicleListState.selectedView;
        viewModel.scrollToTop = vehicleListState.scrollToTop;
        
        viewModel.sortTitle = CTLocalizedString(CTRentalSortTitle);
        viewModel.sortOptions = @[CTLocalizedString(CTRentalSortPrice), CTLocalizedString(CTRentalSortRecommended)];
        viewModel.cancelTitle = CTLocalizedString(CTRentalCTACancel);
    }
    
    return viewModel;
}

+ (NSString *)leftLabelTextForState:(CTAPIState *)APIState {
    return [NSString stringWithFormat:@"%lu vehicles", (unsigned long)APIState.matchedAvailabilityItems.count];
}

+ (NSAttributedString *)rightLabelAttributedTextForState:(CTVehicleListState *)vehicleListState {
    NSMutableAttributedString *rightLabelText = [self rightLabelTextForState:vehicleListState];
    NSAttributedString *chevronString = [self chevronString];
    
    [rightLabelText appendAttributedString:chevronString];
    return rightLabelText;
}

+ (NSMutableAttributedString *)rightLabelTextForState:(CTVehicleListState *)vehicleListState {
    NSString *sortType;
    switch (vehicleListState.selectedSort) {
        case CTVehicleListSortPrice:
            sortType = CTLocalizedString(CTRentalSortPrice);
            break;
        case CTVehicleListSortRecommended:
            sortType = CTLocalizedString(CTRentalSortRecommended);
            break;
        default:
            break;
    }
    return [NSString regularText:CTLocalizedString(CTRentalSortTitle)
                    regularColor:[UIColor lightGrayColor]
                     regularSize:14
                  attributedText:sortType
                       boldColor:[UIColor blackColor]
                        boldSize:14
                        useSpace:YES].mutableCopy;
}

+ (NSAttributedString *)chevronString {
    NSMutableAttributedString *chevronString = [[NSMutableAttributedString alloc] initWithString:@" "];
    [chevronString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"V5-Mobile" size:12] range:NSMakeRange(0, chevronString.length)];
    [chevronString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, chevronString.length)];
    return chevronString.copy;
}

+ (NSArray *)rowViewModelsForState:(CTAppState *)appState {
    NSMutableArray *rowViewModels = [NSMutableArray new];
    
    NSArray *sortedAvailabilityItems = [self availabilityItems:appState.APIState.matchedAvailabilityItems
                                                          sort:appState.vehicleListState.selectedSort];
    
    for (CTAvailabilityItem *availabilityItem in sortedAvailabilityItems) {
        CTVehicleListTableViewModel *rowViewModel = [CTVehicleListTableViewModel viewModelForAvailabilityItem:availabilityItem
                                                                                                   pickupDate:appState.searchState.selectedPickupDate
                                                                                                  dropoffDate:appState.searchState.selectedDropoffDate];
        [rowViewModels addObject:rowViewModel];
    }
    return rowViewModels.copy;
}

+ (NSArray <CTAvailabilityItem *> *)availabilityItems:(NSArray <CTAvailabilityItem *> *)availabilityItems sort:(CTVehicleListSort)sort {

    NSString *key;
    switch (sort) {
        case CTVehicleListSortPrice:
            key = @"vehicle.totalPriceForThisVehicle";
            break;
        case CTVehicleListSortRecommended:
            key = @"vehicle.config.relevance";
            break;
        default:
            break;
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:key
                                        ascending:YES];
    
    return [availabilityItems sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
}

@end
