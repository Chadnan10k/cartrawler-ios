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

@property (nonatomic, readwrite) CTVehicleListFilterViewModel *filterViewModel;

@property (nonatomic, readwrite) NSString *sortTitle;
@property (nonatomic, readwrite) NSArray *sortOptions;
@property (nonatomic, readwrite) NSString *cancelTitle;
@property (nonatomic, readwrite) CTVehicleListSort selectedSort;
@property (nonatomic, readwrite) BOOL scrollToTop;
@property (nonatomic, readwrite) UIColor *navigationBarColor;
@end

@implementation CTVehicleListViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTVehicleListViewModel *viewModel = [CTVehicleListViewModel new];
    CTAPIState *APIState = appState.APIState;
    CTVehicleListState *vehicleListState = appState.vehicleListState;
    
    viewModel.navigationBarColor = appState.userSettingsState.primaryColor;
    
    NSArray *matchedAvailabilityItems = [APIState.matchedAvailabilityItems objectForKey:APIState.availabilityRequestTimestamp];
    
    if (matchedAvailabilityItems.count > 0) {
        viewModel.rowViewModels = [self rowViewModelsForState:appState];
        viewModel.leftLabelText = [self leftLabelTextForVehicleCount:viewModel.rowViewModels.count];
        viewModel.rightLabelText = [self rightLabelAttributedTextForState:vehicleListState];
        
        viewModel.selectedSort = vehicleListState.selectedSort;
        viewModel.selectedView = vehicleListState.selectedView;
        viewModel.scrollToTop = vehicleListState.scrollToTop;
        
        viewModel.sortTitle = CTLocalizedString(CTRentalSortTitle);
        viewModel.sortOptions = @[CTLocalizedString(CTRentalSortPrice), CTLocalizedString(CTRentalSortRecommended)];
        viewModel.cancelTitle = CTLocalizedString(CTRentalCTACancel);
        
        viewModel.filterViewModel = [CTVehicleListFilterViewModel viewModelForState:appState];
    }
    
    return viewModel;
}

+ (NSString *)leftLabelTextForVehicleCount:(NSInteger)count {
    return [NSString stringWithFormat:@"%lu vehicles", (long)count];
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
    NSMutableAttributedString *chevronString = [[NSMutableAttributedString alloc] initWithString:@"  "];
    [chevronString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"V5-Mobile" size:8] range:NSMakeRange(0, chevronString.length)];
    [chevronString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, chevronString.length)];
    return chevronString.copy;
}

+ (NSArray *)rowViewModelsForState:(CTAppState *)appState {
    NSMutableArray *rowViewModels = [NSMutableArray new];
    
    NSArray *filteredAvailabilityItems = [self filteredVehiclesForState:appState];
    NSArray *sortedAvailabilityItems = [self availabilityItems:filteredAvailabilityItems
                                                          sort:appState.vehicleListState.selectedSort];
    
    for (CTAvailabilityItem *availabilityItem in sortedAvailabilityItems) {
        CTVehicleListTableViewModel *rowViewModel = [CTVehicleListTableViewModel viewModelForAvailabilityItem:availabilityItem
                                                                                                   pickupDate:appState.searchState.selectedPickupDate
                                                                                                  dropoffDate:appState.searchState.selectedDropoffDate];
        [rowViewModels addObject:rowViewModel];
    }
    return rowViewModels.copy;
}

+ (NSArray *)filteredVehiclesForState:(CTAppState *)appState {
    CTVehicleListState *vehicleListState = appState.vehicleListState;
    NSArray *availabilityItems = [appState.APIState.matchedAvailabilityItems objectForKey:appState.APIState.availabilityRequestTimestamp];
    NSArray *selectedFilters = vehicleListState.selectedFilters;
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(CTVehicleListFilterModel *item, NSDictionary<NSString *,id> * _Nullable bindings) {
        return item.filterType == CTVehicleListFilterTypeSize;
    }];
    NSArray *sizeFilters = [selectedFilters filteredArrayUsingPredicate:predicate];
    
    predicate = [NSPredicate predicateWithBlock:^BOOL(CTVehicleListFilterModel *item, NSDictionary<NSString *,id> * _Nullable bindings) {
        return item.filterType == CTVehicleListFilterTypeVendor;
    }];
    NSArray *vendorFilters = [selectedFilters filteredArrayUsingPredicate:predicate];
    
    predicate = [NSPredicate predicateWithBlock:^BOOL(CTVehicleListFilterModel *item, NSDictionary<NSString *,id> * _Nullable bindings) {
        return item.filterType == CTVehicleListFilterTypeLocation;
    }];
    NSArray *locationFilters = [selectedFilters filteredArrayUsingPredicate:predicate];
    
    predicate = [NSPredicate predicateWithBlock:^BOOL(CTVehicleListFilterModel *item, NSDictionary<NSString *,id> * _Nullable bindings) {
        return item.filterType == CTVehicleListFilterTypeFuelPolicy;
    }];
    NSArray *fuelPolicyFilters = [selectedFilters filteredArrayUsingPredicate:predicate];
    
    predicate = [NSPredicate predicateWithBlock:^BOOL(CTVehicleListFilterModel *item, NSDictionary<NSString *,id> * _Nullable bindings) {
        return item.filterType == CTVehicleListFilterTypeTransmission;
    }];
    NSArray *transmissionFilters = [selectedFilters filteredArrayUsingPredicate:predicate];
    
    predicate = [NSPredicate predicateWithBlock:^BOOL(CTAvailabilityItem *item, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSSet *uniqueFilters = [NSSet setWithArray:[sizeFilters valueForKey:@"code"]];
        if (uniqueFilters.count > 0 && ![uniqueFilters containsObject:@(item.vehicle.size)]) {
            return NO;
        }
        uniqueFilters = [NSSet setWithArray:[vendorFilters valueForKey:@"code"]];
        if (uniqueFilters.count > 0 && ![uniqueFilters containsObject:item.vendor.name]) {
            return NO;
        }
        uniqueFilters = [NSSet setWithArray:[locationFilters valueForKey:@"code"]];
        if (uniqueFilters.count > 0 && ![uniqueFilters containsObject:@(item.vendor.pickupLocation.pickupType)]) {
            return NO;
        }
        uniqueFilters = [NSSet setWithArray:[fuelPolicyFilters valueForKey:@"code"]];
        if (uniqueFilters.count > 0 && ![uniqueFilters containsObject:@(item.vehicle.fuelPolicy)]) {
            return NO;
        }
        uniqueFilters = [NSSet setWithArray:[transmissionFilters valueForKey:@"code"]];
        if (uniqueFilters.count > 0 && ![uniqueFilters containsObject:item.vehicle.transmissionType]) {
            return NO;
        }
        return YES;
    }];
    
    NSArray *filteredItems = [availabilityItems filteredArrayUsingPredicate:predicate];
    return filteredItems;
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
