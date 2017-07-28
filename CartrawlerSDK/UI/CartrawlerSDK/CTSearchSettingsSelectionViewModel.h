//
//  CTSearchSettingsSelectionViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTSearchState.h"
#import "CTCSVItem.h"

@interface CTSearchSettingsSelectionViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) UIColor *navigationBarColor;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *closeButtonTitle;
@property (nonatomic, readonly) NSArray <CTCSVItem *> *rowViewModels;
@end
