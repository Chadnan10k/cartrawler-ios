//
//  CTViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTViewController.h"
#import "CTDataStore.h"
#import "CTAnalytics.h"

@interface CTViewController ()

@end

@implementation CTViewController

- (void)refresh { }

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    for (CALayer* layer in [self.view.layer sublayers])
    {
        [layer removeAllAnimations];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dismiss
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.delegate) {
                [self.delegate didDismissViewController:self.restorationIdentifier];
            }
        }];
    });
}

- (void)pushToDestination
{
    __weak typeof (self) weakSelf = self;
    
    [self.validationController validateCarRental:self.search
                                   cartrawlerAPI:self.cartrawlerAPI
                                      completion:^(BOOL success, NSString *errorMessage, BOOL useOptionalRoute) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              if (success) {
                                                  if (weakSelf.dataValidationCompletion) {
                                                      weakSelf.dataValidationCompletion(YES, nil);
                                                  }
                                                  [weakSelf.destinationViewController refresh];
                                                  
                                                  @try {
                                                      [weakSelf.navigationController pushViewController:weakSelf.destinationViewController animated:YES];
                                                  } @catch (NSException * e) {
                                                      NSLog(@"Exception: %@", e);
                                                  }
                                                  
                                              } else {
                                                      if (weakSelf.fallbackViewController && !useOptionalRoute) {
                                                          if (weakSelf.dataValidationCompletion) {
                                                              weakSelf.dataValidationCompletion(YES, nil);
                                                          }
                                                          [weakSelf.fallbackViewController refresh];
                                                          @try {
                                                              [weakSelf.navigationController pushViewController:weakSelf.fallbackViewController
                                                                                                       animated:YES];
                                                          } @catch (NSException * e) {
                                                              NSLog(@"Exception: %@", e);
                                                          } @finally {

                                                          }
                                                      } else if(useOptionalRoute && weakSelf.optionalRoute) {
                                                          @try {
                                                              [weakSelf.navigationController pushViewController:weakSelf.optionalRoute
                                                                                                       animated:YES];
                                                          } @catch (NSException * e) {
                                                              NSLog(@"Exception: %@", e);
                                                          }
                                                      } else {
                                                          if (weakSelf.dataValidationCompletion) {
                                                              weakSelf.dataValidationCompletion(NO, errorMessage);
                                                          }
                                                      }
                                              }
                                          });
                                      }];
}

- (void)presentModalViewController:(UIViewController *)viewController
{
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)sendEvent:(BOOL)cartrawlerOnly customParams:(NSDictionary *)customParams eventName:(NSString *)eventName eventType:(NSString *)eventType
{
    if (self.analyticsDelegate && [self.analyticsDelegate respondsToSelector:@selector(sendAnalyticsEvent:)] && !cartrawlerOnly) {
        
        CTAnalyticsEvent *event = [CTAnalyticsEvent new];
        event.eventName = eventName;
        event.eventType = eventType;
        event.params = customParams;
        [self.analyticsDelegate sendAnalyticsEvent:event];
    }
}

- (void)trackSale
{
    if (self.analyticsDelegate && [self.analyticsDelegate respondsToSelector:@selector(sendAnalyticsSaleEvent:)]) {
        
        CTAnalyticsEvent *saleEvent = [CTAnalyticsEvent new];
        saleEvent.saleType = @"Standalone";
        saleEvent.orderID = self.search.booking.confID;
        saleEvent.quantity = @1;
        saleEvent.metricItem = self.search.pickupLocation.name;
        
        if (self.search.isBuyingInsurance) {
            saleEvent.value = @(self.search.selectedVehicle.vehicle.totalPriceForThisVehicle.doubleValue +
            self.search.insurance.premiumAmount.doubleValue);
        } else {
            saleEvent.value = self.search.selectedVehicle.vehicle.totalPriceForThisVehicle;
        }

        [self.analyticsDelegate sendAnalyticsSaleEvent:saleEvent];
    }
}

@end
