//
//  CompletionViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CompletionViewController.h"

@interface CompletionViewController ()

@property (nonatomic, strong) UIViewController *mainViewController;

@end

@implementation CompletionViewController

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

- (void)presentInViewController:(UIViewController *)viewController
{
    _mainViewController = viewController;
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.mainViewController presentViewController:self animated:YES completion:nil];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.mainViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
