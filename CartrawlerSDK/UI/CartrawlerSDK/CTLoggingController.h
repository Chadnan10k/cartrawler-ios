//
//  CTLoggingController.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 08/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTActions.h"
#import "CTNavigationState.h"

@interface CTLoggingController : NSObject

- (void)logAction:(CTAction)action payload:(id)payload;

@end
