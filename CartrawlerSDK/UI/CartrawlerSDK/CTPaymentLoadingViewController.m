//
//  CTPaymentLoadingViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 23/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentLoadingViewController.h"
#import "CTLabel.h"

@interface CTPaymentLoadingViewController ()

@property (weak, nonatomic) IBOutlet CTLabel *topLabel;
@property (weak, nonatomic) IBOutlet CTLabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@end

@implementation CTPaymentLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
        self.topImageView.transform = CGAffineTransformMakeScale(1.35, 1.35);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 animations:^{
            self.topImageView.transform = CGAffineTransformIdentity;
        }];
    }];
    
    [UIView animateWithDuration:0.6 delay:2 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
        self.bottomImageView.transform = CGAffineTransformMakeScale(1.35, 1.35);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 animations:^{
            self.bottomImageView.transform = CGAffineTransformIdentity;
        }];
    }];
}

+ (instancetype)sharedInstance
{
    static CTPaymentLoadingViewController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *b = [NSBundle bundleForClass:[self class]];
        UIStoryboard *settingsStoryboard = [UIStoryboard storyboardWithName:@"Payment" bundle:b];
        sharedInstance = [settingsStoryboard instantiateViewControllerWithIdentifier:@"CTPaymentLoadingViewController"];
    });
    return sharedInstance;
}

+ (void)present:(UIViewController *)viewController
{
    
    [[CTPaymentLoadingViewController sharedInstance] setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [[CTPaymentLoadingViewController sharedInstance] setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [viewController presentViewController:[CTPaymentLoadingViewController sharedInstance] animated:YES completion:nil];
}

+ (void)dismiss
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[CTPaymentLoadingViewController sharedInstance] dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
