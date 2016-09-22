//
//  SupplierRatingCollectionViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 22/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplierRatingCollectionViewCell : UICollectionViewCell

+ (void)forceLinkerLoad_;

- (void)setType:(NSString *)typeText ratingText:(NSString *)ratingText;

@end
