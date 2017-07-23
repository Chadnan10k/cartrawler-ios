//
//  CTSearchLocationsViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import <CartrawlerAPI/CTMatchedLocation.h>

@interface CTSearchLocationsViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) NSString *searchBarPlaceholder;
@property (nonatomic, readonly) NSArray <NSString *> *sectionTitles;
@property (nonatomic, readonly) NSArray <NSArray <CTMatchedLocation *> *> *rows;
@end
