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
    
//    [CartrawlerSDK appearance].buttonColor = [UIColor someColor];
//    [CartrawlerSDK appearance].buttonTextColor = [UIColor someColor];
//    [CartrawlerSDK appearance].buttonCornerRadius = 2
//    [CartrawlerSDK appearance].enableShadows = NO;
//    
//    [CartrawlerSDK appearance].viewBackgroundColor =  = [UIColor someColor];
//    [CartrawlerSDK appearance].navigationBarColor = [UIColor someColor];
//    
//    [CartrawlerSDK appearance].textFieldCornerRadius = [UIColor someColor];
//    [CartrawlerSDK appearance].textFieldTint = [UIColor someColor];
//    [CartrawlerSDK appearance].textFieldBackgroundColor = [UIColor someColor];
//
//    [CartrawlerSDK appearance].calendarStartCellColor = [UIColor someColor];
//    [CartrawlerSDK appearance].calendarMidCellColor = [UIColor someColor];
//    [CartrawlerSDK appearance].calendarEndCellColor= [UIColor someColor];
//
//    [CartrawlerSDK appearance].fontName = @"HelveticaNeue-Light";
//    [CartrawlerSDK appearance].boldFontName = @"HelveticaNeue-Medium";
    
    [CartrawlerSDK appearance].presentAnimated = YES;
    [CartrawlerSDK appearance].modalPresentationStyle = UIModalPresentationOverFullScreen;
    [CartrawlerSDK appearance].modalTransitionStyle = UIModalTransitionStyleCoverVertical;

    _sdk = [[CartrawlerSDK alloc] initWithRequestorID:@"68622" languageCode:@"EN" isDebug:NO];
    
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
