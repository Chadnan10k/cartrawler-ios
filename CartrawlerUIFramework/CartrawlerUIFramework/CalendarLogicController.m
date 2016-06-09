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

@property (nonatomic, strong) NSIndexPath *headIndexPath;
@property (nonatomic, strong) NSIndexPath *tailIndexPath;

@end

@implementation CalendarLogicController {
    NSInteger headSection;
    NSInteger tailSection;
}

- (id)init
{
    self = [super init];
    _midCells = [[NSMutableArray alloc] init];
    return self;
}

- (void)pushMiddleCell:(CTMiddleDateCell *)cell
{
    if (![self.midCells containsObject:cell]) {
        [self.midCells addObject:cell];
    } else {
        NSLog(@"already exists");
    }
    [self validateCell:cell.cell indexPath: cell.indexPath section: cell.section.integerValue];

}

- (void)validateCell:(CTDateCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath section:(NSInteger)section
{
    if (self.headIndexPath == indexPath && headSection == section) {
        [self headSetSelected:cell indexPath:indexPath section:section];
    }
    
    if (self.tailIndexPath == indexPath && tailSection == section) {
        [self tailSetSelected:cell indexPath:indexPath section:section];
    }
    
    [self setMidCells:cell indexPath:indexPath section:section];
    
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
    if (self.headCell == nil) {
        [self headSetSelected:cell indexPath:indexPath section:section];
    } else if (self.headCell != nil && self.tailCell == nil) {
        [self tailSetSelected:cell indexPath:indexPath section:section];
        
        for (CTMiddleDateCell * midCell in self.midCells) {
            [self validateCell:midCell.cell indexPath: midCell.indexPath section: midCell.section.integerValue];
        }
        
    } else {
        [self deselect];
        for (CTMiddleDateCell * midCell in self.midCells) {
            [midCell.cell deselect];
        }
        //[self.midCells removeAllObjects];
    }
}

- (void)headSetSelected:(CTDateCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath section:(NSInteger)section
{
    headSection = section;
    _headIndexPath = indexPath;
    _headCell = cell;
    [cell headSetSelected];
}

- (void)midSetSelected:(CTDateCollectionViewCell *)cell
{
    
}

- (void)tailSetSelected:(CTDateCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath section:(NSInteger)section
{
    if (self.headCell != nil) {
        
        if (section > headSection) {
            tailSection = section;
            _tailIndexPath = indexPath;
            _tailCell = cell;
            [cell tailSetSelected];
        } else {
            if (indexPath.row > self.headIndexPath.row && section == headSection) {
                tailSection = section;
                _tailIndexPath = indexPath;
                _tailCell = cell;
                [cell tailSetSelected];
            }
        }
    }
}

- (void)deselect
{
    [self.headCell deselect];
    [self.tailCell deselect];
    
    _headCell = nil;
    _tailCell = nil;
    
    _headIndexPath = nil;
    _tailIndexPath = nil;
}

@end
