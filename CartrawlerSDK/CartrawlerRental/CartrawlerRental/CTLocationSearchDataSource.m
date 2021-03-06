//
//  CTLocationSearchDataSource.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 08/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTLocationSearchDataSource.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTSDKSettings.h>
#import "CTLocationSearchTableViewCell.h"
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTAnalytics.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTLocationSearchDataSource()
@property (nonatomic, strong) NSMutableArray <CTMatchedLocation *> *airportLocations;
@property (nonatomic, strong) NSMutableArray <CTMatchedLocation *> *otherLocations;

@end

@implementation CTLocationSearchDataSource

- (id)init
{
    self = [super init];
    _airportLocations = [[NSMutableArray alloc] init];
    _otherLocations = [[NSMutableArray alloc] init];
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
            
            if (error) {
                [[CTAnalytics instance] tagError:@"step1" event:@"CT_VehLocSearchRQ fail" message:error.errorMessage];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(NO);
            });
        }
    }];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.invertData ? self.otherLocations.count : self.airportLocations.count;
    } else if (section == 1) {
        return self.invertData ? self.airportLocations.count : self.otherLocations.count;
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
    CTLocationSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (indexPath.section == (self.invertData ? 1 : 0)) {
        if(self.airportLocations[indexPath.row] != (id)[NSNull null]) {
            [cell setLabelText:self.airportLocations[indexPath.row].name isAirport:YES];
        }
    } else {
        if(self.otherLocations[indexPath.row] != (id)[NSNull null]) {
            [cell setLabelText:self.otherLocations[indexPath.row].name isAirport:NO];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == (self.invertData ? 1 : 0)) {
        self.selectedLocation(self.airportLocations[indexPath.row]);
    } else if (indexPath.section == (self.invertData ? 0 : 1)) {
        self.selectedLocation(self.otherLocations[indexPath.row]);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == (self.invertData ? 1 : 0)) {
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [CTAppearance instance].viewBackgroundColor;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:17];
    label.textAlignment = NSTextAlignmentLeft;

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 45)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    headerView.alpha = 0.9;
    [headerView addSubview:label];
    
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[label]-padding-|" options:0 metrics:@{@"padding" : [NSNumber numberWithFloat:[CTAppearance instance].containerViewMarginPadding]} views:@{@"label" : label}]];
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:nil views:@{@"label" : label}]];

    if (section == (self.invertData ? 1 : 0)) {
        [label setText:CTLocalizedString(CTRentalSearchLocationsAirport)];
        if (self.airportLocations.count > 0) {
            return headerView;
        } else {
            return nil;
        }
    } else {
        [label setText:CTLocalizedString(CTRentalSearchLocationsOther)];
        if (self.otherLocations.count > 0) {
            return headerView;
        } else {
            return nil;
        }
    }
}

@end


