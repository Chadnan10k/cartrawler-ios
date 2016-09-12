//
//  InclusionCollectionViewDataSource.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 02/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTGroundInclusion.h>

@interface InclusionCollectionViewDataSource : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>

- (void)setInclusions:(NSArray <CTGroundInclusion *> *)inclusions;

@end
