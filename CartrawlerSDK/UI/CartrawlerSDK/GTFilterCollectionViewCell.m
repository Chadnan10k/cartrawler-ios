//
//  GTFilterCollectionViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTFilterCollectionViewCell.h"
#import "CTLabel.h"
#import "CTAppearance.h"

@interface GTFilterCollectionViewCell()

@property (nonatomic, weak) IBOutlet CTLabel *priceLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation GTFilterCollectionViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)setFilterType:(GTFilterType)filterType price:(NSString *)price
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
    
    
    NSAttributedString *serviceType = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@ from\n", filter]
                                                              attributes:@{NSFontAttributeName:
                                                                               [UIFont fontWithName:[CTAppearance instance].fontName size:12]}];
    
    NSAttributedString *priceStr = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@", price]
                                                                 attributes:@{NSFontAttributeName:
                                                                                  [UIFont fontWithName:[CTAppearance instance].boldFontName size:16]}];
    
    
    
    NSMutableAttributedString *serviceStr = [[NSMutableAttributedString alloc] init];
    
    [serviceStr appendAttributedString:serviceType];
    [serviceStr appendAttributedString:priceStr];
    
    self.priceLabel.attributedText = serviceStr;
}

- (void)animate
{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:0 animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(1.4, 1.4);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }];
}
@end
