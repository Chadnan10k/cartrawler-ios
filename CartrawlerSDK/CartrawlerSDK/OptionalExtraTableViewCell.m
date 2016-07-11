//
//  OptionalExtraTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "OptionalExtraTableViewCell.h"
#import "CTLabel.h"

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

    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setMinimumFractionDigits:2];
    [f setCurrencyCode: extra.currencyCode];
    [f setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    self.itemTitleLabel.text = extra.equipDescription;
    self.itemPriceLabel.text = [f stringFromNumber: extra.chargeAmount];
    
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

@end
