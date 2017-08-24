//
//  CTVehicleConfig.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 01/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTVehicleConfig : NSObject

@property (nonatomic, readonly) NSInteger orderBy;
@property (nonatomic, readonly) NSInteger relevance;
@property (nonatomic, readonly) NSInteger rentalDuration;
@property (nonatomic, readonly) BOOL insurance;
@property (nonatomic, readonly) BOOL ccInfo;

- (instancetype)initFromDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

