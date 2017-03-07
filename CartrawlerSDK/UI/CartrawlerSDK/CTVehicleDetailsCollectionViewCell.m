//
//  CTVehicleDetailsCollectionViewCell.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 07/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleDetailsCollectionViewCell.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTAppearance.h>

@interface CTVehicleDetailsCollectionViewCell()

@property (nonatomic, strong) CTLabel *detailLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CTVehicleDetailsCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _detailLabel = [CTLabel new];
    self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    
    _imageView = [UIImageView new];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:self.detailLabel];
    [self addSubview:self.imageView];
    
    [self applyConstraints];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    _detailLabel = [CTLabel new];
    self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    _imageView = [UIImageView new];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.detailLabel];
    [self addSubview:self.imageView];
    
    [self applyConstraints];
    return self;
}

- (void)applyConstraints
{
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[imageView(50)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"imageView" : self.imageView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[imageView]-4-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"imageView" : self.imageView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView]-4-[label]-4-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"imageView" : self.imageView,
                                                                           @"label" : self.detailLabel}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[label]-4-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"label" : self.detailLabel}]];
}

- (void)setIndex:(NSInteger)index
{
    self.detailLabel.text = @"test";
    self.imageView.image = [UIImage imageNamed:@"people"
                                      inBundle:[NSBundle bundleForClass:[self class]]
                 compatibleWithTraitCollection:nil];

    switch (index) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
}

@end
