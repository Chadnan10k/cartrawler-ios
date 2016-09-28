//
//  CTVehicleSelectionViewModel.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartrawlerAPI/CTVehicleAvailability.h"
#import <UIKit/UIKit.h>

@interface CTVehicleSelectionViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

typedef void (^VehicleSelectionCompletion)(CTAvailabilityItem *vehicle);
typedef void (^CTScrollViewDirection)(BOOL up);

- (id)initWithData:(NSArray <CTAvailabilityItem *> *)data cellSelected:(VehicleSelectionCompletion)cellSeleted;
- (void)updateData:(NSArray <CTAvailabilityItem *> *)data;
@property (nonatomic) CTScrollViewDirection direction;
@end
