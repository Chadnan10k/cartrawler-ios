//
//  CTNewBookingView.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 20/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInPathLoadingView.h"
#import <CartrawlerSDK/CTTextView.h>
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTAppearance.h>
#import "CTInPathBanner.h"
#import <CartrawlerSDK/CartrawlerSDK+UIImageView.h>
#import "CTInPathLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTInPathLoadingView ()

@property (strong, nonatomic) UIImageView *vehicleImageView;
@property (strong, nonatomic) UITextView *infoLabel;
@property (strong, nonatomic) CTLabel *headerLabel;


@property (strong, nonatomic) UIView *scrollingBannerContainer;
@property (strong, nonatomic) UIImageView *bannerImageView;
@property (strong, nonatomic) UIImageView *tickImageView;

@end

@implementation CTInPathLoadingView

- (instancetype)init
{
    self = [super init];
    self.backgroundColor = [UIColor redColor];
    return self;
}

@end
