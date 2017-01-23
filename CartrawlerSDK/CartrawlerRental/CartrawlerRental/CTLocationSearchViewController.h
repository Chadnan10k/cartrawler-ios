//
//  LocationSearchViewController.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 08/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTMatchedLocation.h>
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface CTLocationSearchViewController : UIViewController

typedef void (^SelectedLocationCompletion)(CTMatchedLocation *location);

@property (nonatomic, strong) SelectedLocationCompletion selectedLocation;
@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic) BOOL enableGroundTransportLocations;
@property (nonatomic) BOOL invertData;

@end
