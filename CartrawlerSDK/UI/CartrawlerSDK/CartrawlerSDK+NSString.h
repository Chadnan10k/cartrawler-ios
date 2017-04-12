//
//  CartrawlerSDK+NSString.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 11/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (CartrawlerSDK)

+ (NSAttributedString *)attributedText:(NSString *)boldText boldColor:(UIColor *)boldColor boldSize:(CGFloat)boldSize regularText:(NSString *)regularText regularColor:(UIColor *)regularColor regularSize:(CGFloat)regularSize useSpace:(BOOL)useSpace;

@end
