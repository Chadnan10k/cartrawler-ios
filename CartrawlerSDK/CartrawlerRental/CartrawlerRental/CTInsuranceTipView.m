//
//  CTInsuranceTipView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 31/05/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTInsuranceTipView.h"
#import "CartrawlerSDK/CTLayoutManager.h"
#import "CartrawlerSDK/CartrawlerSDK+UIView.h"
#import "CartrawlerSDK/CartrawlerSDK+UIImageView.h"
#import "CartrawlerSDK/CTAppearance.h"

@interface CTInsuranceTipView()

@property (nonatomic, strong) UILabel *label;

@end

@implementation CTInsuranceTipView

- (instancetype)initWithImageAndTextView:(NSString *)imageName text:(NSString *)text
{
    self = [super init];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:self];
    layoutManager.orientation = CTLayoutManagerOrientationLeftToRight;
    layoutManager.justify = NO;
    
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIImage *icon = [UIImage imageNamed:imageName
                               inBundle:bundle
          compatibleWithTraitCollection:nil];
    
    imageView.image = icon;
    
    [imageView setHeightConstraint:@15 priority:@100];
    [imageView setWidthConstraint:@15 priority:@1000];
    [imageView applyTintWithColor:[CTAppearance instance].buttonColor];
    
    _label = [UILabel new];
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.text = text;
    self.label.numberOfLines = 0;
    
    [layoutManager insertView:UIEdgeInsetsMake(0,4,0,16) view:imageView];
    [layoutManager insertView:UIEdgeInsetsMake(0,16,0,4) view:self.label];
    
    [layoutManager layoutViews];
    
    return self;
}

- (void)setText:(NSString *)text
{
    self.label.text = text;
}

@end
