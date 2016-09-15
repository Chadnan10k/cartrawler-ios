//
//  CTCalendarView.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 13/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTCalendarView : UIView

@property (nonatomic) CGFloat padding UI_APPEARANCE_SELECTOR;

+ (void)forceLinkerLoad_;

typedef void (^CTDateSelectionCompletion)(NSDate *pickup, NSDate *dropoff);
typedef void (^CTDiscardDates)(void);

@property (nonatomic) CTDateSelectionCompletion datesSelected;
@property (nonatomic) CTDiscardDates discard;
@property (nonatomic, strong) NSDate *mininumDate;

- (void)setupWithFrame:(CGRect)frame;

@end
