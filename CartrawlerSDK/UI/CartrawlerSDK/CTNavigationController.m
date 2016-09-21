//
//  CTNavigationController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTNavigationController.h"
#import "CTAppearance.h"

@interface CTNavigationController ()

@end

@implementation CTNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSShadow *shadow = [NSShadow new];
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeMake(0.0f, 1.0f);
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont
                                                                           fontWithName:[CTAppearance instance].fontName size:20],
                                NSForegroundColorAttributeName: [UIColor blackColor]};
    
    [UINavigationBar appearance].titleTextAttributes = attributes;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)forceLinkerLoad_
{
    
}

@end
