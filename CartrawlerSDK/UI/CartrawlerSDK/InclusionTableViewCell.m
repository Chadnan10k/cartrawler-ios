//
//  InclusionCollectionViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 02/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "InclusionTableViewCell.h"

@interface InclusionTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *inclusionLabel;

@end

@implementation InclusionTableViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)setText:(NSString *)text
{
    self.inclusionLabel.text = text;
}

@end
