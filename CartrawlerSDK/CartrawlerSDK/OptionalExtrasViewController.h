//
//  OptionalExtrasViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTExtraEquipment.h>

@interface OptionalExtrasViewController : UIViewController

+ (void)forceLinkerLoad_;

typedef void (^OptionalExtrasLoaded)(double viewHeight);

@property (nonatomic, strong) OptionalExtrasLoaded optionalExtrasLoaded;
@property (strong, nonatomic) NSArray<CTExtraEquipment *> *extras;

- (void)refreshView;

@end
