//
//  CTVehiclePresenterViewController.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 20/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehiclePresenterViewController.h"
#import "CTVehicleSelectionView.h"
#import "CTVehicleInfoView.h"
#import <CartrawlerSDK/CTLayoutManager.h>
#import "CTSearchDetailsViewController.h"
#import "CTRentalConstants.h"

@interface CTVehiclePresenterViewController () <CTVehicleSelectionViewDelegate, CTVehicleInfoDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet CTLabel *locationLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (nonatomic, strong) CTVehicleSelectionView *vehicleSelectionView;
@property (nonatomic, strong) CTVehicleInfoView *vehicleDetailsView;

@end

@implementation CTVehiclePresenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    
    [self presentVehicleSelection];
}

- (void)setupViews
{
    _vehicleDetailsView = [CTVehicleInfoView new];
    self.vehicleDetailsView.search = self.search;
    self.vehicleDetailsView.cartrawlerAPI = self.cartrawlerAPI;
    self.vehicleDetailsView.delegate = self;
    
    _vehicleSelectionView = [CTVehicleSelectionView new];
    self.vehicleSelectionView.delegate = self;
    
    [self produceHeaderText];
}

- (void)presentVehicleDetails
{
    [self.vehicleSelectionView removeFromSuperview];
    [self.containerView addSubview:self.vehicleDetailsView];
    [CTLayoutManager pinView:self.vehicleDetailsView toSuperView:self.containerView padding:UIEdgeInsetsZero];
    [self.vehicleDetailsView refreshView];
}

- (void)presentVehicleSelection
{
    [self.vehicleDetailsView removeFromSuperview];
    [self.containerView addSubview:self.vehicleSelectionView];
    [CTLayoutManager pinView:self.vehicleSelectionView toSuperView:self.containerView padding:UIEdgeInsetsZero];
    [self.vehicleSelectionView updateSelection:self.search.vehicleAvailability.items pickupDate:self.search.pickupDate dropoffDate:self.search.dropoffDate sortByPrice:YES];
}

- (void)produceHeaderText
{
    if (self.search.pickupLocation == self.search.dropoffLocation) {
        self.locationLabel.text = [NSString stringWithFormat:@"%@", self.search.pickupLocation.name];
    } else {
        self.locationLabel.text = [NSString stringWithFormat:@"%@\n- to -\n%@",
                                    self.search.pickupLocation.name, self.search.dropoffLocation.name];
    }
    
    NSString *pickupDate = [self.search.pickupDate stringFromDateWithFormat:@"dd MMM, hh:mm a"];
    NSString *dropoffDate = [self.search.dropoffDate stringFromDateWithFormat:@"dd MMM, hh:mm a"];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@", pickupDate, dropoffDate];
}

- (IBAction)dismiss:(id)sender
{
    [self dismiss];
}

- (IBAction)search:(id)sender
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTRentalSearchStoryboard bundle:bundle];
    CTSearchDetailsViewController *searchViewController = [storyboard instantiateViewControllerWithIdentifier:CTRentalSearchViewIdentifier];
    searchViewController.cartrawlerAPI = self.cartrawlerAPI;
    searchViewController.search = self.search;
    [self presentViewController:searchViewController animated:YES completion:nil];
}

//MARK: CTVehicleSelectionViewDelegate

- (void)didSelectVehicle:(CTAvailabilityItem *)item
{
    self.search.selectedVehicle = item;
    [self presentVehicleDetails];
}

//MARK: CTVehicleInfoDelegate

- (void)infoViewPresentViewController:(UIViewController *)viewController
{
    [self presentModalViewController:viewController];
}

- (void)infoViewPushToExtraDetail
{
    
}

- (void)infoViewPushViewController:(UIViewController *)viewController
{
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)infoViewRequestNewVehiclePrice:(CTNewVehiclePriceCompeltion)completion
{
    [self requestNewVehiclePrice:completion];
}

- (void)infoViewPresentVehicleSelection
{
    [self presentVehicleSelection];
}

@end
