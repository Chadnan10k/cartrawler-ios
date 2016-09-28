//
//  ViewController.m
//  TestApp
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ViewController.h"
#import <CartrawlerSDK/CartrawlerSDK.h>

@interface ViewController ()

@property (nonatomic, strong) CartrawlerSDK *sdk;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    [CartrawlerSDK appearance].fontName = @"OpenSans-Light";
    [CartrawlerSDK appearance].boldFontName = @"OpenSans-Semibold";
    
    _sdk = [[CartrawlerSDK alloc] initWithRequestorID:@"68622" languageCode:@"EN" isDebug:YES];
    
    //[CTAppearance instance].buttonColor = [UIColor blackColor];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openCarRental:(id)sender {
    [self.sdk presentCarRentalInViewController:self];
}

- (IBAction)openGroundTransport:(id)sender {
    [self.sdk presentGroundTransportInViewController:self];
}

@end
