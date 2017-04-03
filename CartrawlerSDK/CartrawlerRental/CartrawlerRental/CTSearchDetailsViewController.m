//
//  SearchDetailViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 03/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSearchDetailsViewController.h"
#import <CartrawlerSDK/CTLayoutManager.h>

#import "CTSearchView.h"

@interface CTSearchDetailsViewController ()

@property (nonatomic, strong) CTSearchView *searchView;

@end

@implementation CTSearchDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _searchView = [[CTSearchView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.searchView];
    [CTLayoutManager pinView:self.searchView toSuperView:self.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.searchView updateDisplayWithSearch:self.search];
}


@end
