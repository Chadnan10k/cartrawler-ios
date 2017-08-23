//
//  CTValidationSearch.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/24/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSearchState.h"

@interface CTValidationSearch : NSObject

+ (NSArray <NSNumber *> *)validateSearchStep:(CTSearchState *)searchState;

@end
