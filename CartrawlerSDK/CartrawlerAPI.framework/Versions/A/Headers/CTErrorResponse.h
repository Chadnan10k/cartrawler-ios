//
//  ErrorResponse.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 12/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTErrorResponse
 */
@interface CTErrorResponse : NSObject
/**
 *  Description of the error returned
 */
@property (nonatomic, nonnull, readonly) NSString *errorMessage;

- (instancetype)initWithDictionary:(nullable NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
