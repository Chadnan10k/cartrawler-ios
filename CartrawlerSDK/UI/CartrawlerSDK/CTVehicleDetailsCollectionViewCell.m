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
#import <CartrawlerSDK/CartrawlerSDK+UIImageView.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import "CTRentalLocalizationConstants.h"

@interface CTVehicleDetailsCollectionViewCell()

@property (nonatomic, strong) CTLabel *detailLabel;
@property (nonatomic, strong) CTLabel *moreLabel;
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
    [self setup];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self setup];
    return self;
}

- (void)setup
{
    _detailLabel = [CTLabel new];
    self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailLabel.numberOfLines = 1;
    self.detailLabel.adjustsFontSizeToFitWidth = YES;
    self.detailLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:14];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    
    _moreLabel = [CTLabel new];
    self.moreLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.moreLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:30];
    self.moreLabel.textColor = [CTAppearance instance].headerTitleColor;
    self.moreLabel.textAlignment = NSTextAlignmentCenter;
    
    _imageView = [UIImageView new];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:self.detailLabel];
    [self addSubview:self.moreLabel];
    [self addSubview:self.imageView];
    
    [self applyConstraints];
}

- (void)applyConstraints
{
    //Image view
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[imageView(30)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"imageView" : self.imageView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[imageView]-4-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"imageView" : self.imageView}]];
    //More label
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[moreLabel(30)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"moreLabel" : self.moreLabel}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[moreLabel]-4-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"moreLabel" : self.moreLabel}]];
    //Detail label
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

- (void)setIndex:(NSInteger)index vehicle:(CTVehicle *)vehicle
{
    self.detailLabel.textColor = [UIColor blackColor];
    self.moreLabel.text = @"";
    
    switch (index) {
        case 0:
            self.detailLabel.text = [NSString stringWithFormat:@"%@ %@", vehicle.passengerQty.stringValue, CTLocalizedString(CTRentalVehiclePassengers)];
            self.imageView.image = [UIImage imageNamed:@"people"
                                              inBundle:[NSBundle bundleForClass:[self class]]
                         compatibleWithTraitCollection:nil];
            break;
        case 1:
            self.detailLabel.text = [NSString stringWithFormat:@"%@ %@", vehicle.baggageQty.stringValue, CTLocalizedString(CTRentalVehicleBags)];
            self.imageView.image = [UIImage imageNamed:@"baggage"
                                              inBundle:[NSBundle bundleForClass:[self class]]
                         compatibleWithTraitCollection:nil];
            break;
        case 2:
            self.detailLabel.text = [NSString stringWithFormat:@"%@ %@", vehicle.doorCount.stringValue, CTLocalizedString(CTRentalVehicleDoors)];
            self.imageView.image = [UIImage imageNamed:@"doors"
                                              inBundle:[NSBundle bundleForClass:[self class]]
                         compatibleWithTraitCollection:nil];
            break;
        case 3:
            [self setupMoreCell:vehicle];
            break;
        default:
            break;
    }
    [self.imageView applyTintWithColor:[UIColor blackColor]];
}

- (void)setupMoreCell:(CTVehicle *)vehicle
{
    self.detailLabel.text = CTLocalizedString(CTRentalMore);
    int features = 0;
    //how many features do we have?
    if (vehicle.isAirConditioned) {
        features++;
    }
    
    if (vehicle.isUSBEnabled) {
        features++;
    }
    
    if (vehicle.isBluetoothEnabled) {
        features++;
    }
    
    if (vehicle.isGPSIncluded) {
        features++;
    }
    
    //lets ++ for transmission
    features++;
    self.moreLabel.text = [NSString stringWithFormat:@"+%d", features];
    self.detailLabel.textColor = [CTAppearance instance].headerTitleColor;
    self.imageView.image = nil;

}

@end
