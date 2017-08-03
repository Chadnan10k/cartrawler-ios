//
//  CTSearchImageView.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 02/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchImageView.h"
#import "CTCodedImages.h"

@implementation CTSearchImageView

- (void)drawRect:(CGRect)rect {
    [CTCodedImages drawSearchWithFrame:rect
                              resizing:CTCodedImagesResizingBehaviorAspectFit
     primaryColor:self.primaryColor];
}

@end
