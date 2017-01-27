//
//  CTVehicleDetailsPageViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 22/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleDetailsPageViewController.h"
#import "CTVehicleDetailsViewController.h"
#import "CTPageSelectionCollectionViewCell.h"
#import <CartrawlerSDK/CTView.h>
#import <CartrawlerSDK/CTSegmentedControl.h>
#import <CartrawlerSDK/CTButton.h>
#import <CartrawlerSDK/CTNextButton.h>
#import "CTOptionalExtrasViewController.h"
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTVehicleDetailsPageViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic) int index;
@property (nonatomic, strong) NSArray<UIViewController *> *viewArray;
@property (nonatomic, strong) CTVehicleDetailsViewController *vehicleDetails;
@property (nonatomic, strong) CTViewController *supplierDetails;
@property (weak, nonatomic) IBOutlet UICollectionView *selectionCollectionView;
@property (weak, nonatomic) IBOutlet CTView *headerView;
@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;
@property (weak, nonatomic) IBOutlet CTSegmentedControl *selectionControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet CTNextButton *continueButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navBarHeight;

@end

@implementation CTVehicleDetailsPageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CTAnalytics instance] tagScreen:@"Step" detail:@"vehicles-v" step:@3];

    _index = 0;
    
    if (self.search.selectedVehicle.vendor.rating) {
        self.navBarHeight.constant = 100;
        self.selectionControl.hidden = NO;
    } else {
        self.navBarHeight.constant = 60;
        self.selectionControl.hidden = YES;
    }
    
    self.continueButton.userInteractionEnabled = YES;
    
    self.vehicleDetails.search = self.search;
    self.vehicleDetails.cartrawlerAPI = self.cartrawlerAPI;
    
    self.supplierDetails.search = self.search;
    self.supplierDetails.cartrawlerAPI = self.cartrawlerAPI;
    
    [self.selectionControl removeAllSegments];
    [self.selectionControl insertSegmentWithTitle:CTLocalizedString(CTRentalTitleDetailsVehicle) atIndex:0 animated:NO];
    [self.selectionControl setSelectedSegmentIndex:0];
    [self.selectionControl insertSegmentWithTitle:CTLocalizedString(CTRentalTitleDetailsSupplier) atIndex:1 animated:NO];
    _viewArray = @[self.vehicleDetails, self.supplierDetails];

    [self.pageViewController setViewControllers:@[self.vehicleDetails]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];

    __weak typeof (self) weakSelf = self;
    self.dataValidationCompletion = ^(BOOL insuranceSuccess, NSString *errorMessage) {
        [weakSelf stopAnimating];
    };
    [self stopAnimating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.continueButton setText:CTLocalizedString(CTRentalCTAContinue)];
    
    _vehicleDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"VehicleDetails"];
    _supplierDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"SupplierDetails"];

    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    self.titleLabel.text = CTLocalizedString(CTRentalTitleDetails);
    
    [self.view bringSubviewToFront:self.headerView];
    [self.view bringSubviewToFront:self.continueButton];
    [self.view bringSubviewToFront:self.activityView];

    for (UIScrollView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.scrollEnabled = NO;
        }
    }
}

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)continueTapped:(id)sender
{
    [self.activityView startAnimating];
    self.continueButton.userInteractionEnabled = NO;
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
