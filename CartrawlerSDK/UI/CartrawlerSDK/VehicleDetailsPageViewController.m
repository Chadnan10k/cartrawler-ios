//
//  VehicleDetailsPageViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 22/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleDetailsPageViewController.h"
#import "VehicleDetailsViewController.h"
#import "PageSelectionCollectionViewCell.h"
#import "CTView.h"
#import "CTSegmentedControl.h"
#import "CTButton.h"

@interface VehicleDetailsPageViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic) int index;
@property (nonatomic, strong) NSArray<UIViewController *> *viewArray;
@property (nonatomic, strong) VehicleDetailsViewController *vehicleDetails;
@property (nonatomic, strong) CTViewController *supplierDetails;
@property (weak, nonatomic) IBOutlet UICollectionView *selectionCollectionView;
@property (weak, nonatomic) IBOutlet CTView *headerView;
@property (weak, nonatomic) IBOutlet CTSegmentedControl *selectionControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet CTButton *continueButton;

@end

@implementation VehicleDetailsPageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _index = 0;
    
    self.continueButton.enabled = YES;
    
    self.vehicleDetails.search = self.search;
    self.vehicleDetails.cartrawlerAPI = self.cartrawlerAPI;
    
    self.supplierDetails.search = self.search;
    self.supplierDetails.cartrawlerAPI = self.cartrawlerAPI;
    
    [self.selectionControl removeAllSegments];
    [self.selectionControl insertSegmentWithTitle:@"Car info" atIndex:0 animated:NO];
    [self.selectionControl setSelectedSegmentIndex:0];
    [self.selectionControl insertSegmentWithTitle:@"Supplier info" atIndex:1 animated:NO];
    _viewArray = @[self.vehicleDetails, self.supplierDetails];

    [self.pageViewController setViewControllers:@[self.vehicleDetails] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    __weak typeof (self) weakSelf = self;

    self.dataValidationCompletion = ^(BOOL insuranceSuccess, NSString *errorMessage) {
        [weakSelf stopAnimating];
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
    
    [self.view bringSubviewToFront:self.headerView];
    [self.view bringSubviewToFront:self.continueButton];
    [self.view bringSubviewToFront:self.activityView];

    for (UIScrollView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.scrollEnabled = NO;
        }
    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)continueTapped:(id)sender {
    
    [self.activityView startAnimating];
    self.continueButton.enabled = NO;
    [self pushToDestination];
}

- (void)stopAnimating
{
    [self.activityView stopAnimating];
}

#pragma MARK PageViewController

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (viewController != [self viewControllerAtIndex:self.index forward:NO]) {
        return nil;
    }
    
    if (self.index > 0) {
        self.index--;
        return [self viewControllerAtIndex:self.index forward:NO];
    } else {
        return nil;
    }

}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (viewController != [self viewControllerAtIndex:self.index forward:YES]) {
        return nil;
    }
    
    if (self.index < self.viewArray.count-1) {
        self.index++;
        return [self viewControllerAtIndex:self.index forward:YES];
    } else {
        return nil;
    }
}

- (UIViewController *)viewControllerAtIndex:(int)index forward:(BOOL)forward
{
    [self.selectionControl setSelectedSegmentIndex:(forward ? 1:0)];
    return self.viewArray[index];
}

#pragma MARK CTSegmentedControl

- (IBAction)selection:(id)sender {
    
    CTSegmentedControl *control = sender;
    
    switch (control.selectedSegmentIndex) {
        case 0:
            [self.pageViewController setViewControllers:@[self.vehicleDetails] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
            break;
        case 1:
            [self.pageViewController setViewControllers:@[self.supplierDetails] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
            break;
        default:
            break;
    }
    
}


@end
