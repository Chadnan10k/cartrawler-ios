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
#import "CartrawlerSDK+NSDateUtils.h"

@interface CTDateCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UIView *circleMask;
@property (weak, nonatomic) IBOutlet UIView *leftSquare;
@property (weak, nonatomic) IBOutlet UIView *leftBorder;
@property (weak, nonatomic) IBOutlet UIView *rightSquare;
@property (weak, nonatomic) IBOutlet UIView *rightBorder;
@property (nonatomic, weak) IBOutlet CTLabel *label;
@property (nonatomic, weak) IBOutlet UIImageView *selectedImageView;

@end

@implementation CTDateCollectionViewCell

- (void)setDateLabel:(NSDate *)date indexPath:(NSIndexPath *)indexPath section:(NSNumber *)section;
{
    _indexPath = indexPath;
    _section = section;
    
    self.circleView.hidden = YES;
    self.circleMask.hidden = YES;
    self.leftSquare.hidden = YES;
    self.leftBorder.hidden = YES;
    self.rightSquare.hidden = YES;
    self.rightBorder.hidden = YES;
    
    if (date != nil) {
        _date = date;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"d";
        self.label.text = [df stringFromDate:self.date];
    }
    
    if (![date isEqual:[NSNull null]] && [NSDate isDate:date inSameDayAsDate:[NSDate date]]) {
        self.circleView.hidden = NO;
        self.circleMask.hidden = NO;
        self.circleView.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)setLabelColor:(UIColor *)color
{
    self.label.textColor = color;
}

- (void)headSetWithPrimaryColor:(UIColor *)primaryColor secondaryColor:(UIColor *)secondaryColor
{
    self.circleView.hidden = NO;
    self.circleMask.hidden = YES;
    self.rightSquare.hidden = NO;
    self.rightBorder.hidden = NO;
    
    self.circleView.backgroundColor = secondaryColor;
    self.rightSquare.backgroundColor = secondaryColor;
    self.rightBorder.backgroundColor = primaryColor;
    
    self.label.textColor = [UIColor whiteColor];
}

- (void)midSetWithPrimaryColor:(UIColor *)primaryColor secondaryColor:(UIColor *)secondaryColor
{
    if (![self.date isEqual:[NSNull null]]) {
        self.backgroundColor  = primaryColor;
        self.label.textColor = [UIColor whiteColor];
    }
}

- (void)tailSetWithPrimaryColor:(UIColor *)primaryColor secondaryColor:(UIColor *)secondaryColor
{
    self.circleView.hidden = NO;
    self.circleMask.hidden = YES;
    self.leftSquare.hidden = NO;
    self.leftBorder.hidden = NO;
    
    self.circleView.backgroundColor = secondaryColor;
    self.leftSquare.backgroundColor = secondaryColor;
    self.leftBorder.backgroundColor = primaryColor;
    self.label.textColor = [UIColor whiteColor];
}

- (void)sameDaySetWithPrimaryColor:(UIColor *)primaryColor secondaryColor:(UIColor *)secondaryColor
{
    self.circleView.hidden = NO;
    self.leftSquare.hidden = YES;
    self.leftBorder.hidden = YES;
    self.rightSquare.hidden = YES;
    self.rightBorder.hidden = YES;
    
    self.circleView.backgroundColor = secondaryColor;
    self.label.textColor = [UIColor whiteColor];
}

- (void)deselect
{
    self.backgroundColor = [UIColor clearColor];
    self.circleView.hidden = YES;
    self.leftSquare.hidden = YES;
    self.leftBorder.hidden = YES;
    self.rightSquare.hidden = YES;
    self.rightBorder.hidden = YES;
    
    if (![self.date isEqual:[NSNull null]]) {
        NSDate *now = [NSDate date];
        NSDate *previousDay = [now dateByAddingTimeInterval:-1*24*60*60];
        
        if ([self.date compare:previousDay] == NSOrderedDescending) {
            self.label.textColor = [UIColor blackColor];
        }
        
        if ([NSDate isDate:self.date inSameDayAsDate:now]) {
            self.circleView.hidden = NO;
            self.circleView.backgroundColor = [UIColor lightGrayColor];
            self.circleMask.hidden = NO;
        }
    }
}

@end
