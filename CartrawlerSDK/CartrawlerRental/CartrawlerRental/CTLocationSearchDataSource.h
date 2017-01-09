//
//  CTLocationSearchDataSource.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 08/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTMatchedLocation.h>
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface CTLocationSearchDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

typedef void (^SelectedLocationCompletion)(CTMatchedLocation *location);

@property (nonatomic, strong) SelectedLocationCompletion selectedLocation;

- (void)updateData:(NSString *)partialText completion:(void (^)(BOOL didSucceed))completion;

@property (nonatomic) BOOL enableGroundTransportLocations;
@property (nonatomic) BOOL invertData;
@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@end
