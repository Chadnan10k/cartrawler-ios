//
//  SearchDetailViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 03/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSearchDetailsViewController.h"
#import <CartrawlerSDK/CTLayoutManager.h>
#import <CartrawlerSDK/CTNextButton.h>

#import "CTSearchView.h"

@interface CTSearchDetailsViewController () <CTSearchViewDelegate>

@property (nonatomic, strong) CTSearchView *searchView;
@property (nonatomic, strong) CTNextButton *nextButton;

@end

@implementation CTSearchDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _nextButton = [self setupNextButton];
    _searchView = [self setupSearchView];
    
    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:self.view];
    [layoutManager insertView:UIEdgeInsetsMake(70, 0, 8, 0) view:self.searchView];
    [layoutManager insertView:UIEdgeInsetsMake(8, 0, 0, 0) view:self.nextButton];
    [layoutManager layoutViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.searchView updateDisplayWithSearch:self.search];
}

- (CTSearchView *)setupSearchView
{
    CTSearchView *view = [CTSearchView new];
    view.delegate = self;
    view.cartrawlerAPI = self.cartrawlerAPI;
    return view;
}

- (CTNextButton *)setupNextButton
{
    CTNextButton *button = [CTNextButton new];
    [button setText:@"Search! 🚗"];
    [button addTarget:self action:@selector(searchTapped) forControlEvents:UIControlEventTouchUpInside];
    [button addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(100)]" options:0 metrics:nil views:@{@"button" : button}]];
    return button;
}

- (void)searchTapped
{
    
    [self.searchView validateSearch];
    
    [self pushToDestination];
}

//MARK: CTSearchViewDelegate

- (void)didTapPresentViewController:(UIViewController *)viewController
{
    [self presentModalViewController:viewController];
}


@end
