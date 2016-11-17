//
//  CTViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarRentalSearch.h"
#import "GroundTransportSearch.h"
#import "CTValidation.h"
#import "CTRentalBooking.h"
#import "GTBooking.h"

@protocol CTViewControllerDelegate <NSObject>

@required
- (void)didDismissViewController;
- (void)didBookVehicle:(CTBooking *)booking;
- (void)didBookGroundTransport:(GTBooking *)booking;

@end

@interface CTViewController : UIViewController

typedef void (^Completion)(BOOL success, NSString *errorMessage);
typedef void (^RentalBookingCompletion)(CTRentalBooking *booking);
typedef void (^GTBookingCompletion)(GTBooking *booking);

@property (nonatomic) Completion dataValidationCompletion;
@property (nonatomic) RentalBookingCompletion rentalBookingCompletion;
@property (nonatomic) GTBookingCompletion gtBookingCompletion;

@property (nonatomic, strong) CarRentalSearch *search;
@property (nonatomic, strong) GroundTransportSearch *groundSearch;

@property (nonatomic, strong) CTValidation *validationController;

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic, strong) CTViewController *destinationViewController;
@property (nonatomic, strong) CTViewController *fallbackViewController;
@property (nonatomic, strong) CTViewController *optionalRoute;

@property (nonatomic, weak) id<CTViewControllerDelegate> delegate;

- (void)refresh;
- (void)pushToDestination;

@end
