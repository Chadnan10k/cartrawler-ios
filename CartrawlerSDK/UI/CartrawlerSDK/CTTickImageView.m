//
//  CTTickImageView.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 20/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTTickImageView.h"
#import "CTCodedImages.h"

@implementation CTTickImageView

- (void)drawRect:(CGRect)rect {
    [CTCodedImages drawTickWithFrame:rect
                            resizing:CTCodedImagesResizingBehaviorAspectFit
                        primaryColor:self.primaryColor];
}

@end
