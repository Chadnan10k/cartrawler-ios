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

+ (void)forceLinkerLoad_;

@property (nonatomic, weak) id<CTCalendarDelegate> delegate;

@end
