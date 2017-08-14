//
//  CTSelectedVehicleExtrasCell.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleExtrasCell.h"
#import "CTAppController.h"

@interface CTSelectedVehicleExtrasCell ()
@property (nonatomic, strong) CTSelectedVehicleExtrasCellModel *viewModel;
@property (weak, nonatomic) IBOutlet UIView *regularView;
@property (weak, nonatomic) IBOutlet UIView *flippedView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *image;
@property (weak, nonatomic) IBOutlet UILabel *counter;
@property (weak, nonatomic) IBOutlet UIButton *decrementButton;
@property (weak, nonatomic) IBOutlet UIButton *incrementButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UILabel *flippedTitle;
@property (weak, nonatomic) IBOutlet UILabel *flippedDetail;
@end

@implementation CTSelectedVehicleExtrasCell

- (void)updateWithViewModel:(CTSelectedVehicleExtrasCellModel *)viewModel {
    [self updateWithViewModel:viewModel animated:NO];
}

- (void)updateWithViewModel:(CTSelectedVehicleExtrasCellModel *)viewModel animated:(BOOL)animated {
    self.viewModel = viewModel;
    self.titleLabel.text = viewModel.title;
    self.detailLabel.text = viewModel.detail;
    self.image.text = viewModel.imageCharacter;
    self.counter.text = viewModel.quantity;
    
    self.flippedTitle.text = viewModel.title;
    self.flippedDetail.text = viewModel.moreDetail;
    
    self.decrementButton.enabled = viewModel.decrementEnabled;
    self.incrementButton.enabled = viewModel.incrementEnabled;
    
    self.decrementButton.backgroundColor = viewModel.decrementButtonColor;
    self.incrementButton.backgroundColor = viewModel.incrementButtonColor;
    
    [self flip:viewModel.flipped animated:animated];
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

- (void)flip:(BOOL)flipped animated:(BOOL)animated {
    if ((flipped && !self.regularView.hidden) || (!flipped && self.regularView.hidden)) {
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        [UIView transitionWithView:self.contentView
                          duration:animated ? 0.4 : 0
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            self.regularView.hidden = flipped;
                            self.flippedView.hidden = !flipped;
                        } completion:^(BOOL finished) {
                            self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
                        }];
    }
}

@end
