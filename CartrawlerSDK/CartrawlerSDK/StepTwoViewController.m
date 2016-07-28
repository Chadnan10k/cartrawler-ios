//
//  StepTwoViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepTwoViewController.h"
#import "CTViewManager.h"

@interface StepTwoViewController ()

@end

@implementation StepTwoViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)pushToDestination
{
    if (![CTViewManager canTransitionToStep:self.destinationViewController search:self.search])
    {
        return;
    }

    [self.navigationController pushViewController:self.destinationViewController animated:YES];
}

- (void)refresh
{
    
}

@end
