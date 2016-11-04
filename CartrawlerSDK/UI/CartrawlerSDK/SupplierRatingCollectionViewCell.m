//
//  SupplierRatingCollectionViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 22/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "SupplierRatingCollectionViewCell.h"
#import "CTLabel.h"

@interface SupplierRatingCollectionViewCell()
@property (weak, nonatomic) IBOutlet CTLabel *rating;
@property (weak, nonatomic) IBOutlet CTLabel *typeLabel;

@end

@implementation SupplierRatingCollectionViewCell



- (void)setType:(NSString *)typeText ratingText:(NSString *)ratingText
{
    self.typeLabel.text = typeText;
    self.rating.text = ratingText;
}

@end
