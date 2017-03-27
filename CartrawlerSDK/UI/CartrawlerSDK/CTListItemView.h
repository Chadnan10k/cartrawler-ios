//
//  CTListItemView.h
//  CartrawlerSDK
//
//  Created by Alan on 13/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTLabel.h"

/**
 *  Image Alignment
 */
typedef NS_ENUM(NSUInteger, CTListItemImageAlignment) {
    CTListItemImageAlignmentLeft,
    CTListItemImageAlignmentRight
};

/**
 View with a customisable label and image view
 */
@interface CTListItemView : UIView

/**
 The title label
 */
@property (nonatomic, strong) CTLabel *titleLabel;

/**
 The image view
 */
@property (nonatomic, strong) UIImageView *imageView;

/**
 The image alignment
 */
@property (nonatomic, assign) CTListItemImageAlignment imageAlignment;


@end
