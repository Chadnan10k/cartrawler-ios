//
//  VehicleDetailsPageViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 22/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleDetailsPageViewController.h"
#import "VehicleDetailsViewController.h"
@interface VehicleDetailsPageViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic) int index;

@property (nonatomic, strong) NSArray<UIViewController *> *viewArray;
@property (nonatomic, strong) VehicleDetailsViewController *vehicleDetails;
@property (nonatomic, strong) CTViewController *supplierDetails;

@end

@implementation VehicleDetailsPageViewController

+ (void)forceLinkerLoad_ {}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _index = 0;
    
    self.vehicleDetails.search = self.search;
    self.vehicleDetails.cartrawlerAPI = self.cartrawlerAPI;
    
    self.supplierDetails.search = self.search;
    self.supplierDetails.cartrawlerAPI = self.cartrawlerAPI;
    
    _viewArray = @[self.vehicleDetails, self.supplierDetails];
    
    [self.pageViewController setViewControllers:@[self.vehicleDetails] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    __weak typeof (self) weakSelf = self;
    self.vehicleDetails.tappedContinue = ^(BOOL tapped) {
        [weakSelf pushToDestination];
    };
    
    self.dataValidationCompletion = ^(BOOL insuranceSuccess, NSString *errorMessage) {
        [weakSelf.vehicleDetails stopAnimating];
    };

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vehicleDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"VehicleDetails"];
    _supplierDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"SupplierDetails"];

    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (viewController != [self viewControllerAtIndex:self.index]) {
        return nil;
    }
    
    if (self.index > 0) {
        self.index--;
        return [self viewControllerAtIndex:self.index];
    } else {
        return nil;
    }

}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (viewController != [self viewControllerAtIndex:self.index]) {
        return nil;
    }
    
    if (self.index < 1) {
        self.index++;
        return [self viewControllerAtIndex:self.index];
    } else {
        return nil;
    }
}

- (UIViewController *)viewControllerAtIndex:(int)index
{
    return self.viewArray[index];
}

@end
