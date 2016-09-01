//
//  LocationSearchViewController.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 08/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTMatchedLocation.h>

@interface LocationSearchViewController : UIViewController

+ (void)forceLinkerLoad_;

typedef void (^SelectedLocationCompletion)(CTMatchedLocation *location);

@property (nonatomic, strong) SelectedLocationCompletion selectedLocation;

@property BOOL enableGroundTransportLocations;

@end
