//
//  CTFilterViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTVehicleAvailability.h"

@protocol CTFilterDelegate <NSObject>

- (void)filterDidUpdate:(NSArray<CTAvailabilityItem *> *)filteredData;

@end

@interface CTFilterViewController : UIViewController

@property (nonatomic, weak) id<CTFilterDelegate> delegate;

+ (CTFilterViewController *)initInViewController:(UIViewController *)viewController withData:(CTVehicleAvailability *)data;
- (void)updateData:(CTVehicleAvailability *)data;
- (void)present;
@end
