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
    

    [self.navigationBar setBarTintColor:[CTAppearance instance].navigationBarTint];
    

    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor: [UIColor clearColor]];
    [shadow setShadowOffset: CGSizeMake(0.0f, 1.0f)];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:[CTAppearance instance].fontName size:20], NSFontAttributeName,
                                [UIColor blackColor], NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)forceLinkerLoad_
{
    
}

@end
