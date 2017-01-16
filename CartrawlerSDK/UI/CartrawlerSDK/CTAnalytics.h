//
//  CTAnalytics.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 09/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTTag.h"
#import "CTErrorTag.h"

@interface CTAnalytics : NSObject

+ (instancetype)instance;

- (void)tagScreen:(nonnull NSString *)name
           detail:(nonnull NSString *)detail
             step:(nonnull NSNumber *)step;

- (void)tagError:(nonnull NSString *)step
           event:(nonnull NSString *)event
         message:(nonnull NSString *)message;

@end
