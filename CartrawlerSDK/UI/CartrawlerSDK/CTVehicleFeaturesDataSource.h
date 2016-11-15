//
//  CTInclusionsDataSource.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CTVehicleFeaturesDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

- (void)setData:(NSArray <NSDictionary *> *)items;

@end
