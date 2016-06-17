//
//  ErrorResponse.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 12/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  CTErrorResponse
 */
@interface CTErrorResponse : NSObject
/**
 *  Description of the error returned
 */
@property (nonatomic, strong, readonly) NSString *errorMessage;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
