//
//  CTCarImageView.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 20/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCarImageView.h"
#import "CTCodedImages.h"

@implementation CTCarImageView

- (void)drawRect:(CGRect)rect {
    [CTCodedImages drawCarWithFrame:rect
                           resizing:CTCodedImagesResizingBehaviorAspectFill
                       primaryColor:self.primaryColor];
}


@end
