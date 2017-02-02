//
//  CTPaymentSummaryTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 11/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentSummaryItemTableViewCell.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTSDKSettings.h>
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTPaymentSummaryItemTableViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *infoLabel;
@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;

@end

@implementation CTPaymentSummaryItemTableViewCell

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
    self.priceLabel.text = [price numberStringWithCurrencyCode];
    self.infoLabel.text = detail;
}

- (void)setDetailsItalic:(NSString *)detail
{
    
    NSAttributedString *rating = [[NSAttributedString alloc] initWithString:CTLocalizedString(CTRentalSummaryPayAtDesk)
                                                                 attributes:@{NSFontAttributeName:
                                                                                  [UIFont fontWithName:@"AvenirNext-Italic" size:17],
                                                                              NSForegroundColorAttributeName:
                                                                                  [UIColor lightGrayColor]}];
    
    self.priceLabel.attributedText = rating;
    self.infoLabel.text = detail;
    
}

@end
