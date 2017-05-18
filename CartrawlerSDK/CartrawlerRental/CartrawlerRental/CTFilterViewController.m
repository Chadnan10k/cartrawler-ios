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
#import <CartrawlerSDK/CTLabel.h>
#import "CTFilterFactory.h"
#import "CTFilterContainer.h"
#import <CartrawlerSDK/CTAppearance.h>
#import "CTRentalConstants.h"
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CTButton.h>
#import <CartrawlerSDK/CTAnalytics.h>

@interface CTFilterViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;

@property (strong, nonatomic) CTFilterTableView *carSizeTableView;
@property (strong, nonatomic) CTFilterTableView *pickupLocationTableView;
@property (strong, nonatomic) CTFilterTableView *vendorsTableView;
@property (strong, nonatomic) CTFilterTableView *fuelPolicyTableView;
@property (strong, nonatomic) CTFilterTableView *transmissionTableView;
@property (strong, nonatomic) CTFilterTableView *carSpecsTableView;

@property (strong, nonatomic) UIViewController *parentViewContoller;

@property (nonatomic, strong) CTFilterFactory *filterFactory;
@property (nonatomic, strong) NSArray <CTFilterContainer *>*viewArray;
@property (weak, nonatomic) IBOutlet CTButton *resetButton;
@property (weak, nonatomic) IBOutlet CTButton *doneButton;

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

    [self setupContainers];
    
    [self.view layoutIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.titleLabel.text = CTLocalizedString(CTRentalTitleFilters);
    
    [self.resetButton setTitle:CTLocalizedString(CTRentalFilterReset) forState:UIControlStateNormal];
    [self.doneButton setTitle:CTLocalizedString(CTRentalCTADone) forState:UIControlStateNormal];
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
    
    self.carSizeTableView.tableViewTitle        = CTLocalizedString(CTRentalFilterCarsize);
    self.pickupLocationTableView.tableViewTitle = CTLocalizedString(CTRentalFilterPickup);
    self.vendorsTableView.tableViewTitle        = CTLocalizedString(CTRentalFilterSupplier);
    self.fuelPolicyTableView.tableViewTitle     = CTLocalizedString(CTRentalFilterCarFuel);
    self.transmissionTableView.tableViewTitle   = CTLocalizedString(CTRentalFilterTransmission);
    
    CTFilterContainer *carSizeContainer = [[CTFilterContainer alloc] initWithFrame:CGRectZero];
    [carSizeContainer setTableView:self.carSizeTableView];
    carSizeContainer.filterSelection = ^(BOOL expanded){
        if (!expanded) {
            [[CTAnalytics instance] tagScreen:@"Car Size" detail:@"open" step:nil];
        }
    };
    CTFilterContainer *pickupContainer = [[CTFilterContainer alloc] initWithFrame:CGRectZero];
    [pickupContainer setTableView:self.pickupLocationTableView];
    pickupContainer.filterSelection = ^(BOOL expanded){
        if (!expanded) {
            [[CTAnalytics instance] tagScreen:@"Pick-up" detail:@"open" step:nil];
        }
    };
    CTFilterContainer *vendorsContainer = [[CTFilterContainer alloc] initWithFrame:CGRectZero];
    [vendorsContainer setTableView:self.vendorsTableView];
    vendorsContainer.filterSelection = ^(BOOL expanded){
        if (!expanded) {
            [[CTAnalytics instance] tagScreen:@"Supplier" detail:@"open" step:nil];
        }
    };
    CTFilterContainer *fuelContainer = [[CTFilterContainer alloc] initWithFrame:CGRectZero];
    [fuelContainer setTableView:self.fuelPolicyTableView];
    fuelContainer.filterSelection = ^(BOOL expanded){
        if (!expanded) {
            [[CTAnalytics instance] tagScreen:@"Fuel Pol" detail:@"open" step:nil];
        }
    };
    CTFilterContainer *transmissionContainer = [[CTFilterContainer alloc] initWithFrame:CGRectZero];
    [transmissionContainer setTableView:self.transmissionTableView];
    transmissionContainer.filterSelection = ^(BOOL expanded){
        if (!expanded) {
            [[CTAnalytics instance] tagScreen:@"Transmiss" detail:@"open" step:nil];
        }
    };

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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:CTRentalResultsStoryboard bundle:bundle];
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
    
    if (self.delegate) {
        [self.delegate filterDidUpdate:self.filterFactory.filteredData];
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
    [[CTAnalytics instance] tagScreen:@"mdl_filter" detail:@"close" step:nil];
    
    NSNumber *proportion = @(self.filterFactory.filteredData.count / self.filterFactory.data.items.count);
    [[CTAnalytics instance] tagScreen:@"filtered" detail:proportion.stringValue step:nil];
    
    [self.filterFactory filter];
    if (self.delegate) {
        [self.delegate filterDidUpdate:self.filterFactory.filteredData];
    }
    
    for (CTFilterContainer *c in self.viewArray) {
        [c close];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
