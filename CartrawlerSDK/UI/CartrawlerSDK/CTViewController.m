//
//  CTViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTViewController.h"
#import "SearchDetailsViewController.h"
#import "CTInPathPayment.h"
#import "CTDataStore.h"

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

- (void)popToSearchViewController
{
    for (CTViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[SearchDetailsViewController class]]) {
            [self.navigationController popToViewController:vc animated:NO];
            [(SearchDetailsViewController *)vc performSearch];
        }
    }
}

- (void)produceInPathPayload
{
    CTRentalBooking *booking = [[CTRentalBooking alloc] initFromSearch:self.search];
    [CTDataStore cachePotentialInPathBooking:booking];
    
    if (self.delegate) {
        [self.delegate didProduceInPathRequest:[CTInPathPayment createInPathRequest:self.search]
                                       vehicle:[[CTInPathVehicle alloc]
                                          init:self.search]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }
}

- (void)pushToDestination
{
    __weak typeof (self) weakSelf = self;
    
    if (!self.search) {
        [self.validationController validateGroundTransport:self.groundSearch
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
                                                            if (weakSelf.dataValidationCompletion) {
                                                                weakSelf.dataValidationCompletion(NO, errorMessage);
                                                            }
                                                        }
                                                    });
                                                }];
    } else {
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
}

@end
