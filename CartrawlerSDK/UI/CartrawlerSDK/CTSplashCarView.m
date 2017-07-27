//
//  CTSplashCarView.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSplashCarView.h"
#import "CTSplashCar.h"

@implementation CTSplashCarView

- (void)drawRect:(CGRect)rect {
    [CTSplashCar drawArtboardWithFrame:rect
                              resizing:CTSplashCarResizingBehaviorAspectFit
                          primaryColor:self.primaryColor];
}

@end
