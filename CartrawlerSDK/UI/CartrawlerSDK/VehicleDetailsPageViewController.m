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

@interface VehicleDetailsPageViewController () <UIPageViewControllerDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic) int index;
@property (nonatomic, strong) NSArray<UIViewController *> *viewArray;
@property (nonatomic, strong) VehicleDetailsViewController *vehicleDetails;
@property (nonatomic, strong) CTViewController *supplierDetails;
@property (weak, nonatomic) IBOutlet UICollectionView *selectionCollectionView;
@property (weak, nonatomic) IBOutlet CTView *headerView;
@property (weak, nonatomic) IBOutlet CTSegmentedControl *selectionControl;

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
    
    [self.selectionControl removeAllSegments];
    [self.selectionControl insertSegmentWithTitle:@"Vehicle" atIndex:0 animated:NO];
    [self.selectionControl setSelectedSegmentIndex:0];
    
    if (self.search.selectedVehicle.vendor.rating) {
        [self.selectionControl insertSegmentWithTitle:@"Supplier" atIndex:1 animated:NO];
        _viewArray = @[self.vehicleDetails, self.supplierDetails];
    } else {
        _viewArray = @[self.vehicleDetails];
    }
    
    [self.pageViewController setViewControllers:@[self.vehicleDetails] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    __weak typeof (self) weakSelf = self;
    self.vehicleDetails.tappedContinue = ^(BOOL tapped) {
        [weakSelf pushToDestination];
    };
    
    self.dataValidationCompletion = ^(BOOL insuranceSuccess, NSString *errorMessage) {
        [weakSelf.vehicleDetails stopAnimating];
    };
    
    //[self.selectionCollectionView reloadData];

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
    
//    self.selectionCollectionView.delegate = self;
//    self.selectionCollectionView.dataSource = self;
    
    [self.view bringSubviewToFront:self.headerView];

}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma MARK CollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PageSelectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            [cell setText:@"Vehicle"];
            break;
        case 1:
            [cell setText:@"Supplier"];
            break;
        default:
            break;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [(PageSelectionCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath] animate];
    
    switch (indexPath.row) {
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

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.search.selectedVehicle.vendor.rating) {
        return CGSizeMake(collectionView.frame.size.width/2, collectionView.frame.size.height);
    } else {
        return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
    }
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
