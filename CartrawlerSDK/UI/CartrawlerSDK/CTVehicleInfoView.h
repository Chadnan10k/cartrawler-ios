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

@end

@interface CTVehicleInfoView : UIView

@property (nonatomic, strong) CTRentalSearch *search;
@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic) BOOL isStandalone;

@property (nonatomic, weak) id<CTVehicleInfoDelegate> delegate;

/**
 Sets the vertical offset of the content view to avoid any overlaying toolbars at the top

 @param verticalOffset a vertical offset
 @return CTVehicleInfoView
 */
- (instancetype)initWithVerticalOffset:(CGFloat)verticalOffset;

- (void)refreshView;
@end
