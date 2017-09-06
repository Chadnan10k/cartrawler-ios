//
//  CTDateCollectionViewCell.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 09/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTDateCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSNumber *section;

- (void)setDateLabel:(NSDate *)date indexPath:(NSIndexPath *)indexPath section:(NSNumber *)section;
- (void)setLabelColor:(UIColor *)color;

- (void)headSetWithPrimaryColor:(UIColor *)primaryColor secondaryColor:(UIColor *)secondaryColor;
- (void)midSetWithPrimaryColor:(UIColor *)primaryColor secondaryColor:(UIColor *)secondaryColor;
- (void)tailSetWithPrimaryColor:(UIColor *)primaryColor secondaryColor:(UIColor *)secondaryColor;
- (void)sameDaySetWithPrimaryColor:(UIColor *)primaryColor secondaryColor:(UIColor *)secondaryColor;
- (void)deselect;

@end
