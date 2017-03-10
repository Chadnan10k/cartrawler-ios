//
//  CTInsuranceView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 08/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTInsuranceView.h"
#import "CTInsuranceOfferingView.h"
#import "CTInsuranceAddedView.h"
#import <CartrawlerSDK/CTSDKSettings.h>

@interface CTInsuranceView()

@property (nonatomic, strong) CTInsuranceOfferingView *offeringView;
@property (nonatomic, strong) CTInsuranceAddedView *addedView;

@end

@implementation CTInsuranceView

- (instancetype)init
{
    self = [super init];
    
    return self;
}

- (void)retrieveInsurance:(CartrawlerAPI *)api search:(CTRentalSearch *)search
{
    __weak typeof (self) weakSelf = self;
    if (search.selectedVehicle.vehicle.insuranceAvailable) {
        [api requestInsuranceQuoteForVehicle:[CTSDKSettings instance].homeCountryCode
                                    currency:[CTSDKSettings instance].currencyCode
                                   totalCost:search.selectedVehicle.vehicle.totalPriceForThisVehicle
                              pickupDateTime:search.pickupDate
                              returnDateTime:search.dropoffDate
                      destinationCountryCode:search.dropoffLocation.countryCode
                             selectedVehicle:search.selectedVehicle
                                  completion:^(CTInsurance *response, CTErrorResponse *error) {
                                      if (response) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [weakSelf setupViews:response];
                                          });
                                      }
                                  }];
    }
}

- (void)setupViews:(CTInsurance *)insurance;
{
    _offeringView = [[CTInsuranceOfferingView alloc] init:insurance];
    _addedView = [CTInsuranceAddedView new];
    
    __weak typeof (self) weakSelf = self;
    
    self.offeringView.addAction = ^{
        [weakSelf.offeringView removeFromSuperview];
        [weakSelf renderAdded];
    };
    
    self.addedView.removeAction = ^{
        [weakSelf.addedView removeFromSuperview];
        [weakSelf renderOffering];
    };
    
    [self renderOffering];

}

- (void)renderOffering
{
    self.offeringView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.offeringView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.offeringView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.offeringView}]];
}

- (void)renderAdded
{
    self.addedView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.addedView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[view]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.addedView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.addedView}]];
}

@end
