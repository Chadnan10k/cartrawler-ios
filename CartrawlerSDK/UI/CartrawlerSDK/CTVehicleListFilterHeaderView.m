//
//  CTVehicleListFilterHeaderView.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListFilterHeaderView.h"
#import "CTVehicleListFilterHeaderViewModel.h"

@interface CTVehicleListFilterHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *selectAll;
@end

@implementation CTVehicleListFilterHeaderView

- (void)updateWithViewModel:(CTVehicleListFilterHeaderViewModel *)viewModel {
    self.title.text = viewModel.title;
    self.selectAll.text = viewModel.detail;
}

@end
