//
//  CTFilterViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTFilterViewController.h"
#import "CTFilterDataSource.h"
#import "CTFilterTableView.h"
#import "CTLabel.h"
#import "CTFilterFactory.h"
#import "CTFilterContainer.h"
#import "CTAppearance.h"

@interface CTFilterViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) CTFilterTableView *carSizeTableView;
@property (strong, nonatomic) CTFilterTableView *pickupLocationTableView;
@property (strong, nonatomic) CTFilterTableView *vendorsTableView;
@property (strong, nonatomic) CTFilterTableView *fuelPolicyTableView;
@property (strong, nonatomic) CTFilterTableView *transmissionTableView;
@property (strong, nonatomic) CTFilterTableView *carSpecsTableView;

@property (strong, nonatomic) UIViewController *parentViewContoller;

@property (nonatomic, strong) CTFilterFactory *filterFactory;
@property (nonatomic, strong) NSArray <CTFilterContainer *>*viewArray;
@end

@implementation CTFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _carSizeTableView = [[CTFilterTableView alloc] initWithFrame:CGRectZero];
    _pickupLocationTableView = [[CTFilterTableView alloc] initWithFrame:CGRectZero];
    _vendorsTableView = [[CTFilterTableView alloc] initWithFrame:CGRectZero];
    _fuelPolicyTableView = [[CTFilterTableView alloc] initWithFrame:CGRectZero];
    _transmissionTableView = [[CTFilterTableView alloc] initWithFrame:CGRectZero];
    _carSpecsTableView = [[CTFilterTableView alloc] initWithFrame:CGRectZero];
    
    [self.filterFactory setDataSources];
    
    self.carSizeTableView.dataSource    = self.filterFactory.carSizeDataSource;
    self.carSizeTableView.delegate      = self.filterFactory.carSizeDataSource;
    self.pickupLocationTableView.dataSource = self.filterFactory.locationDataSource;
    self.pickupLocationTableView.delegate   = self.filterFactory.locationDataSource;
    self.vendorsTableView.dataSource = self.filterFactory.vendorsDataSource;
    self.vendorsTableView.delegate   = self.filterFactory.vendorsDataSource;
    self.fuelPolicyTableView.dataSource = self.filterFactory.fuelPolicyDataSource;
    self.fuelPolicyTableView.delegate   = self.filterFactory.fuelPolicyDataSource;
    self.transmissionTableView.dataSource = self.filterFactory.transmissionDataSource;
    self.transmissionTableView.delegate   = self.filterFactory.transmissionDataSource;
    
    self.carSizeTableView.tableViewTitle        = NSLocalizedString(@"Vehicle Size", @"Vehicle Size");
    self.pickupLocationTableView.tableViewTitle = NSLocalizedString(@"Pickup", @"Pickup");
    self.vendorsTableView.tableViewTitle        = NSLocalizedString(@"Vendors", @"Vendors");
    self.fuelPolicyTableView.tableViewTitle     = NSLocalizedString(@"Fuel policy", @"Fuel policy");
    self.transmissionTableView.tableViewTitle   = NSLocalizedString(@"Transmission", @"Transmission");

    [self setupContainers];
    
    [self.view layoutIfNeeded];
    
}

- (void)updateData:(CTVehicleAvailability *)data
{
    if (!self.filterFactory) {
        _filterFactory = [[CTFilterFactory alloc] initWithFilterData:data];
    } else {
        [self reset];
        [self.filterFactory update:data];
    }
    
}

