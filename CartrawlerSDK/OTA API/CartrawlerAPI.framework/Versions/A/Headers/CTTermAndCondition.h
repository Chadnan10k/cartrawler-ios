//
//  CTTermAndCondition.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 19/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTTermAndCondition : NSObject

/**
 *  Title text of a section
 */
@property (nonatomic, nonnull, readonly) NSString *titleText;
/**
 *  Body text of a section
 */
@property (nonatomic, nonnull, readonly) NSString *bodyText;

- (instancetype)initFromDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
