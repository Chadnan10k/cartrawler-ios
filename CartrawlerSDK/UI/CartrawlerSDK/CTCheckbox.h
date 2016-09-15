//
//  CTCheckbox.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 07/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CTCheckbox : UIView

typedef void (^SelectionCompletion)(BOOL selection);

@property (nonatomic, strong) SelectionCompletion viewTapped;

@property (nonatomic) IBInspectable BOOL enabled;

+ (void)forceLinkerLoad_;

@end
