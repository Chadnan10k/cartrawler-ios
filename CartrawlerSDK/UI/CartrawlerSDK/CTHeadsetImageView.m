//
//  CTHeadsetImageView.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 02/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTHeadsetImageView.h"
#import "CTCodedImages.h"

@implementation CTHeadsetImageView

- (void)drawRect:(CGRect)rect {
    [CTCodedImages drawHeadsetWithFrame:rect
                               resizing:CTCodedImagesResizingBehaviorAspectFit
                           primaryColor:self.primaryColor];
}

@end
