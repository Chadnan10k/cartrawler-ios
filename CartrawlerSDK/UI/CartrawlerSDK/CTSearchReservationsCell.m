//
//  CTSearchReservationsCell.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 21/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchReservationsCell.h"
#import "CTSearchReservationsCellModel.h"
#import "CTSplashCarView.h"
#import "CTAppController.h"

@interface CTSearchReservationsCell ()
@property (nonatomic) CTSearchReservationsCellModel *cellModel;
@property (weak, nonatomic) IBOutlet CTSplashCarView *carImageView;
@property (weak, nonatomic) IBOutlet UIButton *viewReservationButton;
@property (weak, nonatomic) IBOutlet UILabel *tripTo;
@property (weak, nonatomic) IBOutlet UILabel *destination;
@property (weak, nonatomic) IBOutlet UILabel *dates;

@end

@implementation CTSearchReservationsCell

+ (Class)viewModelClass {
    return CTSearchReservationsCellModel.class;
}

- (void)updateWithViewModel:(CTSearchReservationsCellModel *)viewModel {
    self.cellModel = viewModel;
    self.carImageView.primaryColor = viewModel.primaryColor;
    self.viewReservationButton.backgroundColor = viewModel.secondaryColor;
    [self.viewReservationButton setTitle:viewModel.button forState:UIControlStateNormal];
    self.tripTo.text = viewModel.trip;
    self.destination.text  = viewModel.destination;
    self.dates.text = viewModel.dates;
    [self setNeedsDisplay];
}
- (IBAction)viewReservationButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionSearchUserDidSelectReservation payload:self.cellModel.booking];
}

@end
