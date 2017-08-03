//
//  CTNotificationsController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/27/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTNotificationsController.h"
#import <UIKit/UIKit.h>
#import "CTAppController.h"

@implementation CTNotificationsController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addKeyboardNotifications];
    }
    return self;
}

// MARK: Keyboard Notifications

- (void)addKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGFloat keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    
    [CTAppController dispatchAction:CTActionNotificationUserInputDidShow payload:@(keyboardHeight)];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [CTAppController dispatchAction:CTActionNotificationUserInputDidHide payload:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


@end
