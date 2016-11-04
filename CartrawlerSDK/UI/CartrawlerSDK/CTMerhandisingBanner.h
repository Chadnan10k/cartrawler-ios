//
//  CTMerhandisingBanner.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 02/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTMerhandisingBanner : UIView



typedef enum CTMerhandisingBannerType : NSUInteger {
    CTMerhandisingBannerTypeBestSeller = 0,
    CTMerhandisingBannerTypeGreatValue,
    CTMerhandisingBannerTypeNone
}CTMerhandisingBannerType;

- (void)setBannerType:(CTMerhandisingBannerType)bannerType;

@end
