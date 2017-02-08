//
//  CTOptionalExtraTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTOptionalExtraTableViewCell.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import <CartrawlerSDK/CTStepper.h>
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTRentalSearch.h>

@interface CTOptionalExtraTableViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *amountLabel;
@property (weak, nonatomic) IBOutlet CTLabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet CTLabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (strong, nonatomic) CTExtraEquipment *extra;

@end

@implementation CTOptionalExtraTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    self.extra.qty = 0;
    
    return self;
}

- (void)setData:(CTExtraEquipment *)extra
{
    _extra = extra;

    self.itemTitleLabel.text = extra.equipDescription;
    self.itemPriceLabel.text = [extra.chargeAmount numberStringWithCurrencyCode];
    
    self.amountLabel.textColor = [CTAppearance instance].navigationBarColor;
    self.plusButton.tintColor = [CTAppearance instance].headerTitleColor;
    self.minusButton.tintColor = [CTAppearance instance].subheaderTitleColor;
    
    [self updateAmountLabel];
    [self setPricePerDay];
    [self updateButtons];
}

- (void)setPricePerDay
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:[CTRentalSearch instance].pickupDate
                                                          toDate:[CTRentalSearch instance].dropoffDate
                                                         options:0];
    
    self.itemPriceLabel.text = [NSString stringWithFormat:@"%@ %@",
                                [[NSNumber numberWithFloat:self.extra.chargeAmount.floatValue / ([components day] ?: 1 )] numberStringWithCurrencyCode], NSLocalizedString(@"per day", @"")];
}

- (IBAction)add:(id)sender {
    if (self.extra.qty < 4) {
        self.extra.qty++;
        [self updateAmountLabel];
    }
    
    [self updateButtons];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:0 animations:^{
        self.plusButton.transform = CGAffineTransformMakeScale(1.25, 1.25);
        self.amountLabel.transform = CGAffineTransformMakeScale(1.25, 1.25);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.plusButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.amountLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

- (IBAction)subtract:(id)sender {
    if (self.extra.qty > 0) {
        self.extra.qty--;
        [self updateAmountLabel];
    }
    
    [self updateButtons];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
        self.minusButton.transform = CGAffineTransformMakeScale(1.25, 1.25);
        self.amountLabel.transform = CGAffineTransformMakeScale(1.25, 1.25);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.minusButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.amountLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

- (void)updateButtons
{
    if (self.extra.qty == 0) {
        self.minusButton.tintColor = [CTAppearance instance].subheaderTitleColor;
    } else {
        self.minusButton.tintColor = [CTAppearance instance].headerTitleColor;
    }
    
    if (self.extra.qty == 4) {
        self.plusButton.tintColor = [CTAppearance instance].subheaderTitleColor;
    } else {
        self.plusButton.tintColor = [CTAppearance instance].headerTitleColor;
    }
}

- (void)updateAmountLabel
{
    self.amountLabel.text = [NSString stringWithFormat:@"%ld", (long)self.extra.qty];
}

- (UIImage *)imageForExtra:(NSString *)extraId
{
    
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    if ([extraId isEqualToString:@"3"]) {
        //luggage rack
        return [UIImage imageNamed:@"luggage_rack" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"9"]) {
        //booster seat
        return [UIImage imageNamed:@"booster_seat" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"8"]) {
        //toddler seat
        return [UIImage imageNamed:@"toddler_seat" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"7"]) {
        //infant seat
        return [UIImage imageNamed:@"infant_seat" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"13"]) {
        //gps
        return [UIImage imageNamed:@"gps" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"4"]) {
        //ski rack
        return [UIImage imageNamed:@"ski_rack" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"10"]) {
        //snow chains
        return [UIImage imageNamed:@"snow_chains" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"14"]) {
        //snow tyres
        return [UIImage imageNamed:@"snow_tyres" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"30"]) {
        //winter package
        return [UIImage imageNamed:@"aircon" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"34"]) {
        //navigational phone
        return [UIImage imageNamed:@"navigational_phone" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"52"]) {
        //toll tag
        return [UIImage imageNamed:@"toll_tag" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"55"]) {
        //wifi
        return [UIImage imageNamed:@"wifi" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"101.EQP"]) {
        //additional driver
        return [UIImage imageNamed:@"additional_driver" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"102.EQP"]) {
        //gps
        return [UIImage imageNamed:@"gps" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    return [UIImage imageNamed:@"generic_extra" inBundle:bundle compatibleWithTraitCollection:nil];
}

@end
