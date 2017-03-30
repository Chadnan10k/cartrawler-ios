//
//  CTSearchView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 29/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchView.h"
#import "CartrawlerSDK/CTLayoutManager.h"
#import "CTSearchSelectionView.h"

@interface CTSearchView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollViewContentView;

@property (nonatomic, strong) CTSearchSelectionView *pickupLocationSearch;
@property (nonatomic, strong) UIView *dropoffLocationSearch;
@property (nonatomic, strong) UIView *sameLocationSwitchContainer;
@property (nonatomic, strong) UIView *datesContainer;
@property (nonatomic, strong) UIView *timesContainer;
@property (nonatomic, strong) UIView *ageSwitchContainer;

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
    self.translatesAutoresizingMaskIntoConstraints = NO;
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.contentSize = self.bounds.size;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.scrollView];
    
    _scrollViewContentView = [UIView new];
    self.scrollViewContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.scrollViewContentView];
    
    _pickupLocationSearch = [CTSearchSelectionView new];
    self.pickupLocationSearch.translatesAutoresizingMaskIntoConstraints = NO;
    
    _dropoffLocationSearch = [UIView new];
    self.dropoffLocationSearch.backgroundColor = [UIColor redColor];
    self.dropoffLocationSearch.translatesAutoresizingMaskIntoConstraints = NO;
    
    _sameLocationSwitchContainer = [UIView new];
    self.sameLocationSwitchContainer.backgroundColor = [UIColor redColor];
    self.sameLocationSwitchContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    _datesContainer = [UIView new];
    self.datesContainer.backgroundColor = [UIColor redColor];
    self.datesContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    _timesContainer = [UIView new];
    self.timesContainer.backgroundColor = [UIColor redColor];
    self.timesContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    _ageSwitchContainer = [UIView new];
    self.ageSwitchContainer.backgroundColor = [UIColor redColor];
    self.ageSwitchContainer.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewDictionary = @{
                                     @"pickupLocationSearch" : self.pickupLocationSearch,
                                     @"dropoffLocationSearch" : self.dropoffLocationSearch,
                                     @"sameLocationSwitchContainer" : self.sameLocationSwitchContainer,
                                     @"datesContainer" : self.datesContainer,
                                     @"timesContainer" : self.timesContainer,
                                     @"ageSwitchContainer" : self.ageSwitchContainer,
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
    
    [self layout];
}


- (void)layout
{
    
    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:self.scrollViewContentView];
    layoutManager.justify = NO;
    layoutManager.orientation = CTLayoutManagerOrientationTopToBottom;

    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.pickupLocationSearch];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.dropoffLocationSearch];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.sameLocationSwitchContainer];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.datesContainer];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.timesContainer];
    [layoutManager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:self.ageSwitchContainer];

    [layoutManager layoutViews];
    
}

- (void)updateDisplayWithSearch:(NSObject *)search
{
    
}

@end
