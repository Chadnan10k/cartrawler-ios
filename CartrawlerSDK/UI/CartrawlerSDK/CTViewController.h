//
//  CTViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTSearch.h"

@interface CTViewController : UIViewController

typedef void (^Completion)(BOOL success, NSString *errorMessage);

typedef enum ViewType : NSUInteger {
    ViewTypeSearchDetails,
    ViewTypeVehicleSelection,
    ViewTypeInsurance,
    ViewTypeDriverDetails,
    ViewTypePaymentDetails,
    ViewTypeGeneric
} ViewType;

@property (nonatomic) Completion dataValidationCompletion;

@property (nonatomic) ViewType viewType;

@property (nonatomic, strong) CTSearch *search;
@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic, strong) CTViewController *destinationViewController;
@property (nonatomic, strong) CTViewController *fallBackViewController;

- (void)refresh;

- (void)pushToDestination;

@end
