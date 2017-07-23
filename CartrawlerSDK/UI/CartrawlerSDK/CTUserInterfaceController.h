//
//  CTUserInterfaceController.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/18/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTAppState.h"

@interface CTUserInterfaceController : NSObject

- (void)updateWithAppState:(CTAppState *)appState;

@end
