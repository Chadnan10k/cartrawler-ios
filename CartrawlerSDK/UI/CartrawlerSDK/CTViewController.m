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
    
    __weak typeof (self) weakSelf = self;
    
    if (!self.search) {
    
        [self.validationController validateGroundTransport:self.groundSearch
                                             cartrawlerAPI:self.cartrawlerAPI
                                                completion:^(BOOL success, NSString *errorMessage) {
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        if (success) {
                                                            if (weakSelf.dataValidationCompletion) {
                                                                weakSelf.dataValidationCompletion(YES, nil);
                                                            }
                                                            [weakSelf.destinationViewController refresh];
                                                            [weakSelf.navigationController pushViewController:weakSelf.destinationViewController animated:YES];
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
                                          completion:^(BOOL success, NSString *errorMessage) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if (success) {
                                                      if (weakSelf.dataValidationCompletion) {
                                                          weakSelf.dataValidationCompletion(YES, nil);
                                                      }
                                                      [weakSelf.destinationViewController refresh];
                                                      [weakSelf.navigationController pushViewController:weakSelf.destinationViewController animated:YES];
                                                  } else {
                                                      if (weakSelf.dataValidationCompletion) {
                                                          weakSelf.dataValidationCompletion(NO, errorMessage);
                                                      }
                                                  }
                                              });
                                          }];
    }
}

@end
