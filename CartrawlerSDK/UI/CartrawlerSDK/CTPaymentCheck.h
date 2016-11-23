//
//  CTPaymentCheck.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 22/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum CTPaymentStatus : NSUInteger {
    CTPaymentStatusSuccess = 0, //we have a car
    CTPaymentStatusNotAvailable, //we have not got a car
    CTPaymentStatusError //communication error ie. no internet
} CTPaymentStatus;

@protocol CTPaymentCheckDelegate <NSObject>

@required
- (void)checkDidReceiveResponse:(CTPaymentStatus)status;

@end

@interface CTPaymentCheck : NSObject

@property (nonatomic, weak) id<CTPaymentCheckDelegate> delegate;

- (instancetype)initWithRequestorId:(NSString *)requestorId
                        sandboxMode:(BOOL)sandboxMode
                         pickupDate:(NSDate *)pickupDate
                              email:(NSString *)email;
- (void)start;
- (void)stop;

@end
