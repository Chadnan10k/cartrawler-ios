//
//  CTAlertAction.m
//  CartrawlerSDK
//
//  Created by Alan on 09/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAlertAction.h"

@interface CTAlertAction ()
@property (nonatomic) NSString *title;
@property (nonatomic, strong) void (^handler)(CTAlertAction *action);
@end

@implementation CTAlertAction

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(CTAlertAction *action))handler {
    CTAlertAction *action = [[CTAlertAction alloc] init];
    action.title = title;
    action.handler = handler;
    return action;
}

@end
