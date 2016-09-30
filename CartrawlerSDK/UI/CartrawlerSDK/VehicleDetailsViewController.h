//
//  VehicleDetailsViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <CartrawlerSDK/CartrawlerSDK.h>

@interface VehicleDetailsViewController : CTViewController

+ (void)forceLinkerLoad_;

typedef void (^VehicleDetailsViewControllerCompletion)(BOOL tapped);

@end
