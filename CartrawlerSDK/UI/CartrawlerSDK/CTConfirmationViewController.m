//
//  CTConfirmationViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 19/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTConfirmationViewController.h"
#import "CTConfirmationViewModel.h"
#import "CTCreditCardImageView.h"
#import "CTDashedLine.h"
#import "CTCarImageView.h"
#import "CTTickImageView.h"

@interface CTConfirmationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topMessage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImageWidth;
@property (weak, nonatomic) IBOutlet CTCreditCardImageView *creditCardImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *creditCardHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *creditCardWidth;
@property (weak, nonatomic) IBOutlet CTTickImageView *tickImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tickHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tickWidth;
@property (weak, nonatomic) IBOutlet CTDashedLine *divider1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet CTDashedLine *divider2;
@property (weak, nonatomic) IBOutlet CTCarImageView *carImageView;
@property (weak, nonatomic) IBOutlet UILabel *bottomMessage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMessageHeight;
@property (weak, nonatomic) IBOutlet UILabel *scrollMessage;
@property (weak, nonatomic) IBOutlet UILabel *chevron;

@property (weak, nonatomic) IBOutlet UILabel *pickupLocation;
@property (weak, nonatomic) IBOutlet UILabel *pickupTime;
@property (weak, nonatomic) IBOutlet UILabel *dropoffLocation;
@property (weak, nonatomic) IBOutlet UILabel *dropoffTime;

@property (weak, nonatomic) IBOutlet UILabel *driverName;
@property (weak, nonatomic) IBOutlet UILabel *driverEmail;
@property (weak, nonatomic) IBOutlet UILabel *driverPhoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *insuranceIncluded;

@end

@implementation CTConfirmationViewController

+ (Class)viewModelClass {
    return CTConfirmationViewModel.class;
}

- (void)updateWithViewModel:(CTConfirmationViewModel *)viewModel {
    if (!viewModel.processing) {
        [self.divider1 removeFromSuperview];
        [self.activityIndicator removeFromSuperview];
        [self.divider2 removeFromSuperview];
    }
    
    CGFloat duration = viewModel.processing ? 0 : 5;
    
    [UIView animateWithDuration:duration animations:^{
        
    }];
    
    [UIView animateWithDuration:3 animations:^{
        [self.view layoutIfNeeded];
        self.topMessage.text = viewModel.topMessage;
        self.bottomMessage.alpha = 0;
        self.scrollMessage.text = viewModel.scrollMessage;
        self.pickupLocation.text = viewModel.pickupLocation;
        self.pickupTime.text = viewModel.pickupTime;
        self.dropoffLocation.text = viewModel.dropoffLocation;
        self.dropoffTime.text = viewModel.dropoffTime;
        self.creditCardWidth.constant = viewModel.processing ? self.creditCardWidth.constant : 0;
        self.creditCardHeight.constant = viewModel.processing ? self.creditCardWidth.constant : 0;
        self.tickWidth.constant = viewModel.processing ? self.tickWidth.constant : 50;
        self.tickHeight.constant = viewModel.processing ? self.tickHeight.constant : 50;
    } completion:^(BOOL finished) {
        self.bottomMessage.text = viewModel.bottomMessage;
        self.bottomMessageHeight.active = NO;
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:3 animations:^{
            self.bottomMessage.text = viewModel.bottomMessage;
            self.bottomMessage.alpha = 1;
            self.scrollMessage.hidden =
            self.chevron.hidden = viewModel.processing;
        }];
    }];
    
    [self.tickImageView setNeedsDisplay];
    
    self.driverName.text = viewModel.driverName;
    self.driverEmail.text = viewModel.driverEmail;
    self.driverPhoneNumber.text = viewModel.driverPhoneNumber;
    self.insuranceIncluded.text = viewModel.insuranceIncluded;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return self.view.frame.size.height;
            break;
        case 1:
        case 2:
            return 74;
        default:
            return 44;
            break;
    }
}

@end
