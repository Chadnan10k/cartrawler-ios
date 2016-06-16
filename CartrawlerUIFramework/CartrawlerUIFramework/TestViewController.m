//
//  TestViewController.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "TestViewController.h"
#import "CartrawlerUI.h"
#import "InjectionTestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CartrawlerUI *ctUI = [[CartrawlerUI alloc] initWithRequestorID:@"68622" languageCode:@"EN" isDebug:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InjectionTestViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"InjectionTestViewController"];
        
    [ctUI presentSearchViewInViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
