//
//  CTSettingsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSettingsViewController.h"
#import "CTSettingsSelectionViewController.h"
#import <CartrawlerSDK/CTNavigationController.h>
#import <CartrawlerSDK/CTCSVItem.h>
#import <CartrawlerSDK/CTSDKSettings.h>
#import "CTRentalConstants.h"
#import <CartrawlerSDK/CTDesignableView.h>

@interface CTSettingsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *currencyButton;
@property (weak, nonatomic) IBOutlet UIButton *countryButton;
@property (weak, nonatomic) IBOutlet UIButton *languageButton;
@property (strong, nonatomic) UIStoryboard *settingsStoryboard;
@property (weak, nonatomic) IBOutlet CTDesignableView *currencyView;

@end

@implementation CTSettingsViewController

- (void)viewWillAppear:(BOOL)animated
{
    if ([CTSDKSettings instance].disableCurrencySelection) {
        self.currencyView.hidden = YES;
    } else {
        self.currencyView.hidden = NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSBundle *b = [NSBundle bundleForClass:[self class]];
    _settingsStoryboard = [UIStoryboard storyboardWithName:CTRentalSearchStoryboard bundle:b];

    [self.currencyButton setTitle:[CTSDKSettings instance].currencyName forState:UIControlStateNormal];
    [self.languageButton setTitle:[CTSDKSettings instance].languageName forState:UIControlStateNormal];
    [self.countryButton setTitle:[CTSDKSettings instance].homeCountryName forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)currency:(id)sender
{
    CTSettingsSelectionViewController *vc = [self.settingsStoryboard instantiateViewControllerWithIdentifier:CTRentalSettingsSelectionViewIdentifier];
    
    [vc setSettingsType:SettingsTypeCurrency];
    
    [self presentViewController:vc animated:YES completion:nil];
    __weak typeof (self) weakSelf = self;
    vc.settingsCompletion = ^(CTCSVItem *item){
        [CTSDKSettings instance].currencyCode = [item.code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [CTSDKSettings instance].currencyName = [item.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [weakSelf.currencyButton setTitle:item.name forState:UIControlStateNormal];
    };
}

- (IBAction)language:(id)sender
{
    CTSettingsSelectionViewController *vc = [self.settingsStoryboard instantiateViewControllerWithIdentifier:CTRentalSettingsSelectionViewIdentifier];
    
    [vc setSettingsType:SettingsTypeLanguage];
    
    [self presentViewController:vc animated:YES completion:nil];
    __weak typeof (self) weakSelf = self;
    vc.settingsCompletion = ^(CTCSVItem *item){
        [CTSDKSettings instance].languageCode = [item.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [CTSDKSettings instance].languageName = [item.code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [weakSelf.languageButton setTitle:item.code forState:UIControlStateNormal];
    };
}

- (IBAction)country:(id)sender
{
    CTSettingsSelectionViewController *vc = [self.settingsStoryboard instantiateViewControllerWithIdentifier:CTRentalSettingsSelectionViewIdentifier];
   
    [vc setSettingsType:SettingsTypeCountry];
    
    [self presentViewController:vc animated:YES completion:nil];
    __weak typeof (self) weakSelf = self;
    vc.settingsCompletion = ^(CTCSVItem *item){
        [CTSDKSettings instance].homeCountryCode = [item.code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [CTSDKSettings instance].homeCountryName = [item.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [weakSelf.countryButton setTitle:item.name forState:UIControlStateNormal];

    };
}

@end
