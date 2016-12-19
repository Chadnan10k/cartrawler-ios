//
//  SupplierRatingCollectionViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 22/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "SupplierRatingTableViewCell.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTAppearance.h>

@interface SupplierRatingTableViewCell()
@property (weak, nonatomic) IBOutlet CTLabel *rating;
@property (weak, nonatomic) IBOutlet CTLabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation SupplierRatingTableViewCell

- (void)setType:(NSString *)typeText ratingText:(NSString *)ratingText
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.containerView.layer.cornerRadius = [CTAppearance instance].buttonCornerRadius;
    self.typeLabel.text = typeText;
    self.rating.text = ratingText;
        
    self.containerView.backgroundColor = [CTAppearance instance].supplierDetailSecondaryColor;
    self.separatorView.backgroundColor = [CTAppearance instance].supplierDetailPrimaryColor;

}


@end
