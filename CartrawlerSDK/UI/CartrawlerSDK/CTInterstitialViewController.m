//
//  CTInsterstitialViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 29/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInterstitialViewController.h"

@interface CTInterstitialViewController ()


@end

@implementation CTInterstitialViewController

{}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.spinnerImageView.layer animationForKey:@"SpinAnimation"] == nil) {
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
        animation.duration = 1.0f;
        animation.repeatCount = INFINITY;
        [self.spinnerImageView.layer addAnimation:animation forKey:@"SpinAnimation"];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)sharedInstance
{
    static CTInterstitialViewController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *b = [NSBundle bundleForClass:[self class]];
        UIStoryboard *settingsStoryboard = [UIStoryboard storyboardWithName:@"Interstitial" bundle:b];
        sharedInstance = [settingsStoryboard instantiateViewControllerWithIdentifier:@"CTInterstitialViewController"];
    });
    return sharedInstance;
}

+ (void)present:(UIViewController *)viewController
{

    [[CTInterstitialViewController sharedInstance] setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [[CTInterstitialViewController sharedInstance] setModalPresentationStyle:UIModalPresentationOverFullScreen];

    [viewController presentViewController:[CTInterstitialViewController sharedInstance] animated:YES completion:nil];
}

+ (void)dismiss
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //[[CTInterstitialViewController sharedInstance].spinnerImageView.layer removeAnimationForKey:@"SpinAnimation"];
        [[CTInterstitialViewController sharedInstance] dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
