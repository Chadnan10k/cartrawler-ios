//
//  CTCreditCardImageView.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 02/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCreditCardImageView.h"
#import "CTCodedImages.h"

@implementation CTCreditCardImageView

- (void)drawRect:(CGRect)rect {
    [CTCodedImages drawCreditCardWithFrame:rect
                                  resizing:CTCodedImagesResizingBehaviorAspectFit
                              primaryColor:self.primaryColor];
}

@end
