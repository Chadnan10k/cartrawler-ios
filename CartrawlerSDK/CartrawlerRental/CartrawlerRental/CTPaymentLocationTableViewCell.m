//
//  CTPaymentLocationTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentLocationTableViewCell.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CartrawlerSDK+NSDateUtils.h>

@interface CTPaymentLocationTableViewCell()

@property (nonatomic, weak) IBOutlet CTLabel *headerLabel;
@property (nonatomic, weak) IBOutlet CTLabel *subheaderLabel;

@end

@implementation CTPaymentLocationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(CTMatchedLocation *)location date:(NSDate *)date
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.headerLabel.text = location.name;
    self.subheaderLabel.text = [date stringFromDate:@"HH:mm a, dd MMMM YYYY"];
}

@end
