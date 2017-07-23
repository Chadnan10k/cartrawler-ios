//
//  CTNavigationState.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/18/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CTNavigationState : NSObject

@property (nonatomic) UIViewController *parentViewController;

@property (nonatomic) NSUInteger desiredStep;

@end
