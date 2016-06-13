//
//  CartrawlerAPI.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 13/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerUI.h"
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface CartrawlerUI()

@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;

@end

@implementation CartrawlerUI

- (id)initWithRequestorID:(NSString *)requestorID
             languageCode:(NSString *)languageCode
                  isDebug:(BOOL)isDebug
{
    self = [super self];
    
    _cartrawlerAPI = [[CartrawlerAPI alloc]
             initWithClientKey:requestorID
                      language:languageCode
                         debug:isDebug];
    
    return self;
}

- (void)presentCartrawlerView
{
    
}

- (void)overrideStepOne:(UIViewController *)viewController
{
    
}

@end
