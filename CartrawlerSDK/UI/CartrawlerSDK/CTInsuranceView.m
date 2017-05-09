//
//  CTInsuranceView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 08/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTInsuranceView.h"
#import "CTInsuranceOfferingView.h"
#import <CartrawlerSDK/CTSDKSettings.h>
#import <CartrawlerSDK/CTAnalytics.h>

@interface CTInsuranceView()

@property (nonatomic, strong) CTInsuranceOfferingView *offeringView;
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

- (void)retrieveInsurance:(CartrawlerAPI *)api search:(CTRentalSearch *)search completion:(CTInsuranceRetrievalCompletion)completion;
{
    
    if (self.offeringView) {
        [self.offeringView removeFromSuperview];
    }
    
    if (search.isBuyingInsurance && search.insurance) {
        _cachedInsurance = search.insurance;
        //set button to added
        return;
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
                                              [weakSelf setupViews:response search:search];
                                              completion(response);
                                          });
                                      }
                                  }];
    }
}

- (void)setupViews:(CTInsurance *)insurance search:(CTRentalSearch *)search
{
    if (!self.offeringView) {
        _offeringView = [CTInsuranceOfferingView new];
    }
     
    [self.offeringView updateInsurance:insurance pickupDate:search.pickupDate dropoffDate:search.dropoffDate];
    
    __weak typeof (self) weakSelf = self;
    
    self.offeringView.addAction = ^{
        if (weakSelf.delegate) {
            [[CTAnalytics instance] tagScreen:@"ins_add3_m" detail:@"add" step:@-1];
            [[CTAnalytics instance] tagScreen:@"ins_click" detail:@"1" step:@-1];
            [weakSelf.delegate didAddInsurance:weakSelf.cachedInsurance];
        }
    };
    
    self.offeringView.removeAction = ^{
        if (weakSelf.delegate) {
            [[CTAnalytics instance] tagScreen:@"ins_add3_m" detail:@"remove" step:@-1];
            [[CTAnalytics instance] tagScreen:@"ins_click" detail:@"0" step:@-1];
            [weakSelf.delegate didRemoveInsurance];
        }
    };
    
    self.offeringView.termsAndConditionsAction = ^{
        if (weakSelf.delegate) {
            [[CTAnalytics instance] tagScreen:@"ins_lnk3" detail:@"click" step:@-1];
            [weakSelf.delegate didTapMoreInsuranceDetail];
        }
    };
    
    [self renderOffering];

}

- (void)presentSelectedState
{
    //show added button
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

@end
