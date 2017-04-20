//
//  CTAlertController.h
//  CartrawlerSDK
//
//  Created by Alan on 08/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTAlertAction.h"

/**
 An alert view controller with a similar interface to UIAlertController
 
 Displays custom icon, title, message, custom view and buttons as necessary
 
 Add CTAlertActions to add buttons with callback behaviour
 
 Create and present with [self presentViewController:animated:completion:]
 */
@interface CTAlertViewController : UIViewController

/**
 The icon displayed in the circle at the top of the view
 
 @discussion The default value is a pencil image
 */
@property (nonatomic, strong) UIImage *icon;

/**
 The custom view displayed in the presented alert view
 
 @discussion The default value of this property is nil. Set this property to a view that you create to add the custom view to the displayed alert view.
 */
@property (nonatomic, strong) UIView *customView;

/**
 A boolean value that determines whether the user can tap on the dimmed background surrounding the presented alert view to dismiss the alert view controller without any action handlers being executed
 
 @discussion The default value is NO
 */
@property (nonatomic, assign) BOOL backgroundTapDismissalGestureEnabled;

/**
 Designated initialiser

 @param title an optional title
 @param message an optional message
 @return an alert view controller
 */
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message;

/**
 Add an alert action object to be displayed in the alert view
 
 @param action The action object to display in the alert view to be presented
 */
- (void)addAction:(CTAlertAction *)action;


/**
 Removes all alert view actions
 */
- (void)removeAllActions;


/**
 Set the title and the message

 @param title The title
 @param message The message
 */
- (void)setTitle:(NSString *)title message:(NSString *)message;

@end
