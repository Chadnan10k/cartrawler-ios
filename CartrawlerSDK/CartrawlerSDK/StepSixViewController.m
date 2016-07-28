//
//  StepSixViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "StepSixViewController.h"
#import "CTImageCache.h"

@interface StepSixViewController () <UIAlertViewDelegate>

@end
//driver details base
@implementation StepSixViewController

- (void)pushToDestination
{

    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"End of CTSDK demo"
                                                        message:@"🚗"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[CTImageCache sharedInstance] removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
