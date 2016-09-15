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

@interface CTViewController : UIViewController

typedef void (^Completion)(BOOL success, NSString *errorMessage);

@property (nonatomic) Completion dataValidationCompletion;

@property (nonatomic, strong) CarRentalSearch *search;
@property (nonatomic, strong) GroundTransportSearch *groundSearch;

@property (nonatomic, strong) CTValidation *validationController;

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic, strong) CTViewController *destinationViewController;
@property (nonatomic, strong) CTViewController *fallBackViewController;

- (void)refresh;

- (void)pushToDestination;

@end
