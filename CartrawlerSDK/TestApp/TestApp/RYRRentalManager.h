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
#import <CartrawlerRakuten/CartrawlerRakuten.h>

@interface RYRRentalManager : NSObject <CartrawlerRentalDelegate, CartrawlerInPathDelegate>

@property (nonatomic, strong) CartrawlerSDK *sdk;
@property (nonatomic, strong) CartrawlerRental *rental;
@property (nonatomic, strong) CartrawlerInPath *inPath;
@property (nonatomic, strong) UIViewController *parent;

@property (strong, nonatomic) UIButton *callToAction;//bad practice passing this obj but who cares its a test app.

+ (instancetype)instance;

- (void)changeEndpoint:(BOOL)production;
- (void)changeEndpointInPath:(BOOL)production;


- (void)reset;
- (void)setupInPath:(UIView *)view parentVC:(UIViewController *)parentVC;
- (void)inPathOpenEngine:(UIViewController *)vc;
- (void)removeVehicle;
- (void)changeRoundTrip:(BOOL)isRoundTrip;
- (void)mockPayment;

- (BOOL)currentEndpoint;

- (void)refreshInPath;

@end
