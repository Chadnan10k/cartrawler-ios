//
//  CTDateCollectionViewCell.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 09/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTDateCollectionViewCell.h"
#import "CTLabel.h"

@interface CTDateCollectionViewCell()

@property (nonatomic, weak) IBOutlet CTLabel *label;

@end

@implementation CTDateCollectionViewCell

- (void)setDateLabel:(NSString *)dateString;
{
    self.label.text = dateString;
}

- (void)headSetSelected
{
    self.backgroundColor = [UIColor redColor];
}
- (void)midSetSelected
{
    self.backgroundColor = [UIColor yellowColor];
}
- (void)tailSetSelected
{
    self.backgroundColor = [UIColor greenColor];
}
- (void)deselect
{
    self.backgroundColor = [UIColor clearColor];
}

@end
