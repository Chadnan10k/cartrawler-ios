//
//  CTPageSelectionCollectionViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 23/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPageSelectionCollectionViewCell.h"
#import <CartrawlerSDK/CTLabel.h>

@interface CTPageSelectionCollectionViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *typeLabel;

@end

@implementation CTPageSelectionCollectionViewCell



- (void)setText:(NSString *)text
{
    self.typeLabel.text = text;
}

- (void)animate
{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:0 animations:^{
        self.typeLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.typeLabel.transform = CGAffineTransformIdentity;
        }];
    }];
}

@end