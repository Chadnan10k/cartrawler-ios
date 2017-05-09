//
//  CTInPathBanner.h
//  CartrawlerInPath
//
//  Created by Lee Maguire on 20/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTVehicle.h>

@interface CTUpSellBanner : UIView

typedef NS_ENUM(NSUInteger, CTUpSellBannerAlignment) {

    CTUpSellBannerAlignmentLeft = 0,

    CTUpSellBannerAlignmentRight
};

@property (nonatomic) CTUpSellBannerAlignment alignment;

- (void)addToSuperview:(UIView *)superview;
- (void)setIcon:(UIImage *)image backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor text:(NSString *)text;
- (void)setFromMerchandisingTag:(CTMerchandisingTag)merchandisingTag;

@end
