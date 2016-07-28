//
//  StepFourViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepFourViewController.h"
#import "CTViewManager.h"

@interface StepFourViewController ()

@end

@implementation StepFourViewController

- (void)pushToDestination
{
    
    if (![CTViewManager canTransitionToStep:self.destinationViewController search:self.search]) {
        return;
    }
    
    [self.navigationController pushViewController:self.destinationViewController animated:YES];
}

@end
