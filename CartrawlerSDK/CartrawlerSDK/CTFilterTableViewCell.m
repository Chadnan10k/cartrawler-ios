//
//  CTFilterTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTFilterTableViewCell.h"
#import "CTAppearance.h"

@interface CTFilterTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *checkmarkImageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic) BOOL cellEnabled;

@end

@implementation CTFilterTableViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setText:(NSString *)text
{
    self.label.font = [UIFont fontWithName:[CTAppearance instance].fontName size:self.textLabel.font.pointSize];
    self.label.text = text;
}

- (void)enableCheckmark:(BOOL)enableCheckmark
{
    _cellEnabled = enableCheckmark;
    
    if (self.cellEnabled) {
        self.checkmarkImageView.alpha = 1;
        _cellEnabled = YES;
    } else {
        self.checkmarkImageView.alpha = 0;
        _cellEnabled = NO;
    }
}

- (void)cellTapped
{
    if (self.cellEnabled) {
        self.checkmarkImageView.alpha = 0;
        _cellEnabled = NO;
    } else {
        self.checkmarkImageView.alpha = 1;
        _cellEnabled = YES;
    }
}

@end
