//
//  ViewController.m
//  TestApp
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ViewController.h"
#import "RYRRentalManager.h"
#import "InPathViewController.h"
#import <CartrawlerSDK/CTHeaders.h>

@interface ViewController () <CTListViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *endpointControl;

@property (nonatomic) BOOL isDebug;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad]; //643826 ryr desktop 642619 ryr mobile
    _isDebug = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.endpointControl.selectedSegmentIndex = [RYRRentalManager instance].currentEndpoint;
    
    
    CTListItemView *header1 = [CTListItemView new];
    header1.titleLabel.text = @"Header 1";
    header1.imageView.image = [UIImage imageNamed:@"calSame"];
    header1.imageAlignment = CTListItemImageAlignmentLeft;
    CTExpandingView *accordion1 = [[CTExpandingView alloc] initWithHeaderView:header1 animationContainerView:self.view];
    
    CTListItemView *header2 = [CTListItemView new];
    header2.titleLabel.text = @"Header 2";
    header2.imageView.image = [UIImage imageNamed:@"calSame"];
    header2.imageAlignment = CTListItemImageAlignmentLeft;
    CTExpandingView *accordion2 = [[CTExpandingView alloc] initWithHeaderView:header2 animationContainerView:self.view];
    
    CTListView *listView = [[CTListView alloc] initWithViews:@[accordion1, accordion2]];
    listView.delegate = self;
    
    [self.view addSubview:listView];
    listView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[listView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(listView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-200-[listView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(listView)]];
}

- (void)listView:(CTListView *)listView didSelectView:(CTExpandingView *)view atIndex:(NSInteger)index {
    if (view.expanded) {
        [view contract];
    } else {
        UILabel *label = [UILabel new];
        label.numberOfLines = 0;
        label.text = @"Hello\nHello\nHello\nHello\nHello\nHello";
        [view expandWithDetailView:label];
    }
}

- (IBAction)openCarRental:(id)sender {
    [[RYRRentalManager instance].rental presentCarRentalInViewController:self];
}

- (IBAction)endpointChanged:(id)sender {
    if (self.endpointControl.selectedSegmentIndex == 0) {
        _isDebug = YES;
    } else {
        _isDebug = NO;
    }
    [[RYRRentalManager instance] changeEndpoint:!self.isDebug];
}



@end
