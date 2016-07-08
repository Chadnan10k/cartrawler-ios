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
@property (nonatomic) NSInteger itemAmount;

@end

@implementation OptionalExtraTableViewCell

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
    
    _itemAmount = 0;
    
    return self;
}

- (void)setData:(CTExtraEquipment *)extra
{
    self.itemTitleLabel.text = extra.equipDescription;
    self.itemPriceLabel.text = extra.chargeAmount;
}

- (IBAction)add:(id)sender {
    if (self.itemAmount < 4) {
        self.itemAmount++;
        [self updateAmountLabel];
    }
    
    if (self.itemAmount == 4) {
        self.addButton.backgroundColor = [UIColor lightGrayColor];
    } else {
        self.lessButton.backgroundColor = [UIColor darkGrayColor];
    }
}

- (IBAction)subtract:(id)sender {
    if (self.itemAmount > 0) {
        self.itemAmount--;
        [self updateAmountLabel];
    }
    
    if (self.itemAmount == 0) {
        self.lessButton.backgroundColor = [UIColor lightGrayColor];
    } else {
        self.addButton.backgroundColor = [UIColor darkGrayColor];
    }
}

- (void)updateAmountLabel
{
    self.amountLabel.text = [NSString stringWithFormat:@"%ld", (long)self.itemAmount];
}

@end
