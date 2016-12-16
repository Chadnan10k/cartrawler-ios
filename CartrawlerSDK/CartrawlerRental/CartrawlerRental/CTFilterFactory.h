//
//  CTFilterFactory.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 03/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTFilterDataSource.h"
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface CTFilterFactory : NSObject

@property (strong, nonatomic) CTFilterDataSource *carSizeDataSource;
@property (strong, nonatomic) CTFilterDataSource *locationDataSource;
@property (strong, nonatomic) CTFilterDataSource *vendorsDataSource;
@property (strong, nonatomic) CTFilterDataSource *fuelPolicyDataSource;
@property (strong, nonatomic) CTFilterDataSource *transmissionDataSource;

@property (strong, nonatomic) NSMutableArray<CTVehicle *> *filteredData;

- (void)setDataSources;

- (id)initWithFilterData:(CTVehicleAvailability *)data;
- (void)update:(CTVehicleAvailability *)data;

- (void)filter;

@end
