//
//  CTSettingsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSearchSettingsViewController.h"
#import "CTSearchSettingsSelectionViewController.h"
#import <CartrawlerSDK/CTNavigationController.h>
#import <CartrawlerSDK/CTCSVItem.h>
#import <CartrawlerSDK/CTSDKSettings.h>
//#import "CTRentalConstants.h"
//#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTDesignableView.h>
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CTButton.h>
#import "CTSearchSettingsViewModel.h"
#import "CTAppController.h"
#import "CTSearchSettingsSelectionViewController.h"

@interface CTSearchSettingsViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UIButton *countryButton;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UIButton *languageButton;
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;
@property (weak, nonatomic) IBOutlet UIButton *currencyButton;
@property (weak, nonatomic) CTSearchSettingsSelectionViewController *settingsDetailsVC;
@end

@implementation CTSearchSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar.topItem.leftBarButtonItem setAction:@selector(close:)];
}

- (void)updateWithViewModel:(CTSearchSettingsViewModel *)viewModel {
    self.navigationBar.barTintColor = viewModel.navigationBarColor;
    
    self.navigationBar.topItem.title = viewModel.title;
    self.navigationBar.topItem.leftBarButtonItem.title = viewModel.closeButtonTitle;
    
    self.countryLabel.text = viewModel.countryLabelText;
    self.languageLabel.text = viewModel.languageLabelText;
    self.currencyLabel.text = viewModel.currencyLabelText;
    
    [self.countryButton setTitle:viewModel.country forState:UIControlStateNormal];
    [self.currencyButton setTitle:viewModel.currency forState:UIControlStateNormal];
    [self.languageButton setTitle:viewModel.language forState:UIControlStateNormal];
    
    switch (viewModel.selectedSettings) {
        case CTSearchSearchSettingsNone:
            if (self.presentedViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            break;
        case CTSearchSearchSettingsCountry:
        case CTSearchSearchSettingsLanguage:
        case CTSearchSearchSettingsCurrency:
            if (!self.settingsDetailsVC) {
                [self performSegueWithIdentifier:@"SearchDetails" sender:self];
            }
            break;
            
        default:
            break;
    }
    if (viewModel.selectedSettingsViewModel) {
        [self.settingsDetailsVC updateWithViewModel:viewModel.selectedSettingsViewModel];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.settingsDetailsVC = segue.destinationViewController;
}

- (void)close:(UIBarButtonItem *)sender {
    [CTAppController dispatchAction:CTActionSearchSettingsUserDidTapCloseButton payload:nil];
}

- (IBAction)country:(id)sender {
    [CTAppController dispatchAction:CTActionSearchSettingsUserDidTapCountryButton payload:nil];
}

- (IBAction)language:(id)sender {
    [CTAppController dispatchAction:CTActionSearchSettingsUserDidTapLanguageButton payload:nil];
}

- (IBAction)currency:(id)sender {
    [CTAppController dispatchAction:CTActionSearchSettingsUserDidTapCurrencyButton payload:nil];
}

@end
