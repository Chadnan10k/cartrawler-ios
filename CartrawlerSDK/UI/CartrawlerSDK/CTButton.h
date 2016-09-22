//
//  CTButton.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 07/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CTButton : UIButton

@property (nonatomic, strong) IBInspectable UIColor *overrideBackgroundColor;
@property (nonatomic, strong) IBInspectable UIColor *overrideTextColor;
@property (nonatomic) IBInspectable BOOL disableShadow;

+ (void)forceLinkerLoad_;

- (void)shake;

@end
