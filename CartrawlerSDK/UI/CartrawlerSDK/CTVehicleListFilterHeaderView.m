//
//  CTVehicleListFilterHeaderView.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListFilterHeaderView.h"
#import "CTVehicleListFilterHeaderViewModel.h"
#import "CTAppController.h"

@interface CTVehicleListFilterHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *selectAll;
@property (weak, nonatomic) IBOutlet UIButton *selectAllButton;
@property (nonatomic, strong) CTVehicleListFilterHeaderViewModel *viewModel;
@end

@implementation CTVehicleListFilterHeaderView

- (void)updateWithViewModel:(CTVehicleListFilterHeaderViewModel *)viewModel {
    self.title.text = viewModel.title;
    self.selectAll.text = viewModel.detail;
    self.selectAll.textColor = viewModel.primaryColor;
    [self.selectAllButton setTitle:viewModel.detail forState:UIControlStateNormal];
    [self.selectAllButton setTitleColor:viewModel.primaryColor forState:UIControlStateNormal];
    self.viewModel = viewModel;
}
- (IBAction)selectAllTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionVehicleListUserDidTapFilterSelectAll payload:self.viewModel.filterModels];
}

@end
