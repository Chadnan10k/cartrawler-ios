//
//  CTEngineInfo.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 10/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTEngineInfo : NSObject

@property (nonatomic, nonnull, readonly) NSString *uniqueID;

@property (nonatomic, nonnull, readonly) NSString *engineLoadID;

@property (nonatomic, nonnull, readonly) NSString *queryID;

- (instancetype)initFromDictionary:(nonnull NSDictionary *)dict;

@end
NS_ASSUME_NONNULL_END
