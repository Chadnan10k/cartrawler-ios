//
//  CTCalendarTableViewCell.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 09/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTCalendarTableViewCell.h"
#import "CTDateCollectionViewCell.h"

@interface CTCalendarTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property NSInteger startDay;
@property NSInteger monthLength;

@property NSMutableArray *dates;

@property (copy, nonatomic) CalendarLogicController *logicController;
@property NSInteger section;
@end

@implementation CTCalendarTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UICollectionView *)currentCollectionView
{
    if (self.collectionView != nil) {
        return self.collectionView;
    } else {
        return nil;
    }
}

- (void)setData:(NSDate *)month section:(NSInteger)section logicController:(CalendarLogicController *)logicController
{
    _section = section;
    _logicController = logicController;
    [logicController pushCollectionView:self.collectionView];
    _dates = [[NSMutableArray alloc] init];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    NSDateComponents * comps = [cal components:NSUIntegerMax
                                      fromDate:month];
    [comps setDay:1];
    //[comps setMonth:9];
    
    NSDate * adjustedDate = [cal dateFromComponents:comps];
    
    NSDateComponents* comp = [cal components:NSUIntegerMax fromDate:adjustedDate];
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:adjustedDate];
    
    _startDay = [comp weekday];
    _monthLength = days.length;
    
    NSInteger x = self.startDay-1;
    NSInteger y = labs(self.monthLength-42+x);
    

    
    for (int i = 1; i < 43; i++) {
       if (i >= self.startDay) {
           NSDateComponents * comps = [cal components:NSUIntegerMax
                                             fromDate:adjustedDate];
           [comps setDay:(i - self.startDay)+1];
           NSDate *cellDate = [cal dateFromComponents:comps];
           [self.dates addObject:cellDate];
        } else {
            [self.dates addObject:[NSNull null]];
        }
    }
    
    for (int z = 0; z < y; z++) {
        int index = 41 - z;
        [self.dates replaceObjectAtIndex:index withObject:[NSNull null]];
    }
    
    [self.collectionView reloadData];
    
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 42;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CTDateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DateCell" forIndexPath:indexPath];
    [cell setDateLabel:self.dates[indexPath.row] indexPath:indexPath section:[NSNumber numberWithInteger:self.section]];
    [self.logicController validateCell:(CTDateCollectionViewCell *)cell indexPath: indexPath section: self.section collectionView: collectionView];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.logicController validateCell:(CTDateCollectionViewCell *)cell indexPath: indexPath section: self.section collectionView: collectionView];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [(CTDateCollectionViewCell *)cell deselect];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CTDateCollectionViewCell *cell = (CTDateCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.logicController cellSelected:cell indexPath:indexPath section: self.section];
}

@end
