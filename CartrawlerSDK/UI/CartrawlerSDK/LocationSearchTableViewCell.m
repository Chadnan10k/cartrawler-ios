//
//  LocationSearchTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "LocationSearchTableViewCell.h"
#import "CTLabel.h"

@interface LocationSearchTableViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;

@end

@implementation LocationSearchTableViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)setLabelText:(NSString *)text isAirport:(BOOL)isAirport
{
    NSBundle *b = [NSBundle bundleForClass:[self class]];
    
    if (isAirport) {
        self.locationImageView.image = [UIImage imageNamed:@"location_airport" inBundle:b compatibleWithTraitCollection:nil];
    } else {
        self.locationImageView.image = [UIImage imageNamed:@"location_city" inBundle:b compatibleWithTraitCollection:nil];
    }
    
    self.locationLabel.text = text;
}

@end
