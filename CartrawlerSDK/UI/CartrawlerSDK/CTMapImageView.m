//
//  CTMapImageView.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 02/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTMapImageView.h"
#import "CTCodedImages.h"

@implementation CTMapImageView

- (void)drawRect:(CGRect)rect {
    [CTCodedImages drawMapWithFrame:rect
                           resizing:CTCodedImagesResizingBehaviorAspectFit
     primaryColor:self.primaryColor];
}

@end
