//
//  CTPaymentSummaryExpandedTableViewCell.m
//  CartrawlerSDK
//
//  Created by Alan on 29/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTPaymentSummaryExpandedTableViewCell.h"
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerAPI/CTFee.h>
#import <CartrawlerAPI/CTExtraEquipment.h>
#import <CartrawlerAPI/CTInsurance.h>
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import "CTRentalLocalizationConstants.h"

@interface CTPaymentSummaryExpandedTableViewCell ()
@property (nonatomic, strong) CTLabel *titleLabel;
@property (nonatomic, strong) CTLabel *detailLabel;
@end

@implementation CTPaymentSummaryExpandedTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.titleLabel = [[CTLabel alloc] init:16.0 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft boldFont:NO];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
        self.detailLabel = [[CTLabel alloc] init:16.0 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentRight boldFont:NO];
        self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.detailLabel.textColor = [UIColor whiteColor];
        self.detailLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.detailLabel];
        
        NSDictionary *viewDictionary = @{@"titleLabel" : self.titleLabel, @"detailLabel" : self.detailLabel};
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]-[detailLabel]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewDictionary]];
        [self.detailLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewDictionary]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[detailLabel]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewDictionary]];
        
    }
    return self;
}

- (void)updateWithModel:(id)model {
    if ([model isKindOfClass:CTFee.class]) {
        [self updateWithFee:model];
    }
    if ([model isKindOfClass:CTExtraEquipment.class]) {
        [self updateWithExtraEquipment:model];
    }
    if ([model isKindOfClass:CTInsurance.class]) {
        [self updateWithInsurance:model];
    }
    if ([model isKindOfClass:NSString.class]) {
        [self updateWithString:model];
    }
}

- (void)updateWithFee:(CTFee *)fee {
    switch (fee.feePurpose) {
        case CTFeeTypePayNow:
            self.titleLabel.text = CTLocalizedString(CTRentalSummaryPayNow);
            break;
        case CTFeeTypePayAtDesk:
            self.titleLabel.text = CTLocalizedString(CTRentalSummaryPayAtDesk);
            break;
        case CTFeeTypeBooking:
            self.titleLabel.text = CTLocalizedString(CTRentalSummaryBookingFee);
            break;
        default:
            break;
    }
    self.detailLabel.text = [fee.feeAmount numberStringWithCurrencyCode];
}

- (void)updateWithExtraEquipment:(CTExtraEquipment *)extra {
    self.titleLabel.text = [self titleForExtra:extra];
    self.detailLabel.text = [self detailForExtra:extra];
}

- (NSString *)titleForExtra:(CTExtraEquipment *)extra {
    NSString *title = extra.equipDescription;
    if (extra.qty > 1) {
        NSString *quantity = [NSString stringWithFormat:@" (x%ld)", (long)extra.qty];
        title = [title stringByAppendingString:quantity];
    }
    return title;
}

- (NSString *)detailForExtra:(CTExtraEquipment *)extra {
    if (extra.isIncludedInRate) {
        return CTLocalizedString(CTRentalPaymentFree);
    }
    double charge = extra.chargeAmount.doubleValue * extra.qty;
    return [@(charge) numberStringWithCurrencyCode];
}

- (void)updateWithInsurance:(CTInsurance *)insurance {
    self.titleLabel.text = CTLocalizedString(CTRentalSummaryDamageRefund);
    self.detailLabel.text = [insurance.costAmount numberStringWithCurrencyCode];
}

- (void)updateWithString:(NSString *)string {
    self.titleLabel.text = string;
    self.detailLabel.text = @"";
}

@end
