//
//  CTRentalBookingsViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerSDK/CTViewController.h>

@interface CTRentalBookingsViewController : CTViewController

typedef void (^ShowRentalEngine)(UIViewController *viewController);

@property (nonatomic) ShowRentalEngine showRentalEngine;

@end
