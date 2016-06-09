//
//  CTDateCollectionViewCell.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 09/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTDateCollectionViewCell : UICollectionViewCell

- (void)setDateLabel:(NSString *)dateString;

- (void)headSetSelected;
- (void)midSetSelected;
- (void)tailSetSelected;
- (void)deselect;
@end
