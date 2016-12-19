//
//  LocationSearchTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "LocationSearchTableViewCell.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CartrawlerSDK+UIImageView.h>

@interface LocationSearchTableViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;

@end

@implementation LocationSearchTableViewCell




- (void)setLabelText:(NSString *)text isAirport:(BOOL)isAirport
{
    NSBundle *b = [NSBundle bundleForClass:[self class]];
    
    if (isAirport) {
        self.locationImageView.image = [UIImage imageNamed:@"location_airport" inBundle:b compatibleWithTraitCollection:nil];
    } else {
        self.locationImageView.image = [UIImage imageNamed:@"location" inBundle:b compatibleWithTraitCollection:nil];
    }
    
    [self.locationImageView applyTint];
    self.locationLabel.text = text;
}

@end
