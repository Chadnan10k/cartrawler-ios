//
//  CTViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTViewController.h"

@interface CTViewController ()

@end

@implementation CTViewController

- (void)refresh { }

- (void)viewDidDisappear:(BOOL)animated {
    for (CALayer* layer in [self.view.layer sublayers])
    {
        [layer removeAllAnimations];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)pushToDestination
{
    if (!self.search) {
    
        [self.validationController validateGroundTransport:self.groundSearch
                                             cartrawlerAPI:self.cartrawlerAPI
                                                completion:^(id success, NSString *errorMessage) {
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        if (success) {
                                                            if (self.dataValidationCompletion) {
                                                                self.dataValidationCompletion(YES, nil);
                                                            }
                                                            [self.navigationController pushViewController:self.destinationViewController animated:YES];
                                                            [self.destinationViewController refresh];
                                                        } else {
                                                            if (self.fallBackViewController) {
                                                                if (self.dataValidationCompletion) {
                                                                    self.dataValidationCompletion(NO, errorMessage);
                                                                }
                                                                [self.navigationController pushViewController:self.fallBackViewController animated:YES];
                                                            } else {
                                                                if (self.dataValidationCompletion) {
                                                                    self.dataValidationCompletion(NO, errorMessage);
                                                                }
                                                            }
                                                        }
                                                    });
                                                }];
        
    } else {
 
        [self.validationController validateCarRental:self.search
                                       cartrawlerAPI:self.cartrawlerAPI
                                          completion:^(id success, NSString *errorMessage) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if (success) {
                                                      if (self.dataValidationCompletion) {
                                                          self.dataValidationCompletion(YES, nil);
                                                      }
                                                      [self.navigationController pushViewController:self.destinationViewController animated:YES];
                                                      [self.destinationViewController refresh];
                                                  } else {
                                                      if (self.fallBackViewController) {
                                                          if (self.dataValidationCompletion) {
                                                              self.dataValidationCompletion(NO, errorMessage);
                                                          }
                                                          [self.navigationController pushViewController:self.fallBackViewController animated:YES];
                                                      } else {
                                                          if (self.dataValidationCompletion) {
                                                              self.dataValidationCompletion(NO, errorMessage);
                                                          }
                                                      }
                                                  }
                                              });
                                          }];
    }
}

@end
