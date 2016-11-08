//
//  CTInterstitialCollectionViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 08/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInterstitialCollectionViewCell.h"

@interface CTInterstitialCollectionViewCell()

@property (nonatomic, strong) UIImageView *vendorImageView;

@end

@implementation CTInterstitialCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    //[self animateRandomly];
}

- (void)setData:(UIImage *)image
{
    if (!self.vendorImageView) {
        _vendorImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.vendorImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.vendorImageView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[image]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{ @"image" : self.vendorImageView }]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[image]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{ @"image" : self.vendorImageView }]];
    }
    
    if (self.vendorImageView) {
        self.vendorImageView.image = image;
        [self animateRandomly];
    }
}

- (void)animateRandomly
{
    int delay = arc4random()%5;

    [UIView animateWithDuration:0.5 delay:delay usingSpringWithDamping:0.1 initialSpringVelocity:0.5 options:0 animations:^{
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

@end
