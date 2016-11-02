//
//  CTVehicleIndexation.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 01/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTVehicleIndexation : NSObject

@property (nonatomic, readonly) NSInteger key;
@property (nonatomic, nonnull, readonly) NSString *bundleText;
@property (nonatomic, nonnull, readonly) NSString *bundleType;

- (instancetype)initFromDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

