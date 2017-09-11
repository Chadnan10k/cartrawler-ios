//
//  CTTermsConditionsDetailViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 11/09/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import "CTTermsConditionsDetailViewController.h"
#import "CTTermsConditionsDetailViewModel.h"

@interface CTTermsConditionsDetailViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation CTTermsConditionsDetailViewController

+ (Class)viewModelClass {
    return CTTermsConditionsDetailViewModel.class;
}

- (void)updateWithViewModel:(CTTermsConditionsDetailViewModel *)viewModel {
    self.navigationBar.barTintColor = viewModel.primaryColor;
    self.navigationBar.topItem.title = viewModel.title;
    [self.closeButton setTitle:viewModel.close];
    self.textView.text = viewModel.detail;
}

// MARK: UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Fix for Apple bug which scrolls the text view from top on appearance
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.textView scrollRangeToVisible:NSMakeRange(0, 1)];
    });
}

// MARK: Back Button

- (IBAction)closeButtonTapped:(UIBarButtonItem *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapCloseTermAndCondition payload:nil];
}

// MARK: Shake Gesture

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}
@end
