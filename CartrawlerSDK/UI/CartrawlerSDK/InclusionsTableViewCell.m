//
//  InclusionsTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "InclusionsTableViewCell.h"
#import "CTLabel.h"

@interface InclusionsTableViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *typeLabel;

@end

@implementation InclusionsTableViewCell

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

- (void)setText:(NSString *)text
{
    self.typeLabel.text = text;
}

@end
