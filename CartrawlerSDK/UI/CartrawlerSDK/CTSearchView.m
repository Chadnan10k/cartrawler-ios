//
//  CTSearchView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 29/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchView.h"
#import "CartrawlerSDK/CTLayoutManager.h"
#import "CTSelectionView.h"
#import "CTLocationSearchViewController.h"

@interface CTSearchView() <CTSelectionViewDelegate>

@property (nonatomic, strong) CTLayoutManager *layoutManager;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollViewContentView;

@property (nonatomic, strong) CTSelectionView *pickupLocationSearch;
@property (nonatomic, strong) CTSelectionView *dropoffLocationSearch;
@property (nonatomic, strong) UIView *sameLocationSwitchContainer;
@property (nonatomic, strong) CTSelectionView *datesContainer;
@property (nonatomic, strong) UIView *timesContainer;
@property (nonatomic, strong) UIView *ageSwitchContainer;
@property (nonatomic, strong) CTSelectionView *ageContainer;
@property (nonatomic, strong) CTSelectionView *pickupTimeContainer;
@property (nonatomic, strong) CTSelectionView *dropoffTimeContainer;

@property (nonatomic, strong) UISwitch *ageSwitch;
@property (nonatomic, strong) UISwitch *locationSwitch;

@end

@implementation CTSearchView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)init
{
    self = [super init];
    
    if (!self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setup];
    
    return self;
}

