//
//  VehicleFeatureCollectionViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 25/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleFeatureCollectionViewCell : UICollectionViewCell

+ (void)forceLinkerLoad_;

- (void)setData:(NSString *)text image:(UIImage *)image;

@end
