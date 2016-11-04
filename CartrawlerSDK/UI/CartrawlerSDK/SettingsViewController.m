//
//  SettingsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsSelectionViewController.h"
#import "CTNavigationController.h"
#import "CSVItem.h"
#import "CTSDKSettings.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *currencyButton;
@property (weak, nonatomic) IBOutlet UIButton *countryButton;
@property (weak, nonatomic) IBOutlet UIButton *languageButton;
@property (strong, nonatomic) UIStoryboard *settingsStoryboard;

@end

@implementation SettingsViewController


{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSBundle *b = [NSBundle bundleForClass:[self class]];
    _settingsStoryboard = [UIStoryboard storyboardWithName:@"StepOne" bundle:b];
    // Do any additional setup after loading the view.
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
    SettingsSelectionViewController *vc = [self.settingsStoryboard instantiateViewControllerWithIdentifier:@"SettingsSelectionViewController"];
    
    [vc setSettingsType:SettingsTypeCurrency];
    
    [self presentViewController:vc animated:YES completion:nil];
    __weak typeof (self) weakSelf = self;
    vc.settingsCompletion = ^(CSVItem *item){
        [CTSDKSettings instance].currencyCode = [item.code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [CTSDKSettings instance].currencyName = [item.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [weakSelf.currencyButton setTitle:item.name forState:UIControlStateNormal];
    };
}

- (IBAction)language:(id)sender
{
    SettingsSelectionViewController *vc = [self.settingsStoryboard instantiateViewControllerWithIdentifier:@"SettingsSelectionViewController"];
    
    [vc setSettingsType:SettingsTypeLanguage];
    
    [self presentViewController:vc animated:YES completion:nil];
    __weak typeof (self) weakSelf = self;
    vc.settingsCompletion = ^(CSVItem *item){
        [CTSDKSettings instance].languageCode = [item.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [CTSDKSettings instance].languageName = [item.code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [weakSelf.languageButton setTitle:item.code forState:UIControlStateNormal];
    };
}

- (IBAction)country:(id)sender
{
    SettingsSelectionViewController *vc = [self.settingsStoryboard instantiateViewControllerWithIdentifier:@"SettingsSelectionViewController"];
   
    [vc setSettingsType:SettingsTypeCountry];
    
    [self presentViewController:vc animated:YES completion:nil];
    __weak typeof (self) weakSelf = self;
    vc.settingsCompletion = ^(CSVItem *item){
        [CTSDKSettings instance].homeCountryCode = [item.code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [CTSDKSettings instance].homeCountryName = [item.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [weakSelf.countryButton setTitle:item.name forState:UIControlStateNormal];

    };
}

@end
