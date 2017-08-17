//
//  CTSearchViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchViewController.h"
#import "CTSearchViewModel.h"
#import "CTSearchSplashViewController.h"
#import "CTSearchFormViewController.h"
#import "CTSearchLocationsViewController.h"
#import "CTSearchCalendarViewController.h"
#import "CTSearchSettingsViewController.h"
#import "CTSearchUSPViewController.h"
#import "CTSearchInterstitialViewController.h"
#import "CTAppController.h"

@interface CTSearchViewController ()
@property (nonatomic, strong) CTSearchViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) CTSearchSplashViewController *searchSplashVC;
@property (weak, nonatomic) IBOutlet UIView *searchSplashContainerView;
@property (nonatomic, weak) CTSearchFormViewController *searchFormVC;
@property (weak, nonatomic) IBOutlet UIView *searchFormContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchFormHeightConstraint;
@property (nonatomic, weak) CTSearchUSPViewController *searchUSPVC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintUSP;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@end

@implementation CTSearchViewController

+ (Class)viewModelClass {
    return CTSearchViewModel.class;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)updateWithViewModel:(CTSearchViewModel *)viewModel {
    // Force embedded views to load first time around
    self.view = self.view;
    
    self.viewModel = viewModel;
    
    self.navigationBar.barTintColor = viewModel.navigationBarColor;
    
    [self.searchSplashVC updateWithViewModel:viewModel.searchSplashViewModel];
    [self.searchFormVC updateWithViewModel:viewModel.searchFormViewModel];
    [self.searchUSPVC updateWithViewModel:viewModel.searchUSPViewModel];
    
    switch (viewModel.contentView) {
        case CTSearchContentViewNone:
            break;
        case CTSearchContentViewSplash:
            self.topConstraintUSP.constant = [self.searchSplashContainerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            break;
        case CTSearchContentViewForm:
            self.searchFormHeightConstraint.constant = [self.searchFormVC.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            self.topConstraintUSP.constant = [self.searchFormVC.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            break;
        default:
            break;
    }
    
    // TODO: Tidy up Keyboard Scrolling Logic, may be state redundancy
    // TODO: Convert once-offs to wantsScrollAboveKeyboard
    if (viewModel.scrollAboveUserInput > 0) {
        CGFloat formHeight = [self.searchFormVC.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenHeight = screenRect.size.height;
        CGFloat offset = formHeight - screenHeight + viewModel.scrollAboveUserInput;
        if (offset > self.scrollView.contentOffset.y) {
            [self.scrollView setContentOffset:CGPointMake(0, offset) animated:YES];
        }
        [CTAppController dispatchAction:CTActionSearchViewDidScrollAboveUserInput payload:nil];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.searchSplashContainerView.alpha = viewModel.contentView == CTSearchContentViewSplash;
        self.searchFormContainerView.alpha = viewModel.contentView == CTSearchContentViewForm;
        [self.view layoutIfNeeded];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SearchSplash"]) {
        self.searchSplashVC = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"SearchForm"]) {
        self.searchFormVC = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"SearchUSP"]) {
        self.searchUSPVC = segue.destinationViewController;
    }
}

- (IBAction)settingsButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionSearchUserDidTapSettingsButton payload:nil];
}

- (IBAction)closeButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionSearchUserDidTapCloseButton payload:nil];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}

@end
