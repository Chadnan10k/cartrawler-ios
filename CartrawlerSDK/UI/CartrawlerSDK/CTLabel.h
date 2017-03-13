//
//  CTLabel.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 08/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CTLabel : UILabel

@property (nonatomic) IBInspectable BOOL useBoldFont;
@property (nonatomic) IBInspectable BOOL isHeaderTitle;
@property (nonatomic) IBInspectable BOOL isSubheaderTitle;


/**
 Convienience Initializer

 @param textSize The text size
 @param textColor The text color
 @param textAlignment The text alignment
 @return CTLabel
 */
- (instancetype)init:(CGFloat)textSize
           textColor:(UIColor *)textColor
       textAlignment:(nullable NSTextAlignment *)textAlignment
            boldFont:(BOOL)boldFont;

@end
