//
//  CTAppController.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/18/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTActions.h"

@interface CTAppController : NSObject

+ (void)dispatchAction:(CTAction)action payload:(id)payload;

@end
