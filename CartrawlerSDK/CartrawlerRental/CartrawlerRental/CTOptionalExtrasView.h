//
//  CTOptionalExtrasView.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTDesignableView.h"
#import <CartrawlerAPI/CTExtraEquipment.h>

@protocol OptionalExtrasDelegate <NSObject>

- (void)pushToExtrasView;

@end

@interface CTOptionalExtrasView : CTDesignableView

@property (strong, nonatomic) NSArray <CTExtraEquipment *> *extras;
@property (weak) id<OptionalExtrasDelegate> delegate;

- (void)hideView:(BOOL)hide;

@end
