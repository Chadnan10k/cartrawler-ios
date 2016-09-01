//
//  OptionalExtraTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "OptionalExtraTableViewCell.h"
#import "CTLabel.h"
#import "NSNumberUtils.h"

@interface OptionalExtraTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *lessButton;
@property (weak, nonatomic) IBOutlet CTLabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *extraImageView;
@property (weak, nonatomic) IBOutlet CTLabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet CTLabel *itemPriceLabel;
//@property (nonatomic) NSInteger itemAmount;

@end

@implementation OptionalExtraTableViewCell
{
    CTExtraEquipment *_extra;
}

+ (void)forceLinkerLoad_
{
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.addButton.layer.cornerRadius = 5;
    self.addButton.layer.masksToBounds = YES;
    self.lessButton.layer.cornerRadius = 5;
    self.lessButton.layer.masksToBounds = YES;
    
    self.lessButton.backgroundColor = [UIColor lightGrayColor];
    self.addButton.backgroundColor = [UIColor darkGrayColor];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    _extra.qty = 0;
    
    return self;
}

- (void)setData:(CTExtraEquipment *)extra
{
    _extra = extra;

    self.itemTitleLabel.text = extra.equipDescription;
    self.itemPriceLabel.text = [NSNumberUtils numberStringWithCurrencyCode: extra.chargeAmount];
    
    self.extraImageView.image = [self imageForExtra:extra.equipType];
    
    [self updateAmountLabel];
}

- (IBAction)add:(id)sender {
    if (_extra.qty < 4) {
        _extra.qty++;
        [self updateAmountLabel];
    }
}

- (IBAction)subtract:(id)sender {
    if (_extra.qty > 0) {
        _extra.qty--;
        [self updateAmountLabel];
    }
}

- (void)updateAmountLabel
{
    
    if (_extra.qty == 0) {
        self.lessButton.backgroundColor = [UIColor lightGrayColor];
    } else {
        self.addButton.backgroundColor = [UIColor darkGrayColor];
    }

    if (_extra.qty == 4) {
        self.addButton.backgroundColor = [UIColor lightGrayColor];
        self.lessButton.backgroundColor = [UIColor darkGrayColor];
    } else {
        self.lessButton.backgroundColor = [UIColor darkGrayColor];
    }
    
    if (!_extra.qty) {
        self.addButton.backgroundColor = [UIColor darkGrayColor];
        self.lessButton.backgroundColor = [UIColor lightGrayColor];
    }
    
    self.amountLabel.text = [NSString stringWithFormat:@"%ld", (long)_extra.qty];
}

- (UIImage *)imageForExtra:(NSString *)extraId
{
    
    NSBundle* bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle]URLForResource:@"CartrawlerResources" withExtension:@"bundle"]];
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
        return [UIImage imageNamed:@"booster_seat" inBundle:bundle compatibleWithTraitCollection:nil];
    }
    
    if ([extraId isEqualToString:@"7"]) {
        //infant seat
        return [UIImage imageNamed:@"booster_seat" inBundle:bundle compatibleWithTraitCollection:nil];
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
        return [UIImage imageNamed:@"winter_package" inBundle:bundle compatibleWithTraitCollection:nil];
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
