//
//  PaymentSummaryTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 11/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentSummaryTableViewCell.h"
#import "CTLabel.h"
#import "CTSDKSettings.h"
#import "NSNumberUtils.h"

@interface PaymentSummaryTableViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *infoLabel;
@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;

@end

@implementation PaymentSummaryTableViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDetails:(NSString *)detail price:(NSNumber *)price
{
    self.priceLabel.text = [NSNumberUtils numberStringWithCurrencyCode:price];
    self.infoLabel.text = detail;
}

- (void)setDetailsItalic:(NSString *)detail
{
    
    NSAttributedString *rating = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"pay at desk", @"pay at desk")
                                                                 attributes:@{NSFontAttributeName:
                                                                                  [UIFont fontWithName:@"AvenirNext-Italic" size:17],
                                                                              NSForegroundColorAttributeName:
                                                                                  [UIColor lightGrayColor]}];
    
    self.priceLabel.attributedText = rating;
    self.infoLabel.text = detail;
    
}

@end
