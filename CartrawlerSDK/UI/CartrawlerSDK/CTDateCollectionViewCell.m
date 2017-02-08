//
//  CTDateCollectionViewCell.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 09/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTDateCollectionViewCell.h"
#import "CTLabel.h"
#import "CTAppearance.h"
#import <QuartzCore/QuartzCore.h>

@interface CTDateCollectionViewCell()

@property (nonatomic, weak) IBOutlet CTLabel *label;
@property (nonatomic, weak) IBOutlet UIImageView *selectedImageView;

@end

@implementation CTDateCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = NO;
    self.selectedImageView.contentMode = UIViewContentModeScaleToFill;
}

- (void)setDateLabel:(NSDate *)date indexPath:(NSIndexPath *)indexPath section:(NSNumber *)section;
{
    if (date != nil) {
        _date = date;
        _indexPath = indexPath;
        _section = section;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"d";
        
        self.label.text = [df stringFromDate:self.date];
    } else {
        _indexPath = indexPath;
        _section = section;
    }
    
}

- (void)setLabelColor:(UIColor *)color
{
    self.label.textColor = color;
}

- (void)headSetSelected
{
    self.backgroundColor = [CTAppearance instance].calendarStartCellColor;
    self.label.textColor = [UIColor whiteColor];
}

- (void)midSetSelected
{
    if (![self.date isEqual:[NSNull null]]) {
        self.backgroundColor  = [CTAppearance instance].calendarMidCellColor;
        self.label.textColor = [UIColor whiteColor];
    }
}

- (void)tailSetSelected
{
    self.backgroundColor = [CTAppearance instance].calendarEndCellColor;
    self.label.textColor = [UIColor whiteColor];
}

- (void)sameDaySetSelected
{
    self.backgroundColor = [CTAppearance instance].calendarSameDayCellColor;
    self.label.textColor = [UIColor whiteColor];
}

- (void)deselect
{
    self.backgroundColor = [UIColor clearColor];
    self.selectedImageView.image = nil;
    
    if (![self.date isEqual:[NSNull null]]) {
        NSDate *now = [NSDate date];
        NSDate *previousDay = [now dateByAddingTimeInterval:-1*24*60*60];
        
        if ([self.date compare:previousDay] == NSOrderedDescending) {
            self.label.textColor = [UIColor blackColor];
        }
    }
}

- (UIView *)createViewWithColor:(UIColor *)color
{
    CGRect frame = CGRectMake(0, 0, self.frame.size.width / 1.2, self.frame.size.height / 1.2);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor redColor];
    
    return view;
}
@end