- (void)setupContainers
{
    
    CTFilterContainer *carSizeContainer = [[CTFilterContainer alloc] initWithFrame:CGRectZero];
    [carSizeContainer setTableView:self.carSizeTableView];
    CTFilterContainer *pickupContainer = [[CTFilterContainer alloc] initWithFrame:CGRectZero];
    [pickupContainer setTableView:self.pickupLocationTableView];
    CTFilterContainer *vendorsContainer = [[CTFilterContainer alloc] initWithFrame:CGRectZero];
    [vendorsContainer setTableView:self.vendorsTableView];
    CTFilterContainer *fuelContainer = [[CTFilterContainer alloc] initWithFrame:CGRectZero];
    [fuelContainer setTableView:self.fuelPolicyTableView];
    CTFilterContainer *transmissionContainer = [[CTFilterContainer alloc] initWithFrame:CGRectZero];
    [transmissionContainer setTableView:self.transmissionTableView];

    _viewArray = @[carSizeContainer, pickupContainer, vendorsContainer, fuelContainer, transmissionContainer];
    
    for (int i = 0; i < self.viewArray.count; ++i) {

        self.viewArray[i].translatesAutoresizingMaskIntoConstraints = NO;
        [self.scrollView addSubview:self.viewArray[i]];
        
        if (i == 0) {
            
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.viewArray[i]
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.scrollView
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0
                                                                              constant:8];
            
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.viewArray[i]
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeHeight
                                                                               multiplier:1.0
                                                                                 constant:50];
            
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.viewArray[i]
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:[CTAppearance instance].containerViewMarginPadding];
            
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.viewArray[i]
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:([CTAppearance instance].containerViewMarginPadding * -1)];
            [self.view addConstraints:@[topConstraint,
                                        leftConstraint,
                                        rightConstraint,
                                        heightConstraint]];
            
            [self.viewArray[i] addConstraint:heightConstraint];
            [self.viewArray[i] updateConstraints];
            [self.view updateConstraints];
            
        } else if (i < self.viewArray.count-1) {
            
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.viewArray[i]
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.viewArray[i-1]
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:16];
            
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.viewArray[i]
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeHeight
                                                                               multiplier:1.0
                                                                                 constant:50];
            
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.viewArray[i]
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:[CTAppearance instance].containerViewMarginPadding];
            
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.viewArray[i]
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:([CTAppearance instance].containerViewMarginPadding * -1)];
            [self.view addConstraints:@[topConstraint,
                                        leftConstraint,
                                        rightConstraint,
                                        heightConstraint]];
            
            [self.viewArray[i] addConstraint:heightConstraint];
            [self.viewArray[i] updateConstraints];
            [self.view updateConstraints];
            
        } else {

            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.viewArray[i]
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.viewArray[i-1]
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:16];
            
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.viewArray[i]
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:50];
            
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.viewArray[i]
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:[CTAppearance instance].containerViewMarginPadding];
            
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.viewArray[i]
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:([CTAppearance instance].containerViewMarginPadding * -1)];
            
            NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.viewArray[i]
                                                                                attribute:NSLayoutAttributeBottom
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self.scrollView
                                                                                attribute:NSLayoutAttributeBottom
                                                                               multiplier:1.0
                                                                                 constant:-8];
            [self.view addConstraints:@[topConstraint,
                                        heightConstraint,
                                        leftConstraint,
                                        rightConstraint,
                                        bottomConstraint]];
            
            [self.viewArray[i] addConstraint:heightConstraint];
            [self.viewArray[i] updateConstraints];
            [self.view updateConstraints];
        }
    }
}

+ (CTFilterViewController *)initInViewController:(UIViewController *)viewController withData:(CTVehicleAvailability *)data
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepTwo" bundle:bundle];
    CTFilterViewController *vc = (CTFilterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CTFilterViewController"];
    [vc updateData:data];
    vc.parentViewContoller = viewController;
    return vc;
}

- (void)present
{
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.parentViewContoller presentViewController:self animated:YES completion:nil];
}

- (void)reset
{
    self.filterFactory.filteredData = [[NSMutableArray alloc] init];
    
    [self.filterFactory.carSizeDataSource reset];
    [self.filterFactory.locationDataSource reset];
    [self.filterFactory.vendorsDataSource reset];
    [self.filterFactory.fuelPolicyDataSource reset];
    [self.filterFactory.transmissionDataSource reset];
    [self.filterFactory.vendorsDataSource reset];
    
    [self.carSizeTableView reloadData];
    [self.pickupLocationTableView reloadData];
    [self.vendorsTableView reloadData];
    [self.fuelPolicyTableView reloadData];
    [self.transmissionTableView reloadData];
    [self.carSpecsTableView reloadData];
    
    [self.filterFactory filter];
    
    if (self.filterCompletion) {
        self.filterCompletion(self.filterFactory.filteredData);
    }
    
    for (CTFilterContainer *c in self.viewArray) {
        [c close];
    }
}

- (IBAction)resetTapped:(id)sender
{
    [self reset];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneTapped:(id)sender
{
    [self.filterFactory filter];
    if (self.filterCompletion) {
        self.filterCompletion(self.filterFactory.filteredData);
    }
    
    for (CTFilterContainer *c in self.viewArray) {
        [c close];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
