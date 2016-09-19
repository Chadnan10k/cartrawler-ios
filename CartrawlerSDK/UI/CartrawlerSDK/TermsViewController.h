//
//  TermsViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 05/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarRentalSearch.h"
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface TermsViewController : UIViewController

+ (void)forceLinkerLoad_;

- (void)setData:(CarRentalSearch *)data cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI;

@end
