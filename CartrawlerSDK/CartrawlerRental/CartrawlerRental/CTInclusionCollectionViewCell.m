//
//  VehicleFeatureCollectionViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 25/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInclusionCollectionViewCell.h"
#import <CartrawlerSDK/CTLabel.h>

@interface CTInclusionCollectionViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *itemTextLabel;

@end

@implementation CTInclusionCollectionViewCell

- (void)setData:(NSString *)text
{
    self.itemTextLabel.text = text;
}

@end
