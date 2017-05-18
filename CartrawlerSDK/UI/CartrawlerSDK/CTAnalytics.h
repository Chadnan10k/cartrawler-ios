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

typedef NS_ENUM(NSUInteger, CTAnalyticsStep) {
    CTAnalyticsStepSearch = 1,
    CTAnalyticsStepVehicleSelection,
    CTAnalyticsStepVehicleDetails,
    CTAnalyticsStepPayment,
    CTAnalyticsStepConfirmation
};

NS_ASSUME_NONNULL_BEGIN

@interface CTAnalytics : NSObject

@property (nonatomic, assign) CTAnalyticsStep analyticsStep;

+ (instancetype)instance;

- (void)tagScreen:(nonnull NSString *)name
           detail:(nonnull NSString *)detail
             step:(nullable NSNumber *)step;

- (void)tagError:(nonnull NSString *)step
           event:(nonnull NSString *)event
         message:(nonnull NSString *)message;

@end

NS_ASSUME_NONNULL_END
