//
//  VehicleFeaturesDataSource.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 25/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VehicleFeaturesDataSource : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

- (void)setData:(NSArray <NSDictionary *> *)items;

@end
