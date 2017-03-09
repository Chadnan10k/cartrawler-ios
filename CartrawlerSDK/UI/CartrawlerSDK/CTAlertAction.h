//
//  CTAlertAction.h
//  CartrawlerSDK
//
//  Created by Alan on 09/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A simpler implementation of UIAlertAction
 
 Use this to create buttons on a CTAlertViewController
 */
@interface CTAlertAction : NSObject

/**
 Designated initialiser

 @param title a title
 @param handler a handler
 @return a CTAlertAction instance
 */
+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(CTAlertAction *action))handler;

/**
 The title to be displayed on the button
 */
@property (nonatomic, readonly) NSString *title;

/**
 The handler to be called when the button is tapped
 */
@property (nonatomic, readonly) void (^handler)(CTAlertAction *action);

@end
