//
//  IncludedCollectionViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "IncludedCollectionViewCell.h"

@interface IncludedCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@end

@implementation IncludedCollectionViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)setDetails:(NSString *)details
{
    self.detailsLabel.text = details;
}

@end
