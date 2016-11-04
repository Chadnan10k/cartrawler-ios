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
#import "CTImageCache.h"

@interface GTFilterCollectionViewCell()

@property (nonatomic, weak) IBOutlet CTLabel *priceLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation GTFilterCollectionViewCell


{
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = NO;
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = [CTAppearance instance].viewBackgroundColor.CGColor;
    
}

- (void)setFilterType:(GTFilterType)filterType price:(NSString *)price imageURL:(NSURL *)url;
{
    _filterType = filterType;
    
    __weak typeof(self) weakSelf = self;
    [[CTImageCache sharedInstance]cachedImage:url completion:^(UIImage *image) {
        weakSelf.imageView.image = image;
    }];
    
    NSAttributedString *serviceType = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"From "]
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
        self.transform = CGAffineTransformMakeScale(1.02, 1.02);
        self.layer.borderColor = [CTAppearance instance].buttonColor.CGColor;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)deselect
{
    self.layer.borderColor = [CTAppearance instance].viewBackgroundColor.CGColor;
}

@end
