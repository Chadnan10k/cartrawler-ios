//
//  StepFiveViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 11/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepFiveViewController.h"
#import "CTViewManager.h"

@interface StepFiveViewController ()

@end

@implementation StepFiveViewController

- (void)pushToDestination
{
    if (![CTViewManager canTransitionToStep:self.destinationViewController search:self.search]) {
        return;
    }
    
    [self.navigationController pushViewController:self.destinationViewController animated:YES];
}

@end
