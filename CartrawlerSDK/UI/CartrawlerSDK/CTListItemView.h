//
//  CTListItemView.h
//  CartrawlerSDK
//
//  Created by Alan on 13/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 View with a title and image
 */
@interface CTListItemView : UIView

/**
 Initialise with title and image

 @param title the title
 @param image an image
 @return a list item view
 */
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image;

@end
