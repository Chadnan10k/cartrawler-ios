//
//  CTTimePickerView.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 13/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTTimePickerView : UIView

typedef void (__weak ^CTTimePickerCallback)(NSDate *time);

@property (nonatomic, weak) CTTimePickerCallback timeSelection;

@end
