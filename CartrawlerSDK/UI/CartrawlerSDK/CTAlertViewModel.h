//
//  CTAlertViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 09/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTAlertAction.h"

@interface CTAlertViewModel : NSObject
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSAttributedString *message;
@property (nonatomic, readonly) CTAlertAction *action;

- (instancetype)initWithTitle:(NSString *)title message:(NSAttributedString *)message action:(CTAlertAction *)action;
@end
