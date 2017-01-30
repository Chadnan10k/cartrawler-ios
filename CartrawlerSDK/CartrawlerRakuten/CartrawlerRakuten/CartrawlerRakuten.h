//
//  CartrawlerRakuten.h
//  CartrawlerRakuten
//
//  Created by Lee Maguire on 27/01/2017.
//  Copyright © 2017 Lee Maguire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTAnalyticsEvent.h"

//! Project version number for CartrawlerRakuten.
FOUNDATION_EXPORT double CartrawlerRakutenVersionNumber;

//! Project version string for CartrawlerRakuten.
FOUNDATION_EXPORT const unsigned char CartrawlerRakutenVersionString[];

@protocol CTExternalAnalyticsDelegate <NSObject>

- (void)didReceiveEvent:(CTAnalyticsEvent *)event;
- (void)didReceiveSaleEvent:(CTAnalyticsEvent *)event;

@end

@interface CartrawlerRakuten : NSObject <CTExternalAnalyticsDelegate>

@end

