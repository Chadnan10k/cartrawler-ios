//
//  LocationSelectView.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 03/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTMatchedLocation.h>
#import "CTDesignableView.h"

IB_DESIGNABLE
@interface CTSelectView : CTDesignableView

+ (void)forceLinkerLoad_;

typedef void (^CTSelectionCompletion)(void);

@property (nonatomic, strong) CTSelectionCompletion viewTapped;

@property (nonatomic, strong) NSString *placeholder;

- (void)setTextFieldText:(NSString *)text;

- (void)shakeAnimation;

@end
