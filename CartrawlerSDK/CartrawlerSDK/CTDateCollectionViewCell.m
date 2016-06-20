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

@interface CTDateCollectionViewCell()

@property (nonatomic, weak) IBOutlet CTLabel *label;

@end

@implementation CTDateCollectionViewCell

+ (void)forceLinkerLoad_
{
    
}

//- (id)initWithFrame:(CGRect)frame
//{
//
//    self = [super initWithFrame:frame];
//    
//    CGFloat radius = frame.size.height / 2;
//    CGFloat imgSize = (radius*2)+1; // 1 pixel for stretching
//    UIGraphicsBeginImageContext(CGSizeMake(imgSize, imgSize));
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetAlpha(context, 0.5f);
//    CGContextSetLineWidth(context, 0);
//    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
//    
//    CGFloat minx = 0;
//    CGFloat midx = imgSize/2;
//    CGFloat maxx = imgSize;
//    CGFloat miny = 0;
//    CGFloat midy = imgSize/2;
//    CGFloat maxy = imgSize;
//    
//    CGContextMoveToPoint(context, minx, midy);
//    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
//    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
//    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
//    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke);
//    
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    UIImage *stretchImage = [viewImage stretchableImageWithLeftCapWidth:radius topCapHeight:radius];
//    
//    UIImageView *stretch = [[UIImageView alloc] initWithImage:stretchImage];
//    stretch.frame = self.bounds;
//    stretch.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
//    [self addSubview:stretch];
//    [self sendSubviewToBack:stretch];
//    
//    return self;
//}

- (void)setDateLabel:(NSDate *)date indexPath:(NSIndexPath *)indexPath section:(NSNumber *)section;
{
    if (date != nil) {
        _date = date;
        _indexPath = indexPath;
        _section = section;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"d"];
        
        self.label.text = [df stringFromDate:self.date];
    } else {
        _indexPath = indexPath;
        _section = section;
    }
    
   // self.layer.cornerRadius = 10;
  //  self.layer.masksToBounds = YES;
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
        self.backgroundColor = [CTAppearance instance].calendarMidCellColor;
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
    self.backgroundColor = [UIColor colorWithRed:28.0/255 green:78.0/255 blue:149.0/255 alpha:1];
    self.label.textColor = [UIColor whiteColor];
}

- (void)deselect
{
    self.backgroundColor = [UIColor clearColor];
    
    if (![self.date isEqual:[NSNull null]]) {
        NSDate *now = [NSDate date];
        NSDate *previousDay = [now dateByAddingTimeInterval:-1*24*60*60];
        
        if ([self.date compare:previousDay] == NSOrderedDescending) {
            self.label.textColor = [UIColor darkGrayColor];
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
