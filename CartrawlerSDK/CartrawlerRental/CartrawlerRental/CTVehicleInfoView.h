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
- (void)infoViewAddInsuranceTapped:(BOOL)didAddInsurance;
- (void)infoViewDidScroll:(CGFloat)verticalOffset;
- (void)infoViewDidScrollToInsuranceView;

@end

@interface CTVehicleInfoView : UIView

@property (nonatomic, strong) CTRentalSearch *search;
@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic, weak) id<CTVehicleInfoDelegate> delegate;

@property (nonatomic, readonly) BOOL insuranceViewDidAppear;

/**
 Sets the vertical offset of the content view to avoid any overlaying toolbars at the top
 
 @param verticalOffset a vertical offset
 @return CTVehicleInfoView
 */
- (instancetype)initWithVerticalOffset:(CGFloat)verticalOffset;

/**
 Updates the view with the provided vehicle
 If the vehicle is the same as existing, no updates will be made

 @param vehicle the vehicle
 */
- (void)refreshViewWithVehicle:(CTAvailabilityItem *)vehicle;
@end
