//
//  LocationSearchViewController.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 08/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTMatchedLocation.h"
#import "CartrawlerAPI.h"

typedef NS_ENUM(NSUInteger, CTLocationSearchContext) {
    CTLocationSearchContextUndefined,
    CTLocationSearchContextPickup,
    CTLocationSearchContextDropoff
};

@interface CTLocationSearchViewController : UIViewController

typedef void (^SelectedLocationCompletion)(CTMatchedLocation *location);

@property (nonatomic, strong) SelectedLocationCompletion selectedLocation;
@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@property (nonatomic) BOOL enableGroundTransportLocations;
@property (nonatomic) BOOL invertData;

/**
 For analytics tagging, the view needs to know if it editing a previous search
 */
@property (nonatomic) BOOL editMode;

@property (nonatomic, assign) CTLocationSearchContext searchContext;

@end
