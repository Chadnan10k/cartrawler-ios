//
//  CartrawlerSDK.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//


#import "CartrawlerSDK.h"
#import "LinkerUtils.h"

#define kSearchViewStoryboard @"StepOne"

@interface CartrawlerSDK()

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;
@property (nonatomic, strong) StepOneViewController *stepOneViewController;
//@property (nonatomic, strong) TestViewController *stepOneViewController;

@property (nonatomic, strong) StepTwoViewController *stepTwoViewController;

@end

@implementation CartrawlerSDK

- (id)initWithRequestorID:(NSString *)requestorID
             languageCode:(NSString *)languageCode
                  isDebug:(BOOL)isDebug
{
    self = [super self];
    
    [LinkerUtils loadFiles];
    
    _cartrawlerAPI = [[CartrawlerAPI alloc]
                      initWithClientKey:requestorID
                      language:languageCode
                      debug:isDebug];
    
    return self;
}

- (void)presentSearchViewInViewController:(UIViewController *)viewController;
{
    if (self.stepOneViewController == nil) {
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:bundle];
        
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
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
        NSBundle *b = [NSBundle bundleWithPath:bundlePath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kSearchViewStoryboard bundle:b];
        return [storyboard instantiateViewControllerWithIdentifier:@"SearchResultsViewController"];
    } else {
        return self.stepTwoViewController;
    }
}



@end
