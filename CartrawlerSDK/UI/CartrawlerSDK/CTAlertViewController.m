//
//  CTAlertViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 09/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAlertViewController.h"
#import "CTAlertViewModel.h"
#import "CTViewControllerProtocol.h"

@interface CTAlertViewController () <CTViewControllerProtocol>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (nonatomic) CTAlertAction *alertAction;
@end

@implementation CTAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)updateWithViewModel:(CTAlertViewModel *)viewModel {
    self.titleLabel.text = viewModel.title;
    self.messageLabel.attributedText = viewModel.message;
    [self.okButton setTitle:viewModel.action.title forState:UIControlStateNormal];
    self.alertAction = viewModel.action;
}

- (IBAction)okButtonTapped:(id)sender {
    //TODO: Check memory leak possibility
    self.alertAction.handler(self.alertAction);
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverCurrentContext;
}

- (UIModalTransitionStyle)modalTransitionStyle {
    return UIModalTransitionStyleCrossDissolve;
}

@end
