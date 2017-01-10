//
//  CTEngineInfo.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 10/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTEngineInfo : NSObject

@property (nonatomic, nonnull, readonly) NSString *uniqueID;

@property (nonatomic, nonnull, readonly) NSString *engineLoadID;

@property (nonatomic, nonnull, readonly) NSString *queryID;

- (instancetype)initFromDictionary:(NSDictionary *)dict;

@end
