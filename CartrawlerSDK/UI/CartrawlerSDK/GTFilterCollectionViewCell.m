//
//  GTFilterCollectionViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTFilterCollectionViewCell.h"
#import "CTLabel.h"

@interface GTFilterCollectionViewCell()

@property (nonatomic, weak) IBOutlet CTLabel *priceLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation GTFilterCollectionViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)setFilterType:(GTFilterType)filterType currency:(NSString *)currency price:(NSString *)price
{
    _filterType = filterType;
    
    NSString *filter = @"";
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CartrawlerResources" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    switch (filterType) {
        case GTFilterTypeService:
            self.imageView.image = [UIImage imageNamed:@"gt_car" inBundle:bundle compatibleWithTraitCollection:nil];
            filter = @"Private drivers";
            break;
            
        case GTFilterTypeShuttle:
            self.imageView.image = [UIImage imageNamed:@"gt_train" inBundle:bundle compatibleWithTraitCollection:nil];
            filter = @"Trains";
            break;
            
        default:
            break;
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@ From: %@ %@ ", filter, currency, price];
}

@end
