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
    _midPaths = [[NSMutableArray alloc] init];
    _midSections = [[NSMutableArray alloc] init];
    _collectionViews = [[NSMutableArray alloc] init];
    return self;
}

- (void)reset
{
    [self deselect];
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
    if ((self.collectionViews).firstObject != nil) {
        _headCollectionView = (self.collectionViews).firstObject;
    }
    if ((self.collectionViews).lastObject != nil) {
        _headCollectionView = (self.collectionViews).lastObject;
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
    
    
    //**
    //head
    if (![cell.date isEqual:[NSNull null]] && self.headDate != nil) {

        NSDateComponents *dateComp = [[NSCalendar currentCalendar]
                                          components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                          fromDate:self.headDate];

        NSDateComponents *headCellComp = [[NSCalendar currentCalendar]
                                      components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                      fromDate:cell.date];

        NSInteger dateDay = dateComp.day;
        NSInteger dateMonth = dateComp.month;
        NSInteger dateYear = dateComp.year;

        NSInteger cellDay = headCellComp.day;
        NSInteger cellMonth = headCellComp.month;
        NSInteger cellYear = headCellComp.year;

        if (dateDay == cellDay && dateMonth == cellMonth && cellYear == dateYear) {
            [cell headSetWithPrimaryColor:self.primaryColor secondaryColor:self.secondaryColor];
        }
    }
    //tail
    if (![cell.date isEqual:[NSNull null]] && self.tailDate != nil) {

        NSDateComponents *dateComp = [[NSCalendar currentCalendar]
                                      components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                      fromDate:self.tailDate];

        NSDateComponents *headCellComp = [[NSCalendar currentCalendar]
                                          components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                          fromDate:cell.date];

        NSInteger dateDay = dateComp.day;
        NSInteger dateMonth = dateComp.month;
        NSInteger dateYear = dateComp.year;

        NSInteger cellDay = headCellComp.day;
        NSInteger cellMonth = headCellComp.month;
        NSInteger cellYear = headCellComp.year;

        if (dateDay == cellDay && dateMonth == cellMonth && cellYear == dateYear) {
            [cell tailSetWithPrimaryColor:self.primaryColor secondaryColor:self.secondaryColor];
        }
    }
    //same day

    if (![cell.date isEqual:[NSNull null]] && self.headDate != nil && self.tailDate != nil) {

        NSDateComponents *headDateComp = [[NSCalendar currentCalendar]
                                      components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                      fromDate:self.headDate];

        NSDateComponents *tailDateComp = [[NSCalendar currentCalendar]
                                      components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                      fromDate:self.tailDate];

        NSDateComponents *headCellComp = [[NSCalendar currentCalendar]
                                          components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                          fromDate:cell.date];

        NSInteger headDay = headDateComp.day;
        NSInteger headMonth = headDateComp.month;
        NSInteger headYear = headDateComp.year;


        NSInteger tailDay = tailDateComp.day;
        NSInteger tailMonth = tailDateComp.month;
        NSInteger tailYear = tailDateComp.year;


        NSInteger cellDay = headCellComp.day;
        NSInteger cellMonth = headCellComp.month;
        NSInteger cellYear = headCellComp.year;

        if (headDay == tailDay && headMonth == tailMonth && headYear == tailYear) {
            if (cellDay == tailDay && cellMonth == tailMonth && cellYear == tailYear) {
                if (headDay == cellDay && headMonth == cellMonth && headYear == cellYear) {
                    [cell sameDaySetWithPrimaryColor:self.primaryColor secondaryColor:self.secondaryColor];
                }
            }
        }

    }
    
    //**
    
    if (self.headIndexPath != nil & self.tailIndexPath != nil) {
        
        if (cell.section.integerValue == tailSection && cell.section.integerValue == headSection) {
            
            if (cell.indexPath.row > self.headIndexPath.row && cell.indexPath.row < self.tailIndexPath.row) {
                [cell midSetWithPrimaryColor:self.primaryColor secondaryColor:self.secondaryColor];
            }
            
        } else {
            
            if (cell.indexPath.row > self.headIndexPath.row && cell.section.integerValue == headSection) {
                [cell midSetWithPrimaryColor:self.primaryColor secondaryColor:self.secondaryColor];
            }
            
            if (cell.indexPath.row < self.tailIndexPath.row && cell.section.integerValue == tailSection) {
                [cell midSetWithPrimaryColor:self.primaryColor secondaryColor:self.secondaryColor];
            }
            
            if (cell.section.integerValue < tailSection && cell.section.integerValue > headSection) {
                [cell midSetWithPrimaryColor:self.primaryColor secondaryColor:self.secondaryColor];
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
            if (self.dateSelected) {
                self.dateSelected(cell.date, YES);
            }
        }
        
    } else if (self.headCell != nil &&
               self.tailCell == nil &&
               ![cell.date isEqual:[NSNull null]] &&
               [self.headDate compare:cell.date] != NSOrderedDescending) {
        [self tailSetSelected:cell indexPath:indexPath section:section];
        self.refresh();
        if (self.datesSelected != nil) {
            
            BOOL needsScroll = NO;
            double constraint = [UIScreen mainScreen].bounds.size.height-[self.tailCell.superview convertPoint:self.tailCell.frame.origin toView:nil].y;
            
            if (self.tailCell) {
                if (constraint < 90) {
                    needsScroll = YES;
                }
            }
            self.dateSelected(cell.date, NO);
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
    [cell headSetWithPrimaryColor:self.primaryColor secondaryColor:self.secondaryColor];
    
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
            [cell tailSetWithPrimaryColor:self.primaryColor secondaryColor:self.secondaryColor];
        } else {
            if (indexPath.row > self.headIndexPath.row && section == headSection) {
                tailSection = section;
                _tailIndexPath = indexPath;
                _tailCell = cell;
                _tailDate = cell.date;
                [cell tailSetWithPrimaryColor:self.primaryColor secondaryColor:self.secondaryColor];
            } else if (indexPath.row >= self.headIndexPath.row && section == headSection) {//same day
                tailSection = section;
                _tailIndexPath = indexPath;
                _tailCell = cell;
                _tailDate = cell.date;
                [cell sameDaySetWithPrimaryColor:self.primaryColor secondaryColor:self.secondaryColor];
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
    
    _headDate = nil;
    _tailDate = nil;
    
    _headIndexPath = nil;
    _tailIndexPath = nil;
}

@end
