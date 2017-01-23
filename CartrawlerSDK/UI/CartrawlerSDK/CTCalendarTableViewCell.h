//
//  CTCalendarTableViewCell.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 09/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarLogicController.h"

@interface CTCalendarTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDate *mininumDate;



- (void)setData:(NSDate *)month section:(NSInteger)section logicController:(CalendarLogicController *)logicController;

- (UICollectionView *)currentCollectionView;

@end
