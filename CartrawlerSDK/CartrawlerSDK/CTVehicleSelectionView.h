//
//  CTVehicleSelectionView.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartrawlerAPI/CTVehicleAvailability.h"
#import "CartrawlerAPI/CartrawlerAPI.h"

@interface CTVehicleSelectionView : UIView

+ (void)forceLinkerLoad_;

typedef void (^VehicleSelectionCompletion)(CTVehicle *vehicle);

- (void)initWithVehicleAvailability:(NSArray <CTVehicle *> *)data completion:(VehicleSelectionCompletion)completion;
- (void)showLoading;
- (void)hideLoading;

@end
