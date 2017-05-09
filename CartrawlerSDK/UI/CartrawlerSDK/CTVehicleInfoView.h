//
//  CTVehicleInfoView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 21/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerSDK/CTHeaders.h>

@protocol CTVehicleInfoDelegate <NSObject>

typedef void (^CTNewVehiclePriceCompeltion)(BOOL success, NSString *error);

- (void)infoViewPresentViewController:(UIViewController *)viewController;
- (void)infoViewPushToExtraDetail;
- (void)infoViewPushViewController:(UIViewController *)viewController;
- (void)infoViewRequestNewVehiclePrice:(CTNewVehiclePriceCompeltion)completion;
- (void)infoViewPresentVehicleSelection;
- (void)infoViewPushToNextStep;

@end

@interface CTVehicleInfoView : UIView

@property (nonatomic, strong) CTRentalSearch *search;
@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic, weak) id<CTVehicleInfoDelegate> delegate;

@property (nonatomic, readonly) BOOL insuranceViewDidAppear;

- (void)refreshView;
@end
