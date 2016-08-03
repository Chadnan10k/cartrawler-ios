//
//  CTFilterViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTFilterViewController.h"
#import "CTFilterDataSource.h"
#import <CartrawlerAPI/CTFilter.h>
#import "CTFilterTableView.h"
#import "CTLabel.h"
#import "CTFilterFactory.h"

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

@end

@implementation CTFilterViewController

+ (void)forceLinkerLoad_
{
    
}

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

    [self buildTableViews];
    
}

- (void)setFilterData:(CTVehicleAvailability *)data
{
    _filterFactory = [[CTFilterFactory alloc] initWithFilterData:data];
}

 - (void)buildTableViews
{
    
    NSArray <CTFilterTableView *>*viewArray = @[self.carSizeTableView,
                                         self.pickupLocationTableView,
                                         self.vendorsTableView,
                                         self.fuelPolicyTableView,
                                         self.transmissionTableView];
    
    for (int i = 0; i < viewArray.count; ++i) {
        viewArray[i].translatesAutoresizingMaskIntoConstraints = NO;
        [self.scrollView addSubview:viewArray[i]];
        
        [viewArray[i] reloadData];

        CGFloat height = viewArray[i].contentSize.height-1;
        
        if (i == 0) {
            
            CTLabel *titleLabel = [[CTLabel alloc] initWithFrame:CGRectZero];
            titleLabel.useBoldFont = YES;
            [self.scrollView addSubview:titleLabel];
            titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
            titleLabel.text = viewArray[i].tableViewTitle;
            
            NSLayoutConstraint *labelTopConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.scrollView
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0
                                                                              constant:8];
            
            NSLayoutConstraint *labelHeightConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:20];
            
            
            NSLayoutConstraint *labelLeftConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:5];
            
            NSLayoutConstraint *labelRightConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:-5];
            
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:titleLabel
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:8];
            
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:height];
            
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:5];
            
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:-5];
            [self.view addConstraints:@[labelTopConstraint,
                                        labelHeightConstraint,
                                        labelLeftConstraint,
                                        labelRightConstraint,
                                        topConstraint,
                                        leftConstraint,
                                        rightConstraint,
                                        heightConstraint]];
            
            [self.view updateConstraints];
            
        } else if (i < viewArray.count-1) {
            
            CTLabel *titleLabel = [[CTLabel alloc] initWithFrame:CGRectZero];
            titleLabel.useBoldFont = YES;
            [self.scrollView addSubview:titleLabel];
            titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
            titleLabel.text = viewArray[i].tableViewTitle;
            
            NSLayoutConstraint *labelTopConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                                  attribute:NSLayoutAttributeTop
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:viewArray[i-1]
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                 multiplier:1.0
                                                                                   constant:8];
            
            NSLayoutConstraint *labelHeightConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                                     attribute:NSLayoutAttributeHeight
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:nil
                                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                                    multiplier:1.0
                                                                                      constant:20];
            
            
            NSLayoutConstraint *labelLeftConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                                   attribute:NSLayoutAttributeLeft
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.view
                                                                                   attribute:NSLayoutAttributeLeft
                                                                                  multiplier:1.0
                                                                                    constant:5];
            
            NSLayoutConstraint *labelRightConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                                    attribute:NSLayoutAttributeRight
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.view
                                                                                    attribute:NSLayoutAttributeRight
                                                                                   multiplier:1.0
                                                                                     constant:-5];
            
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:titleLabel
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:5];
            
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:height];
            
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:5];
            
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:-5];
            [self.view addConstraints:@[labelTopConstraint,
                                        labelHeightConstraint,
                                        labelLeftConstraint,
                                        labelRightConstraint,
                                        topConstraint,
                                        leftConstraint,
                                        rightConstraint,
                                        heightConstraint]];
            
            [self.view updateConstraints];
             
    } else {
        CTLabel *titleLabel = [[CTLabel alloc] initWithFrame:CGRectZero];
        titleLabel.useBoldFont = YES;
        [self.scrollView addSubview:titleLabel];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        titleLabel.text = viewArray[i].tableViewTitle;
        
        NSLayoutConstraint *labelTopConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:viewArray[i-1]
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0
                                                                               constant:8];
        
        NSLayoutConstraint *labelHeightConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                                 attribute:NSLayoutAttributeHeight
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:nil
                                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                                multiplier:1.0
                                                                                  constant:20];
        
        
        NSLayoutConstraint *labelLeftConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                               attribute:NSLayoutAttributeLeft
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeLeft
                                                                              multiplier:1.0
                                                                                constant:5];
        
        NSLayoutConstraint *labelRightConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                                attribute:NSLayoutAttributeRight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self.view
                                                                                attribute:NSLayoutAttributeRight
                                                                               multiplier:1.0
                                                                                 constant:-5];
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:titleLabel
                                                                         attribute:NSLayoutAttributeBottom
                                                                        multiplier:1.0
                                                                          constant:5];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1.0
                                                                             constant:height];
        
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.view
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0
                                                                           constant:5];
        
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.view
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.0
                                                                            constant:-5];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                           attribute:NSLayoutAttributeBottom
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.scrollView
                                                                           attribute:NSLayoutAttributeBottom
                                                                          multiplier:1.0
                                                                            constant:-8];
        [self.view addConstraints:@[labelTopConstraint,
                                    labelHeightConstraint,
                                    labelLeftConstraint,
                                    labelRightConstraint,
                                    topConstraint,
                                    heightConstraint,
                                    leftConstraint,
                                    rightConstraint,
                                    bottomConstraint]];
        
        [self.view updateConstraints];

    }
    }
    
}

+ (CTFilterViewController *)initInViewController:(UIViewController *)viewController withData:(CTVehicleAvailability *)data;
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepTwo" bundle:bundle];
    CTFilterViewController *vc = (CTFilterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CTFilterViewController"];
    [vc setFilterData:data];
    [vc setParentViewContoller:viewController];
    return vc;
}

- (void)present
{
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self.parentViewContoller presentViewController:self animated:YES completion:nil];
}

- (IBAction)resetTapped:(id)sender {
    
    self.filterFactory.filteredData = [[NSMutableArray alloc] init];
    
    [self.filterFactory.carSizeDataSource reset];
    [self.filterFactory.locationDataSource reset];
    [self.filterFactory.vendorsDataSource reset];
 
    [self.carSizeTableView reloadData];
    [self.pickupLocationTableView reloadData];
    [self.vendorsTableView reloadData];

}

- (IBAction)doneTapped:(id)sender {
    [self.filterFactory filter];
    //[self filter];
    if (self.filterCompletion) {
        self.filterCompletion(self.filterFactory.filteredData);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
