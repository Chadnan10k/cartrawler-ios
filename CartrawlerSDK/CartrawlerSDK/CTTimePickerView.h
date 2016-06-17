//
//  CTTimePickerView.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 13/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTTimePickerView : NSObject

+ (void)forceLinkerLoad_;

typedef void (^CTTimePickerCallback)(NSDate *time);

@property (nonatomic) CTTimePickerCallback timeSelection;

- (id)initInView:(UIView *)superview mininumDate:(NSDate *)mininumDate;
- (void)present;
- (void)hide;

@end
