//
//  CTAlertViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 09/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAlertViewModel.h"

@implementation CTAlertViewModel

- (instancetype)initWithTitle:(NSString *)title message:(NSAttributedString *)message action:(CTAlertAction *)action {
    self = [super init];
    _title = title;
    _message = message;
    _action = action;
    return self;
}

@end
