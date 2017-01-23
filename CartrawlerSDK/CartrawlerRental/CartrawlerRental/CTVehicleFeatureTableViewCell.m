//
//  CTInclusionTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 28/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleFeatureTableViewCell.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTImageView.h>
#import <CartrawlerSDK/CartrawlerSDK+UIImageView.h>

@interface CTVehicleFeatureTableViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *detailLabel;
@property (weak, nonatomic) IBOutlet CTImageView *detailImageView;

@end

@implementation CTVehicleFeatureTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

- (void)setData:(NSString *)text image:(UIImage *)image
{
    self.detailLabel.text = text;
    self.detailImageView.image = image;
    [self.detailImageView applyTint];
}

@end
