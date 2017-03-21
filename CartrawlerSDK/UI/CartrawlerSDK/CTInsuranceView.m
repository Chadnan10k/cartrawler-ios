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
@property (nonatomic, strong) CTInsurance *cachedInsurance;

@end

@implementation CTInsuranceView

- (instancetype)init
{
    self = [super init];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self(0@250)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"self" : self}]];
    return self;
}

- (void)retrieveInsurance:(CartrawlerAPI *)api search:(CTRentalSearch *)search
{
    
    if (self.offeringView) {
        [self.offeringView removeFromSuperview];
    }
    
    if (self.addedView) {
        [self.addedView removeFromSuperview];
    }
    
    __weak typeof (self) weakSelf = self;
    if (search.selectedVehicle.vehicle.insuranceAvailable) {
        [api requestInsuranceQuoteForVehicle:[CTSDKSettings instance].homeCountryCode
                                    currency:[CTSDKSettings instance].currencyCode
                                   totalCost:search.selectedVehicle.vehicle.totalPriceForThisVehicle.stringValue
                              pickupDateTime:search.pickupDate
                              returnDateTime:search.dropoffDate
                      destinationCountryCode:search.dropoffLocation.countryCode
                             selectedVehicle:search.selectedVehicle
                                  completion:^(CTInsurance *response, CTErrorResponse *error) {
                                      if (response) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              weakSelf.cachedInsurance = response;
                                              [weakSelf setupViews:response];
                                          });
                                      }
                                  }];
    }
}

- (void)setupViews:(CTInsurance *)insurance;
{
    if (!self.offeringView) {
        _offeringView = [CTInsuranceOfferingView new];
    }
    
    if (!self.addedView) {
        _addedView = [CTInsuranceAddedView new];
    }
    
    [self.offeringView updateInsurance:insurance];
    
    __weak typeof (self) weakSelf = self;
    
    self.offeringView.addAction = ^{
        [weakSelf.offeringView removeFromSuperview];
        [weakSelf renderAdded];
    };
    
    self.offeringView.termsAndConditionsAction = ^{
        if (weakSelf.delegate) {
            [weakSelf.delegate didTapTermsAndConditions:weakSelf.cachedInsurance.termsAndConditionsURL];
        }
    };
    
    self.addedView.removeAction = ^{
        [weakSelf.addedView removeFromSuperview];
        [weakSelf renderOffering];
    };
    
    [self renderOffering];

}

- (void)renderOffering
{
    if (self.delegate) {
        [self.delegate didRemoveInsurance];
    }
    
    self.offeringView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.offeringView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.offeringView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.offeringView}]];
}

- (void)renderAdded
{
    
    if (self.delegate) {
        [self.delegate didAddInsurance:self.cachedInsurance];
    }
    
    self.addedView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.addedView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.addedView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.addedView}]];
}

@end
