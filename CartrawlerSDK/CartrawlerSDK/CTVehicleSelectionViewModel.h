//
//  CTVehicleSelectionViewModel.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartrawlerAPI/CTVehicleAvailability.h"
#import "CartrawlerAPI/CTVehicle.h"
#import <UIKit/UIKit.h>

@interface CTVehicleSelectionViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

typedef void (^VehicleSelectionCompletion)(CTVehicle *vehicle);

- (id)initWithData:(NSArray <CTVehicle *> *)data cellSelected:(VehicleSelectionCompletion)cellSeleted;

@end
