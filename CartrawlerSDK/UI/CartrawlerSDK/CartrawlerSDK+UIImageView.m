//
//  CartrawlerSDK+UIImage.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 14/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerSDK+UIImageView.h"
#import "CTAppearance.h"

@implementation UIImageView (CartrawlerSDK)
    
- (void)applyTint
{
    UIImage *newImage = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIGraphicsBeginImageContextWithOptions(self.image.size, NO, newImage.scale);
    [[CTAppearance instance].iconTint set];
    [newImage drawInRect:CGRectMake(0, 0, self.image.size.width, newImage.size.height)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = newImage;
}

- (void)applyTintWithColor:(UIColor *)color
{
    UIImage *newImage = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIGraphicsBeginImageContextWithOptions(self.image.size, NO, newImage.scale);
    [color set];
    [newImage drawInRect:CGRectMake(0, 0, self.image.size.width, newImage.size.height)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = newImage;
}

@end
