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



typedef void (^VehicleSelectionCompletion)(CTAvailabilityItem *vehicle);
typedef void (^CTScrollDirectionChanged)(BOOL up);

@property (nonatomic) CTScrollDirectionChanged direction;

- (void)initWithVehicleAvailability:(NSArray <CTAvailabilityItem *> *)data completion:(VehicleSelectionCompletion)completion;
- (void)updateSelection:(NSArray <CTAvailabilityItem *> *)data;
- (void)showLoading;
- (void)hideLoading;

@end
