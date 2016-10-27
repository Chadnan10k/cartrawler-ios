//
//  CTInclusionTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 28/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInclusionTableViewCell.h"
#import "CTLabel.h"

@interface CTInclusionTableViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *inclusionLabel;

@end

@implementation CTInclusionTableViewCell

+ (void)forceLinkerLoad_ {}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

- (void)setLabelText:(NSString *)text
{
    self.inclusionLabel.text = text;
}

@end
