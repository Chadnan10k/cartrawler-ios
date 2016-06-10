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

- (void)setDateLabel:(NSDate *)date indexPath:(NSIndexPath *)indexPath section:(NSNumber *)section;
{
    if (date != nil) {
        _date = date;
        _indexPath = indexPath;
        _section = section;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"d"];
        
        self.label.text = [df stringFromDate:self.date];
    } else {
        _indexPath = indexPath;
        _section = section;
    }
}

- (void)headSetSelected
{
    self.backgroundColor = [UIColor redColor];
}
- (void)midSetSelected
{
    if (![self.date isEqual:[NSNull null]]) {
        self.backgroundColor = [UIColor yellowColor];
    }
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
