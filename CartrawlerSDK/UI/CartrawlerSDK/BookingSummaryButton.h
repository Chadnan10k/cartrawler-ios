//
//  BookingSummaryButton.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTDesignableView.h"
#import <CartrawlerAPI/CTAvailabilityItem.h>

@protocol BookingSummaryButtonDelegate <NSObject>

- (void)openSummaryTapped;

@end

@interface BookingSummaryButton : CTDesignableView

@property (nonatomic, weak) id<BookingSummaryButtonDelegate> delegate;

@end
