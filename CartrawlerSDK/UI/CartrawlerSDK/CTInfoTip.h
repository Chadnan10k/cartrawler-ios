//
//  CTInfoTip.h
//  CartrawlerSDK
//
//  Created by Alan on 07/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTInfoTip;

/**
 Implement this delegate to be informed when the info button is tapped
 */
@protocol CTInfoTipDelegate

/**
 This method is called on the delegate when the info button is tapped

 @param infoTip the info tip instance
 */
- (void)infoTipWasTapped:(CTInfoTip *)infoTip;

@end

/**
 A view for displaying a tool tip, with customisable image and text
 */
@interface CTInfoTip : UIView

/**
 Implement this delegate to be informed when the info button is tapped
 */
@property (nonatomic, weak) id <CTInfoTipDelegate> delegate;

/**
 Set the info tip text

 @param text a string
 */
- (void)setText:(NSString *)text;

/**
 Set the info tip image

 @param image an image
 */
- (void)setImage:(UIImage *)image;

@end
