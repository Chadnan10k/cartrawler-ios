//
//  CartrawlerRental.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 16/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CartrawlerSDK/CartrawlerSDK.h"
#import "CartrawlerSDK/CTAppearance.h"
#import "CartrawlerSDK/CTViewController.h"
#import "CartrawlerSDK/CTRentalBooking.h"
#import "CartrawlerAPI/CartrawlerAPI.h"

FOUNDATION_EXPORT double CartrawlerRentalVersionNumber;

FOUNDATION_EXPORT const unsigned char CartrawlerRentalVersionString[];

NS_ASSUME_NONNULL_BEGIN

@protocol CartrawlerRentalDelegate <NSObject>

@optional
- (void)didBookVehicle:(CTBooking *)booking;

@end

@interface CartrawlerRental : NSObject

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

//---CarRentalWithFlightDetails---
typedef void (^CarRentalWithFlightDetailsCompletion)(BOOL success, NSString *errorMessage);

//--Delegate--
@property (nonatomic, weak) id<CartrawlerRentalDelegate> delegate;

- (instancetype)initWithCartrawlerSDK:(nonnull CartrawlerSDK *)cartrawlerSDK;

/**
 *  Presents the car rental engine modally in the designated UIViewController
 *
 *  @param viewController The parent view controller
 */
- (void)presentCarRentalInViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
