//
//  CTSearchUSPViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 02/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSearchUSPDetailViewModel.h"
#import "CTViewModelProtocol.h"

@interface CTSearchUSPViewModel : NSObject <CTViewModelProtocol>

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSArray <CTSearchUSPDetailViewModel *> *detailViewModels;
@property (nonatomic, readonly) NSInteger pageIndex;
@property (nonatomic, readonly) NSInteger numberOfPages;
@property (nonatomic, readonly) UIColor *currentPageControlTintColor;
@property (nonatomic, readonly) UIColor *pageControlTintColor;
@end
