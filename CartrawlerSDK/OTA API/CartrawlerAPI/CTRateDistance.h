//
//  CTRateDistance.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 05/05/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTRateDistance : NSObject

@property (nonatomic, strong) NSString *distanceUnitName;
@property (nonatomic, strong) NSString *vehiclePeriodUnitName;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic) BOOL isUnlimited;


- (instancetype)initFromDictionary:(NSDictionary *)dictionary;

@end
