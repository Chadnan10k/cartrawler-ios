//
//  CTViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTViewController.h"
#import "CTViewManager.h"

@interface CTViewController ()

@end

@implementation CTViewController

- (CTSearch *)search
{
    return [CTSearch instance];
}

- (void)refresh { }

- (void)pushToDestination
{
    [CTViewManager canTransitionToStep:self.destinationViewController
                         cartrawlerAPI:self.cartrawlerAPI
                            completion:^(BOOL success, NSString *errorMessage)
     {
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

@end
