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
#import <CartrawlerSDK/CTAlertViewController.h>
#import "CTInterstitialViewController.h"
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
    [layoutManager insertView:UIEdgeInsetsMake(70, 0, 0, 0) view:self.searchView];
    [layoutManager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:self.nextButton];
    [layoutManager layoutViews];
    
    __weak typeof(self) weakSelf = self;
    self.dataValidationCompletion = ^(BOOL success, NSString *errorMessage) {
        [CTInterstitialViewController dismiss];
        if (!success && errorMessage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf displayAlertWithMessage:errorMessage];
            });
        }
    };
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
    view.search = self.search;
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
    
    if ([self.searchView validateSearch]) {
        [self pushToDestination];
        [CTInterstitialViewController present:self search:self.search];
    }
    
}

- (void)displayAlertWithMessage:(NSString *)message
{
    CTAlertViewController *viewController = [CTAlertViewController alertControllerWithTitle:@"Sorry! ⚠️" message:message];
    viewController.backgroundTapDismissalGestureEnabled = YES;
    CTAlertAction *okAction = [CTAlertAction actionWithTitle:@"OK!"
                                                     handler:^(CTAlertAction *action) {
                                                         [viewController dismissViewControllerAnimated:YES completion:nil];
                                                     }];
    [viewController addAction:okAction];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentModalViewController:viewController];
    });
}

//MARK: CTSearchViewDelegate

- (void)didTapPresentViewController:(UIViewController *)viewController
{
    [self presentModalViewController:viewController];
}


@end
