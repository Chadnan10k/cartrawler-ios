//
//  RentalBookingsViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTViewController.h"

@interface RentalBookingsViewController : CTViewController

typedef void (^ShowRentalEngine)(UIViewController *viewController);

@property (nonatomic) ShowRentalEngine showRentalEngine;

@end
