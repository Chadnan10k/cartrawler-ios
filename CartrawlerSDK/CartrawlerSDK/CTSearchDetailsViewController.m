//
//  StepOneViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSearchDetailsViewController.h"
#import "CTSDKSettings.h"
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "CTViewManager.h"

@interface CTSearchDetailsViewController ()

@end

@implementation CTSearchDetailsViewController

- (void)pushToDestination
{
    [CTViewManager canTransitionToVehicleSelection:self.cartrawlerAPI completion:^(BOOL success, NSString *errorMessage) {
        if (success && errorMessage == nil) {
            if (self.searchDetailsCompletion) {
                self.searchDetailsCompletion(YES, nil);
            }
            [self.navigationController pushViewController:self.destinationViewController animated:YES];
            [self.destinationViewController refresh];
        } else {
            if (self.searchDetailsCompletion) {
                self.searchDetailsCompletion(NO, errorMessage);
            }
        }
    }];
}

+ (void)forceLinkerLoad_
{
    
}

@end
