//
//  CTAnalytics.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 09/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTAnalytics : NSObject

+ (void)tagScreen:(nonnull NSString *)name
           detail:(nonnull NSString *)detail
        container:(nonnull NSNumber *)container
        timestamp:(nonnull NSString *)timestamp
     engineLoadID:(nonnull NSString *)engineLoadID
       customerID:(nonnull NSString *)customerID
          queryID:(nonnull NSString *)queryID
             step:(nonnull NSNumber *)step;

+ (void)tagError;

@end
