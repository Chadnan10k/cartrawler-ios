//
//  VehicleFeatureCollectionViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 25/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleFeatureCollectionViewCell.h"
#import "CTLabel.h"

@interface VehicleFeatureCollectionViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *itemTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;

@end

@implementation VehicleFeatureCollectionViewCell



- (void)setData:(NSString *)text image:(UIImage *)image
{
    self.itemTextLabel.text = text;
    self.itemImageView.image = image;
}

@end
