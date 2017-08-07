//
//  CTSelectedVehicleExtrasCell.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleExtrasCell.h"
#import "CTSelectedVehicleExtrasCellModel.h"
#import "CTAppController.h"

@interface CTSelectedVehicleExtrasCell ()
@property (nonatomic, strong) CTSelectedVehicleExtrasCellModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *image;
@property (weak, nonatomic) IBOutlet UILabel *counter;
@end

@implementation CTSelectedVehicleExtrasCell

- (void)updateWithViewModel:(CTSelectedVehicleExtrasCellModel *)viewModel {
    self.viewModel = viewModel;
    self.titleLabel.text = viewModel.title;
    self.detailLabel.text = viewModel.detail;
    self.image.text = viewModel.imageCharacter;
}

- (IBAction)decrementButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapDecrementExtra payload:self.viewModel.extra];
}

- (IBAction)incrementButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapIncrementExtra payload:self.viewModel.extra];
}

- (IBAction)infoButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapExtraInfo payload:self.viewModel.extra];
}

@end
