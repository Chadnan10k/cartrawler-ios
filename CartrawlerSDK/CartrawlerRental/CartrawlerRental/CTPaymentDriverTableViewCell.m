
//
//  CTPaymentDriverTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentDriverTableViewCell.h"
#import <CartrawlerSDK/CTLabel.h>

@interface CTPaymentDriverTableViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *driverDetailLabel;

@end

@implementation CTPaymentDriverTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSString *)text
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.driverDetailLabel.text = text;
}

@end
