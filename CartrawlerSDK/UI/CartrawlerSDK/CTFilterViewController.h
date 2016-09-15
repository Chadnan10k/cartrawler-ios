//
//  CTFilterViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTVehicleAvailability.h>

@interface CTFilterViewController : UIViewController

+ (void)forceLinkerLoad_;
typedef void (^CTFilteredCompletion)(NSArray<CTVehicle *> *filteredData);
@property (nonatomic, strong) CTFilteredCompletion filterCompletion;

+ (CTFilterViewController *)initInViewController:(UIViewController *)viewController withData:(CTVehicleAvailability *)data;
- (void)updateData:(CTVehicleAvailability *)data;
- (void)present;
@end
