//
//  CartrawlerAPI.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 13/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerUI.h"
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "SearchDetailsViewController.h"


#define kSearchViewStoryboard @"Main"

@interface CartrawlerUI()

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;
@property (nonatomic, strong) StepOneViewController *stepOneViewController;
@property (nonatomic, strong) StepTwoViewController *stepTwoViewController;

@end

@implementation CartrawlerUI

- (id)initWithRequestorID:(NSString *)requestorID
             languageCode:(NSString *)languageCode
                  isDebug:(BOOL)isDebug
{
    self = [super self];
    
    _cartrawlerAPI = [[CartrawlerAPI alloc]
             initWithClientKey:requestorID
                      language:languageCode
                         debug:isDebug];
    
    return self;
}

- (void)presentSearchViewInViewController:(UIViewController *)viewController;
{
    if (self.stepOneViewController == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:nil];
        _stepOneViewController = [storyboard instantiateViewControllerWithIdentifier:@"SearchDetailsViewController"];
        self.stepOneViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    }
    
    [self.stepOneViewController setStepTwoViewController:[self searchResultsController]];
    [self.stepOneViewController setCartrawlerAPI:self.cartrawlerAPI];
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:self.stepOneViewController];

    [viewController presentViewController:navController animated:YES completion:nil];
}

- (void)presentSearchResultsView
{
    
}

- (void)setCustomSearchView:(StepOneViewController *)viewController;
{
    _stepOneViewController = viewController;
}

- (void)setSearchResultsViewController:(StepTwoViewController *)viewController
{
    _stepTwoViewController = viewController;
}

- (StepTwoViewController *)searchResultsController
{
    if (self.stepTwoViewController == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:nil];
        return [storyboard instantiateViewControllerWithIdentifier:@"SearchResultsViewController"];
    } else {
        return self.stepTwoViewController;
    }
}



@end
