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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CTSearch *)search
{
    return [CTSearch instance];
}

//- (ViewType)viewType
//{
//    if (!_viewType) {
//        [NSException raise:@"CTViewController: ViewType not set" format:@"All CTViewController's must have ViewType set"];
//        return ViewTypeGeneric;
//    } else {
//        return _viewType;
//    }
//}

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
