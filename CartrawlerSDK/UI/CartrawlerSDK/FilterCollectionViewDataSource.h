//
//  FilterCollectionViewDataSource.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CartrawlerAPI/CTGroundAvailability.h>
#import <UIKit/UIKit.h>
#import "GTFilterCollectionViewCell.h"

@interface FilterCollectionViewDataSource : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>

typedef void (^GTFilterCompletion)(GTFilterType selectedItem);

@property (weak, nonatomic) GTFilterCompletion selectedFilter;
@property (nonatomic, strong) CTGroundAvailability *avail;


@end
