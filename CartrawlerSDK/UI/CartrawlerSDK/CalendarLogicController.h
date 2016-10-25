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

typedef void (^CTDatesSelection)(NSDate *pickup, NSDate *dropoff);
typedef void (^CTDateSelection)(NSDate *pickup, BOOL headDate);

typedef void (^CTDiscardDates)(void);

@property (nonatomic) CTDatesSelection datesSelected;
@property (nonatomic) CTDateSelection dateSelected;

@property (nonatomic) CTDiscardDates discard;
@property (nonatomic) CTCalenderRefresh refresh;
@property (nonatomic, strong) NSMutableArray <NSNumber *> *cellHeights;

+ (void)forceLinkerLoad_;

- (void)cellSelected:(CTDateCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath section:(NSInteger)section;

- (void)validateCell:(CTDateCollectionViewCell *)cell
           indexPath:(NSIndexPath *)indexPath
             section:(NSInteger)section
      collectionView:(UICollectionView *)collectionView;

- (void)pushCollectionView:(UICollectionView *)collectionView;

- (void)pushCellHeight:(NSNumber *)cellHeight forSection:(NSInteger)section;

- (void)reset;

@end
