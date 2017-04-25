//
//  CTViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTRentalSearch.h"
#import "CTValidation.h"
#import "CTAnalyticsEvent.h"

@protocol CTViewControllerDelegate <NSObject>

@required

- (void)didDismissViewController:(NSString *)identifier;

@optional

- (void)didBookVehicle:(CTBooking *)booking;

@end

@protocol CTAnalyticsDelegate <NSObject>

@required

- (void)sendAnalyticsEvent:(CTAnalyticsEvent *)event;
- (void)sendAnalyticsSaleEvent:(CTAnalyticsEvent *)event;

@end

@interface CTViewController : UIViewController

typedef void (^Completion)(BOOL success, NSString *errorMessage);
typedef void (^RentalBookingCompletion)(id *booking);

@property (nonatomic) Completion dataValidationCompletion;
@property (nonatomic) RentalBookingCompletion rentalBookingCompletion;

@property (nonatomic, strong) CTRentalSearch *search;

@property (nonatomic, strong) CTValidation *validationController;

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic, weak) CTViewController *destinationViewController;
@property (nonatomic, weak) CTViewController *fallbackViewController;
@property (nonatomic, weak) CTViewController *optionalRoute;

@property (nonatomic, weak) id<CTViewControllerDelegate> delegate;
@property (nonatomic, weak) id<CTAnalyticsDelegate> analyticsDelegate;

- (void)refresh;

- (void)pushToDestination;

- (void)dismiss;

- (void)presentModalViewController:(UIViewController *)viewController;

- (void)requestVehicles:(Completion)completion;

- (void)requestNewVehiclePrice:(Completion)completion;

//MARK: mark Analytics

- (void)sendEvent:(BOOL)cartrawlerOnly customParams:(NSDictionary *)customParams eventName:(NSString *)eventName eventType:(NSString *)eventType;
- (void)trackSale;

@end
