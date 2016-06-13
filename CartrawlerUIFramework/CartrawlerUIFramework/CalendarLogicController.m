//
//  CalendarLogicController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 09/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CalendarLogicController.h"

@interface CalendarLogicController()

@property (nonatomic, strong) CTDateCollectionViewCell *headCell;
@property (nonatomic, strong) NSMutableArray <CTMiddleDateCell *> *midCells;
@property (nonatomic, strong) CTDateCollectionViewCell *tailCell;
@property (nonatomic, strong) NSMutableArray <CTDateCollectionViewCell *> *visibleCells;
@property (nonatomic, strong) NSIndexPath *headIndexPath;
@property (nonatomic, strong) NSIndexPath *tailIndexPath;

@property (nonatomic, strong) NSDate *headDate;
@property (nonatomic, strong) NSDate *tailDate;

@property (nonatomic, retain) NSMutableArray <NSIndexPath *> *midPaths;
@property (nonatomic, retain) NSMutableArray <NSNumber *> *midSections;

@property (nonatomic, strong) NSMutableArray <UICollectionView *> *collectionViews;
@property (nonatomic, strong) UICollectionView *headCollectionView;
@property (nonatomic, strong) UICollectionView *tailCollectionView;
@property (nonatomic, strong) UICollectionView *currentCollectionView;
@end

@implementation CalendarLogicController {
    NSInteger headSection;
    NSInteger tailSection;
}

- (id)init
{
    self = [super init];
    _midCells = [[NSMutableArray alloc] init];
    _midPaths = [[NSMutableArray alloc] init];
    _midSections = [[NSMutableArray alloc] init];
    _collectionViews = [[NSMutableArray alloc] init];
    return self;
}

- (void)pushCellHeight:(NSNumber *)cellHeight forSection:(NSInteger)section
{
    if (self.cellHeights == nil) {
        _cellHeights = [[NSMutableArray alloc] initWithCapacity:12];
    }
    [self.cellHeights setObject:cellHeight atIndexedSubscript:section];
}

- (void)pushCollectionView:(UICollectionView *)collectionView
{
    if (![self.collectionViews containsObject:collectionView]) {
        [self.collectionViews addObject:collectionView];
    }
    if ([self.collectionViews firstObject] != nil) {
        _headCollectionView = [self.collectionViews firstObject];
    }
    if ([self.collectionViews lastObject] != nil) {
        _headCollectionView = [self.collectionViews lastObject];
    }
}

- (void)validateCell:(CTDateCollectionViewCell *)cell
           indexPath:(NSIndexPath *)indexPath
             section:(NSInteger)section
      collectionView:(UICollectionView *)collectionView;
{
    
    _currentCollectionView = collectionView;
    
    if (self.headIndexPath == indexPath && headSection == section) {
        _headCollectionView = collectionView;
        [self headSetSelected:cell indexPath:indexPath section:section];
    }
    
    if (self.tailIndexPath == indexPath && tailSection == section) {
        _tailCollectionView = collectionView;
        [self tailSetSelected:cell indexPath:indexPath section:section];
    }

    for (CTDateCollectionViewCell *c in collectionView.visibleCells) {

        if (self.headIndexPath != nil & self.tailIndexPath != nil) {

            if (c.section.integerValue == tailSection && c.section.integerValue == headSection) {
                
                if (c.indexPath.row > self.headIndexPath.row && c.indexPath.row < self.tailIndexPath.row) {
                    [c midSetSelected];
                }
                
            } else {
                
                if (c.indexPath.row > self.headIndexPath.row && c.section.integerValue == headSection) {
                    [c midSetSelected];
                }
                    
                if (c.indexPath.row < self.tailIndexPath.row && c.section.integerValue == tailSection) {
                    [c midSetSelected];
                }
                
                if (c.section.integerValue < tailSection && c.section.integerValue > headSection) {
                    [c midSetSelected];
                }
            }
        }
    }
}

- (void)setMidCells:(CTDateCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath section:(NSInteger)section
{
    if (self.headCell != nil && self.tailCell != nil) {
        if (section == headSection) {
            if (indexPath.row > self.headIndexPath.row && indexPath.row < self.tailIndexPath.row) {
                [cell midSetSelected];
            }
        }
    }
}

- (void)cellSelected:(CTDateCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath section:(NSInteger)section
{
    if (self.headCell == nil && ![cell.date isEqual:[NSNull null]]) {
        
        NSDate *now = [NSDate date];
        NSDate *previousDay = [now dateByAddingTimeInterval:-1*24*60*60];
        
        if ([cell.date compare:previousDay] == NSOrderedDescending) {
            [self headSetSelected:cell indexPath:indexPath section:section];
            self.refresh();
        }
        
    } else if (self.headCell != nil && self.tailCell == nil && ![cell.date isEqual:[NSNull null]]) {
        [self tailSetSelected:cell indexPath:indexPath section:section];
        self.refresh();
        if (self.datesSelected != nil) {
            self.datesSelected(self.headDate, self.tailDate);
        }
        
    } else {
        [self deselect];
    }
}

- (void)headSetSelected:(CTDateCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath section:(NSInteger)section
{
    headSection = section;
    _headIndexPath = indexPath;
    _headCell = cell;
    
    _headDate = cell.date;
    [cell headSetSelected];
    
}

- (void)tailSetSelected:(CTDateCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath section:(NSInteger)section
{
    if (self.headCell != nil) {
        //check to make sure we always select ahead of the head
        if (section > headSection) {
            tailSection = section;
            _tailIndexPath = indexPath;
            _tailCell = cell;
            _tailDate = cell.date;
            [cell tailSetSelected];
        } else {
            if (indexPath.row > self.headIndexPath.row && section == headSection) {
                tailSection = section;
                _tailIndexPath = indexPath;
                _tailCell = cell;
                _tailDate = cell.date;
                [cell tailSetSelected];
            } else if (indexPath.row >= self.headIndexPath.row && section == headSection) {//same day
                tailSection = section;
                _tailIndexPath = indexPath;
                _tailCell = cell;
                _tailDate = cell.date;
                [cell sameDaySetSelected];
            }
        }
    }
}

- (void)deselect
{
    if (self.discard != nil) {
        self.discard();
    }
    for (UICollectionView *cv in self.collectionViews) {
        for (CTDateCollectionViewCell * cell in cv.visibleCells) {
            [cell deselect];
        }
    }
    
    _midPaths = [[NSMutableArray alloc] init];
    _midSections = [[NSMutableArray alloc] init];
    
    [self.headCell deselect];
    [self.tailCell deselect];
    
    _headCell = nil;
    _tailCell = nil;
    
    _headIndexPath = nil;
    _tailIndexPath = nil;
}

@end
