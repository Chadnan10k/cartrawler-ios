//
//  PageSelectionCollectionViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 23/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageSelectionCollectionViewCell : UICollectionViewCell

+ (void)forceLinkerLoad_;

- (void)setText:(NSString *)text;
- (void)animate;

@end
