//
//  CTSearchLocationsViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTMatchedLocation.h"

@interface CTSearchLocationsViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) UIColor *navigationBarColor;
@property (nonatomic, readonly) UIColor *cursorColor;
@property (nonatomic, readonly) UIColor *iconColor;
@property (nonatomic, readonly) NSString *searchBarPlaceholder;
@property (nonatomic, readonly) NSString *cancel;
@property (nonatomic, readonly) NSArray <NSString *> *sectionTitles;
@property (nonatomic, readonly) NSArray <NSArray <CTMatchedLocation *> *> *rows;
@end
