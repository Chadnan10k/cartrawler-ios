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

/**
 Returns string with regular text attributes concatenated with string with bold attributes

 @param regularText the regular text
 @param regularColor the regular text color
 @param regularSize the regular text size
 @param boldText the bold text
 @param boldColor the bold text color
 @param boldSize the bold text size
 @param useSpace add optional space between the strings
 @return an attributed string
 */
+ (NSAttributedString *)regularText:(NSString *)regularText
                       regularColor:(UIColor *)regularColor
                        regularSize:(CGFloat)regularSize
                     attributedText:(NSString *)boldText
                          boldColor:(UIColor *)boldColor
                           boldSize:(CGFloat)boldSize
                           useSpace:(BOOL)useSpace;

/**
 Inserts an image inline at the end of an attributed string

 @param attributedString the attributed string
 @param inlineImage the image
 @param inlineImageScale the desired scale
 @return an attributed string
 */
+ (NSAttributedString *)string:(NSAttributedString *)attributedString
               withInlineImage:(UIImage *)inlineImage
              inlineImageScale:(CGFloat)inlineImageScale;

@end
