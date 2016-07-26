//
//  OptionalExtrasView.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTDesignableView.h"
#import <CartrawlerAPI/CTExtraEquipment.h>

@interface OptionalExtrasView : CTDesignableView

@property (strong, nonatomic) NSArray <CTExtraEquipment *> *extras;
@property (nonatomic) CGRect initialFrame;

+ (void)forceLinkerLoad_;

- (void)open:(BOOL)hideExpandButton;
- (void)close;

@end
