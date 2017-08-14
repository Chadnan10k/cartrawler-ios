//
//  CTVehicleListFilterCellTableViewCell.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListFilterCellTableViewCell.h"
#import "CTVehicleListFilterCellTableViewModel.h"

@interface CTVehicleListFilterCellTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *checkmarkContainer;
@property (weak, nonatomic) IBOutlet UILabel *checkmark;
@property (weak, nonatomic) IBOutlet UIView *filler;
@end

@implementation CTVehicleListFilterCellTableViewCell

- (void)updateWithViewModel:(CTVehicleListFilterCellTableViewModel *)viewModel {
    self.titleLabel.text = viewModel.title;
    self.checkmarkContainer.backgroundColor = viewModel.primaryColor;
    self.checkmark.backgroundColor = viewModel.primaryColor;
    self.checkmark.alpha = viewModel.selected;
    self.filler.alpha = !viewModel.selected;
}

@end
