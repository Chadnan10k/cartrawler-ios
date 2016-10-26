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
#import "RentalBooking.h"
#import "GTBooking.h"

@interface CTViewController : UIViewController

typedef void (^Completion)(BOOL success, NSString *errorMessage);
typedef void (^RentalBookingCompletion)(RentalBooking *booking);
typedef void (^GTBookingCompletion)(GTBooking *booking);

@property (nonatomic) Completion dataValidationCompletion;
@property (nonatomic) RentalBookingCompletion rentalBookingCompletion;
@property (nonatomic) GTBookingCompletion gtBookingCompletion;

@property (nonatomic, strong) CarRentalSearch *search;
@property (nonatomic, strong) GroundTransportSearch *groundSearch;

@property (nonatomic, strong) CTValidation *validationController;

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic, strong) CTViewController *destinationViewController;

- (void)refresh;

- (void)pushToDestination;

@end
