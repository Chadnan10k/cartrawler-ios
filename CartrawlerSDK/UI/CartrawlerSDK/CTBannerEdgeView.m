//
//  CTBannerEdgeView.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/26/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTBannerEdgeView.h"
#import "CTBannerEdge.h"

@implementation CTBannerEdgeView

- (void)drawRect:(CGRect)rect {
    [CTBannerEdge drawArtboardWithFrame:rect
                               resizing:CTBannerEdgeResizingBehaviorAspectFit
                           primaryColor:self.primaryColor];
}

@end
