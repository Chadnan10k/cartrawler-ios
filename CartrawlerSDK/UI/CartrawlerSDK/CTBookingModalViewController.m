//
//  CTBookingModalViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 21/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTBookingModalViewController.h"
#import "CTBookingTableViewController.h"
#import "CTBookingModalViewModel.h"
#import "CTAppController.h"

@interface CTBookingModalViewController ()
@property (nonatomic) CTBookingTableViewController *bookingTableVC;
@property (weak, nonatomic) IBOutlet UIView *buttonContainer;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@end

@implementation CTBookingModalViewController

+ (Class)viewModelClass {
    return CTBookingModalViewModel.class;
}

- (void)updateWithViewModel:(CTBookingModalViewModel *)viewModel {
    // Force segued views to load
    self.view = self.view;
    
    [self.bookingTableVC updateWithViewModel:viewModel.bookingTableViewModel];
    self.nextButton.backgroundColor = viewModel.buttonColor;
    [self.nextButton setTitle:viewModel.button forState:UIControlStateNormal];
    self.nextButton.enabled = viewModel.buttonEnabled;
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.buttonContainer.backgroundColor = viewModel.buttonContainerColor;
                     }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BookingTable"]) {
        self.bookingTableVC = segue.destinationViewController;
    }
}

- (IBAction)nextButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionBookingConfirmationUserTappedNext payload:nil];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}
@end
