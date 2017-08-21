//
//  CTSearchSplashViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchSplashViewController.h"
#import "CTAppController.h"
#import "CTSearchSplashViewModel.h"
#import "CTSplashCarView.h"
#import "CTSearchReservationsCell.h"

@interface CTSearchSplashViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CTSearchSplashViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *nextTrip;
@property (weak, nonatomic) IBOutlet UILabel *bookAnotherCar;
@property (weak, nonatomic) IBOutlet CTSplashCarView *splashCarView;
@property (weak, nonatomic) IBOutlet UILabel *splashLabel;
@property (weak, nonatomic) IBOutlet UILabel *searchBoxLabel;
@property (weak, nonatomic) IBOutlet UIImageView *searchIcon;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@end

@implementation CTSearchSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchIcon setImage:[self.searchIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [self updateWithViewModel:self.viewModel];
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)updateWithViewModel:(CTSearchSplashViewModel *)viewModel {
    self.viewModel = viewModel;
    self.containerView.backgroundColor = viewModel.splashColor;
    self.splashCarView.backgroundColor = viewModel.splashColor;
    self.splashCarView.primaryColor = viewModel.illustrationColor;
    self.splashLabel.text = viewModel.splashText;
    self.searchBoxLabel.text = viewModel.searchBoxText;
    [self.tableView reloadData];
    // TODO: Remove magic number
    if (viewModel.rowViewModels.count > 0) {
        self.splashCarView.hidden = YES;
        self.tableViewHeight.constant = viewModel.rowViewModels.count * 185;
        [self.view layoutIfNeeded];
        self.splashLabel.hidden = YES;
        self.nextTrip.hidden = NO;
        self.bookAnotherCar.hidden = NO;
    } else {
        self.splashCarView.hidden = NO;
        self.tableViewHeight.constant = 0;
        self.splashLabel.hidden = NO;
        self.nextTrip.hidden = YES;
        self.bookAnotherCar.hidden = YES;
    }
}

- (IBAction)didTapEnterLocation:(id)sender {
    [CTAppController dispatchAction:CTActionSearchUserDidTapPickupTextField payload:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.rowViewModels.count;
}

- (CTSearchReservationsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTSearchReservationsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchReservationsCell"];
    
    cell.backgroundColor = [UIColor clearColor];
    [cell updateWithViewModel:self.viewModel.rowViewModels[indexPath.row]];
    
    return cell;
}

@end
