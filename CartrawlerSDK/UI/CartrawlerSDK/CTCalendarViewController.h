//
//  CTCalendarManagerViewController.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 13/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CTCalendarDelegate <NSObject>

@required
- (void)didPickDates:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate;

@end

@interface CTCalendarViewController : UIViewController



@property (nonatomic, weak) id<CTCalendarDelegate> delegate;
@property (nonatomic) BOOL singleDateSelection;
@property (nonatomic, strong) NSDate *mininumDate;

- (void)reset;

@end
