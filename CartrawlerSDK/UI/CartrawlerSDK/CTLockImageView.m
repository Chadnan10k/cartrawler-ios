//
//  CTLockImageView.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 02/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTLockImageView.h"
#import "CTCodedImages.h"

@implementation CTLockImageView

- (void)drawRect:(CGRect)rect {
    [CTCodedImages drawLock2WithFrame:rect
                             resizing:CTCodedImagesResizingBehaviorAspectFit
     primaryColor:self.primaryColor];
}

@end
