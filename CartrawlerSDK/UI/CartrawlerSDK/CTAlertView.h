//
//  CTAlertView.h
//  CartrawlerSDK
//
//  Created by Alan on 09/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 The alert view which is displayed by a CTAlertViewController
 */
@interface CTAlertView : UIView

/**
 The icon image view displayed at the top
 */
@property (nonatomic, strong) UIImageView *iconView;

/**
 The title label
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 The message text view
 */
@property (nonatomic, strong) UITextView *messageTextView;

/**
 A content view. Added below message and above buttons
 */
@property (nonatomic, strong) UIView *contentView;

/**
 Pass in an array of buttons to be displayed
 
 @discussion One or two buttons are displayed horizontally, more than two are displayed vertically
 */
@property (nonatomic, strong) NSArray *actionButtons;


/**
 Removes all action buttons
 */
- (void)removeAllActionButtons;

@end
