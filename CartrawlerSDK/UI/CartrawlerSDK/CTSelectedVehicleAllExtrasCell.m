//
//  CTSelectedVehicleAllExtrasCell.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/09/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleAllExtrasCell.h"
#import "CTSelectedVehicleExtrasCellModel.h"

@interface CTSelectedVehicleAllExtrasCell ()
@property (nonatomic, strong) CTSelectedVehicleExtrasCellModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@property (weak, nonatomic) IBOutlet UILabel *counter;
@property (weak, nonatomic) IBOutlet UIButton *decrementButton;
@property (weak, nonatomic) IBOutlet UIButton *incrementButton;
@end

@implementation CTSelectedVehicleAllExtrasCell

- (void)updateWithViewModel:(CTSelectedVehicleExtrasCellModel *)viewModel {
    self.viewModel = viewModel;
    self.title.text = viewModel.title;
    self.detail.text = viewModel.detail;
    
    self.counter.text = viewModel.quantity;
    self.decrementButton.backgroundColor = viewModel.decrementButtonColor;
    self.incrementButton.backgroundColor = viewModel.incrementButtonColor;
}
    
- (IBAction)decrementButtonTapped:(UIButton *)sender {
    if (self.viewModel.decrementEnabled) {
        [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapDecrementExtra payload:self.viewModel.extra];
    }
}
    
- (IBAction)incrementButtonTapped:(UIButton *)sender {
    if (self.viewModel.incrementEnabled) {
        [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapIncrementExtra payload:self.viewModel.extra];
    }
}
@end
