//
//  CTSearchErrorViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 09/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchErrorViewController.h"
#import "CTSearchErrorViewModel.h"

@implementation CTSearchErrorViewController

+ (Class)viewModelClass {
    return CTSearchErrorViewModel.class;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverCurrentContext;
}

- (UIModalTransitionStyle)modalTransitionStyle {
    return UIModalTransitionStyleCrossDissolve;
}

@end
