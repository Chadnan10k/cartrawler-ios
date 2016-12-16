//
//  GTBookingsViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTBookingsViewController : UIViewController



typedef void (^ShowGTEngine)(UIViewController *viewController);

@property (nonatomic) ShowGTEngine showGTEngine;

@end
