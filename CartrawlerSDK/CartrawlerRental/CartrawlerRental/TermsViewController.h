//
//  TermsViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 05/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerSDK/CTRentalSearch.h>
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface TermsViewController : UIViewController



- (void)setData:(CTRentalSearch *)data cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI;

@end