- (void)setup
{
    _locationSwitch = [UISwitch new];
    _ageSwitch = [UISwitch new];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.contentSize = self.bounds.size;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.scrollView];
    
    _scrollViewContentView = [UIView new];
    self.scrollViewContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.scrollViewContentView];
    
    _pickupLocationSearch = [[CTSelectionView alloc] initWithPlaceholder:@"Pickup Location"];
    self.pickupLocationSearch.useAsButton = YES;
    self.pickupLocationSearch.delegate = self;
    
    _dropoffLocationSearch = [[CTSelectionView alloc] initWithPlaceholder:@"Dropoff Location"];
    self.dropoffLocationSearch.useAsButton = YES;
    self.dropoffLocationSearch.delegate = self;
    
    _sameLocationSwitchContainer = [self generateSwitchView:@"Dropoff to same location"
                                            switchReference:self.locationSwitch];
    self.sameLocationSwitchContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    _datesContainer = [[CTSelectionView alloc] initWithPlaceholder:@"Select your dates"];
    self.datesContainer.useAsButton = YES;
    self.datesContainer.delegate = self;
    
    _timesContainer = [self generateTimeSelectionView];
    self.timesContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    _ageSwitchContainer = [self generateSwitchView:@"Age between 25 and 70"
                                   switchReference:self.ageSwitch];
    self.ageSwitchContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    _ageContainer = [[CTSelectionView alloc] initWithPlaceholder:@"Age"];
    self.ageContainer.useAsButton = NO;
    
    NSDictionary *viewDictionary = @{
                                     @"pickupLocationSearch" : self.pickupLocationSearch,
                                     @"dropoffLocationSearch" : self.dropoffLocationSearch,
                                     @"sameLocationSwitchContainer" : self.sameLocationSwitchContainer,
                                     @"datesContainer" : self.datesContainer,
                                     @"timesContainer" : self.timesContainer,
                                     @"ageSwitchContainer" : self.ageSwitchContainer,
                                     @"ageContainer" : self.ageContainer,
                                     @"scrollView" : self.scrollView,
                                     @"scrollViewContainer" : self.scrollViewContentView
                                     };
    
    //Scrollview
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[scrollView]-0-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|" options:0 metrics:nil views:viewDictionary]];
    
    [self.scrollViewContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[scrollViewContainer(1@100)]" options:0 metrics:nil views:viewDictionary]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scrollViewContainer]-0-|" options:0 metrics:nil views:viewDictionary]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollViewContainer]-0-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollViewContentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    
    [self.pickupLocationSearch addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pickupLocationSearch(60)]" options:0 metrics:nil views:viewDictionary]];
    [self.dropoffLocationSearch addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[dropoffLocationSearch(60)]" options:0 metrics:nil views:viewDictionary]];
    [self.sameLocationSwitchContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[sameLocationSwitchContainer(60)]" options:0 metrics:nil views:viewDictionary]];
    [self.datesContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[datesContainer(60)]" options:0 metrics:nil views:viewDictionary]];
    [self.timesContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[timesContainer(60)]" options:0 metrics:nil views:viewDictionary]];
    [self.ageSwitchContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[ageSwitchContainer(60)]" options:0 metrics:nil views:viewDictionary]];
    [self.ageContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[ageContainer(60)]" options:0 metrics:nil views:viewDictionary]];
    
    [self layout];
}

- (UIView *)generateSwitchView:(NSString *)text switchReference:(UISwitch *)switchReference
{
    switchReference.on = YES;
    [switchReference addTarget:self action:@selector(ageSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    switchReference.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.text = text;
    detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewDict = @{@"label" : detailLabel,
                               @"switch" : switchReference};
    
    [container addSubview:detailLabel];
    [container addSubview:switchReference];
    
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[label]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    
    [container addConstraint:[NSLayoutConstraint constraintWithItem:switchReference
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:0
                                                             toItem:container
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
    
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-(>=8)-[switch]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    return container;
}

- (UIView *)generateTimeSelectionView
{
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    _pickupTimeContainer = [[CTSelectionView alloc] initWithPlaceholder:@"Pickup Time"];
    self.pickupTimeContainer.delegate = self;
    self.pickupTimeContainer.useAsButton = YES;
    _dropoffTimeContainer = [[CTSelectionView alloc] initWithPlaceholder:@"Dropoff Time"];
    self.dropoffTimeContainer.delegate = self;
    self.dropoffTimeContainer.useAsButton = YES;
    
    CTLayoutManager *manager = [CTLayoutManager layoutManagerWithContainer:container];
    manager.justify = YES;
    manager.orientation = CTLayoutManagerOrientationLeftToRight;
    [manager insertView:UIEdgeInsetsMake(0, 0, 0, 8) view:self.pickupTimeContainer];
    [manager insertView:UIEdgeInsetsMake(0, 8, 0, 0) view:self.dropoffTimeContainer];
    [manager layoutViews];
    
    return container;
}

- (void)layout
{
    _layoutManager = [CTLayoutManager layoutManagerWithContainer:self.scrollViewContentView];
    self.layoutManager.justify = NO;
    self.layoutManager.orientation = CTLayoutManagerOrientationTopToBottom;

    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.pickupLocationSearch];
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.sameLocationSwitchContainer];
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.datesContainer];
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.timesContainer];
    [self.layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.ageSwitchContainer];

    [self.layoutManager layoutViews];
}

- (void)presentLocationSelection:(BOOL)isPickupView
{
    CTLocationSearchViewController *locationViewController = [[CTLocationSearchViewController alloc] init];
}

- (void)updateDisplayWithSearch:(NSObject *)search
{
    
}

//MARK: Age Switch
- (void)ageSwitchChanged:(UISwitch *)sender
{
    if (sender == self.ageSwitch) {
        if (sender.isOn) {
            NSUInteger idx = [self.layoutManager indexOfObject:self.ageContainer];
            [self.layoutManager removeAtIndex:idx];
        } else {
            NSUInteger idx = [self.layoutManager indexOfObject:self.ageSwitchContainer];
            [self.layoutManager insertViewAtIndex:idx padding:UIEdgeInsetsMake(8, 8, 8, 8) view:self.ageContainer];
        }
    }
    
    if (sender == self.locationSwitch) {
        if (sender.isOn) {
            [self.layoutManager removeAtIndex:1];
        } else {
            [self.layoutManager insertViewAtIndex:1 padding:UIEdgeInsetsMake(8, 8, 8, 8) view:self.dropoffLocationSearch];
        }
    }
    
}

//MARK: Selection view delegate
- (void)didTapSelectionView:(CTSelectionView *)selectionView
{
    if (selectionView == self.pickupLocationSearch) {
        [self presentLocationSelection:YES];
    }
    
    if (selectionView == self.dropoffLocationSearch) {
        [self presentLocationSelection:NO];
    }
}

@end
