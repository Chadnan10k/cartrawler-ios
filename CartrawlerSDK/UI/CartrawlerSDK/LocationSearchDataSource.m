//
//  LocationSearchDataSource.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 08/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "LocationSearchDataSource.h"
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "CTLabel.h"
#import "CTSDKSettings.h"
#import "LocationSearchTableViewCell.h"
#import "GooglePlaceService.h"

@interface LocationSearchDataSource()
@property (nonatomic, strong) NSMutableArray <CTMatchedLocation *> *airportLocations;
@property (nonatomic, strong) NSMutableArray <CTMatchedLocation *> *otherLocations;
@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@end

@implementation LocationSearchDataSource

+ (void)forceLinkerLoad_
{
    
}

- (id)init
{
    self = [super init];
    
    _airportLocations = [[NSMutableArray alloc] init];
    _otherLocations = [[NSMutableArray alloc] init];
    
    _cartrawlerAPI = [[CartrawlerAPI alloc] initWithClientKey:[CTSDKSettings instance].clientId
                                                     language:[CTSDKSettings instance].languageCode
                                                        debug:[CTSDKSettings instance].isDebug];
    [self.cartrawlerAPI enableLogging:NO];
    return self;
}

- (void)updateData:(NSString *)partialText completion:(void (^)(BOOL didSucceed))completion
{
    
    __weak typeof (self) weakSelf = self;
    
    _airportLocations = [[NSMutableArray alloc] init];
    _otherLocations = [[NSMutableArray alloc] init];
    completion(YES);//clear the view of any current results
    
    [self.cartrawlerAPI locationSearchWithPartialString:partialText
                                       needsCoordinates:self.enableGroundTransportLocations
                                        completion:^(CTLocationSearch *response, CTErrorResponse *error)
     {
        if (error == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.airportLocations removeAllObjects];

                for (CTMatchedLocation *location in response.matchedLocations) {
                    if (location.isAtAirport) {
                        [weakSelf.airportLocations addObject:location];
                    } else {
                        if (!weakSelf.enableGroundTransportLocations) {
                            [weakSelf.otherLocations addObject:location];
                        }
                    }
                }
                completion(YES);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(NO);
            });
        }
    }];

    if (self.enableGroundTransportLocations) {
        [GooglePlaceService searchWithPartialString:partialText completion:^(BOOL success, NSArray *results) {
            if (results) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (CTMatchedLocation *location in results) {
                        if (location.isAtAirport) {
                            //[weakSelf.airportLocations addObject:location];
                        } else {
                            [weakSelf.otherLocations addObject:location];
                        }
                    }
                    completion(YES);
                });
            }
        }];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.airportLocations.count;
    } else if (section == 1) {
        return self.otherLocations.count;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (indexPath.section == 0) {
        //cell.imageView.image = [UIImage imageNamed:@""];
        if(self.airportLocations[indexPath.row] != (id)[NSNull null]) {
            [cell setLabelText:self.airportLocations[indexPath.row].name isAirport:YES];
        }
    } else {
        //cell.imageView.image = [UIImage imageNamed:@""];
        if(self.otherLocations[indexPath.row] != (id)[NSNull null]) {
            [cell setLabelText:self.otherLocations[indexPath.row].name isAirport:NO];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        self.selectedLocation(self.airportLocations[indexPath.row]);
    } else if (indexPath.section == 1) {
        self.selectedLocation(self.otherLocations[indexPath.row]);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.airportLocations.count > 0) {
            return 30;
        } else {
            return 0;
        }
    } else {
        if (self.otherLocations.count > 0) {
            return 30;
        } else {
            return 0;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CTLabel *customLabel = [[CTLabel alloc] initWithFrame:CGRectMake(10.0,5.0,200.0,20.0)];
    customLabel.textColor = [UIColor darkGrayColor];

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 20)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    headerView.alpha = 0.9;
    [headerView addSubview:customLabel];

    if (section == 0) {
        [customLabel setText:NSLocalizedString(@"Airport", @"")];
        if (self.airportLocations.count > 0) {
            return headerView;
        } else {
            return nil;
        }
    } else {
        [customLabel setText:NSLocalizedString(@"All other locations", @"")];
        if (self.otherLocations.count > 0) {
            return headerView;
        } else {
            return nil;
        }
    }
}

@end


