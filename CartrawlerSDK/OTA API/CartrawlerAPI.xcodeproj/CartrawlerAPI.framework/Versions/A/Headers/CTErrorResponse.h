//
//  ErrorResponse.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 12/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTErrorResponse : NSObject

@property (nonatomic, strong) NSString *errorMessage;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
