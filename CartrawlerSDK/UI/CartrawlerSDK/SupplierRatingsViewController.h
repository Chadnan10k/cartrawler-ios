//
//  SupplierRatingsViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTVendor.h>

@interface SupplierRatingsViewController : UIViewController

+ (void)forceLinkerLoad_;

- (void)setVendor:(CTVendor *)vendor;
- (void)setupView;

@end
