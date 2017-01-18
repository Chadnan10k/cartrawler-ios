//
//  RYRRentalManager.h
//  TestApp
//
//  Created by Lee Maguire on 18/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CartrawlerSDK/CartrawlerSDK.h>
#import <CartrawlerRental/CartrawlerRental.h>
#import <CartrawlerInPath/CartrawlerInPath.h>

@interface RYRRentalManager : NSObject <CartrawlerRentalDelegate, CartrawlerInPathDelegate>

@property (nonatomic, strong) CartrawlerSDK *sdk;
@property (nonatomic, strong) CartrawlerRental *rental;
@property (nonatomic, strong) CartrawlerInPath *inPath;

@property (weak, nonatomic) UIButton *callToAction;//bad practice passing this obj but who cares its a test app.

+ (instancetype)instance;

- (void)reset;
- (void)setupInPath:(UIView *)view;
- (void)inPathOpenEngine:(UIViewController *)vc;
- (void)removeVehicle;
- (void)changeRoundTrip:(BOOL)isRoundTrip;
- (void)mockPayment;

@end
