//
//  CTTermsConditionsViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 11/09/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import "CTTermsConditionsViewController.h"
#import "CTTermsConditionsViewModel.h"

@interface CTTermsConditionsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) CTTermsConditionsViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CTTermsConditionsViewController

+ (Class)viewModelClass {
    return CTTermsConditionsViewModel.class;
}

- (void)updateWithViewModel:(CTTermsConditionsViewModel *)viewModel {
    self.viewModel = viewModel;
    self.navigationBar.barTintColor = viewModel.primaryColor;
    self.navigationBar.topItem.title = viewModel.title;
    [self.closeButton setTitle:viewModel.close];
    [self.tableView reloadData];
}

// MARK: Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.termsAndConditions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTTermAndCondition *termAndCondition = self.viewModel.termsAndConditions[indexPath.row];
    UITableViewCell <CTViewControllerProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:@"TermAndCondition"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = termAndCondition.titleText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CTTermAndCondition *termAndCondition = self.viewModel.termsAndConditions[indexPath.row];
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapTermAndCondition payload:termAndCondition];
}

// MARK: Back Button

- (IBAction)closeButtonTapped:(UIBarButtonItem *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapCloseTermsAndConditions payload:nil];
}

// MARK: Shake Gesture

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}


@end
