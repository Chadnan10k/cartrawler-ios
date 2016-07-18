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

@end

@implementation SettingsViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)currency:(id)sender {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepOne" bundle:b];
    SettingsSelectionViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsSelectionViewController"];
    
    [vc setSettingsType:SettingsTypeCurrency];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    vc.settingsCompletion = ^(CSVItem *item){
        [[CTSDKSettings instance] setCurrencyCode:[item.code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [self.currencyButton setTitle:item.name forState:UIControlStateNormal];
    };
}

- (IBAction)language:(id)sender {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepOne" bundle:b];
    SettingsSelectionViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsSelectionViewController"];
    
    [vc setSettingsType:SettingsTypeLanguage];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    vc.settingsCompletion = ^(CSVItem *item){
        [[CTSDKSettings instance] setLanguageCode:[item.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [self.languageButton setTitle:item.code forState:UIControlStateNormal];
    };
}

- (IBAction)country:(id)sender {
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *b = [NSBundle bundleWithPath:bundlePath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepOne" bundle:b];
    SettingsSelectionViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsSelectionViewController"];
   
    [vc setSettingsType:SettingsTypeCountry];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    vc.settingsCompletion = ^(CSVItem *item){
        [[CTSDKSettings instance] setHomeCountryCode:[item.code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [self.countryButton setTitle:item.name forState:UIControlStateNormal];

    };
    
}

@end
