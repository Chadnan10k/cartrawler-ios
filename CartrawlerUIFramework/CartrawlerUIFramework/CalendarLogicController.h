//
//  CalendarLogicController.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 09/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTDateCollectionViewCell.h"
#import "CTMiddleDateCell.h"

@interface CalendarLogicController : NSObject

typedef void (^CTCalenderRefresh)(void);

@property (nonatomic) CTCalenderRefresh refresh;

- (void)cellSelected:(CTDateCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath section:(NSInteger)section;

- (void)validateCell:(CTDateCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath section:(NSInteger)section;

- (void)pushMiddleCell:(CTMiddleDateCell *)cell;

@end
