//
//  CTSearchUSPViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 02/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchUSPViewModel.h"
#import "CTAppState.h"
#import "CTSearchUSPDetailViewModel.h"

@interface CTSearchUSPViewModel ()
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSArray <CTSearchUSPDetailViewModel *> *detailViewModels;
@property (nonatomic, readwrite) NSInteger pageIndex;
@property (nonatomic, readwrite) NSInteger numberOfPages;
@property (nonatomic, readwrite) UIColor *currentPageControlTintColor;
@property (nonatomic, readwrite) UIColor *pageControlTintColor;
@end

@implementation CTSearchUSPViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchUSPViewModel *viewModel = [CTSearchUSPViewModel new];
    viewModel.title = @"Why book with us?";
    
    NSArray *details = @[@(CTSearchUSPDetailTypeCreditCard), @(CTSearchUSPDetailTypeHeadset), @(CTSearchUSPDetailTypeMap), @(CTSearchUSPDetailTypeSearch), @(CTSearchUSPDetailTypeLock)];
    
    NSMutableArray *detailViewModels = [NSMutableArray new];
    for (NSNumber *detail in details) {
        CTSearchUSPDetailViewModel *detailViewModel = [CTSearchUSPDetailViewModel viewModelForState:detail];
        detailViewModel.primaryColor = appState.userSettingsState.primaryColor;
        [detailViewModels addObject:detailViewModel];
    }
    viewModel.detailViewModels = detailViewModels.copy;
    
    viewModel.pageIndex = appState.searchState.uspPageIndex;
    viewModel.numberOfPages = detailViewModels.count;
    
    viewModel.pageControlTintColor = appState.userSettingsState.secondaryColor;
    viewModel.currentPageControlTintColor = appState.userSettingsState.primaryColor;
    
    return viewModel;
}

@end
