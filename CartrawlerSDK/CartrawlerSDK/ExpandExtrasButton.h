//
//  ExpandExtrasButton.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTExtraEquipment.h>

@interface ExpandExtrasButton : UIView

@property (strong, nonatomic) NSArray<CTExtraEquipment *> *extras;

+ (void)forceLinkerLoad_;

- (void)refreshView;

@end
