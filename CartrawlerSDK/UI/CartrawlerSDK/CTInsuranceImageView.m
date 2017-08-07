//
//  CTInsuranceImageView.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTInsuranceImageView.h"
#import "CTCodedImages.h"

@implementation CTInsuranceImageView

- (void)drawRect:(CGRect)rect {
    [CTCodedImages drawInsuranceWithFrame:rect
                                 resizing:CTCodedImagesResizingBehaviorAspectFit
                             primaryColor:self.primaryColor];
}

@end
