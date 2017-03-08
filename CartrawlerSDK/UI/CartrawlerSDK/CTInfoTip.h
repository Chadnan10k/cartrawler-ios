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
 A view for displaying an info tip, with customisable image and text. Default icon is a pencil if no image set
 */
@interface CTInfoTip : UIView

/**
 Implement this delegate to be informed when the info button is tapped
 */
@property (nonatomic, weak) id <CTInfoTipDelegate> delegate;

/**
 Designated Initialiser

 @param icon icon image to display in the circle
 @param text text to display
 @return a CTInfoTip instance
 */
- (instancetype)initWithIcon:(UIImage *)icon text:(NSString *)text;

@end
