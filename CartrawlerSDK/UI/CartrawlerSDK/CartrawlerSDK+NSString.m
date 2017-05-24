//
//  CartrawlerSDK+NSString.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 11/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CartrawlerSDK+NSString.h"
#import "CTAppearance.h"

@implementation NSString (CartrawlerSDK)

+ (NSAttributedString *)attributedText:(NSString *)boldText boldColor:(UIColor *)boldColor boldSize:(CGFloat)boldSize regularText:(NSString *)regularText regularColor:(UIColor *)regularColor regularSize:(CGFloat)regularSize useSpace:(BOOL)useSpace
{
    return [self attributedText:boldText
                      boldColor:boldColor
                       boldSize:boldSize
                    regularText:regularText
                   regularColor:regularColor
                    regularSize:regularSize
                       useSpace:useSpace
                        reverse:NO].copy;
}

+ (NSAttributedString *)regularText:(NSString *)regularText
                       regularColor:(UIColor *)regularColor
                        regularSize:(CGFloat)regularSize
                     attributedText:(NSString *)boldText
                          boldColor:(UIColor *)boldColor
                           boldSize:(CGFloat)boldSize
                           useSpace:(BOOL)useSpace {
    
    return [self attributedText:boldText
                      boldColor:boldColor
                       boldSize:boldSize
                    regularText:regularText
                   regularColor:regularColor
                    regularSize:regularSize
                       useSpace:useSpace
                        reverse:YES].copy;
}

+ (NSMutableAttributedString *)attributedText:(NSString *)boldText boldColor:(UIColor *)boldColor boldSize:(CGFloat)boldSize regularText:(NSString *)regularText regularColor:(UIColor *)regularColor regularSize:(CGFloat)regularSize useSpace:(BOOL)useSpace reverse:(BOOL)reverse
{
    NSMutableAttributedString *mutableString = [NSMutableAttributedString new];
    
    NSAttributedString *boldString = [[NSAttributedString alloc] initWithString:boldText attributes:@{NSForegroundColorAttributeName : boldColor, NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].boldFontName size:boldSize]}];
    
    NSAttributedString *regString = [[NSAttributedString alloc] initWithString:regularText attributes:@{NSForegroundColorAttributeName : regularColor, NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:regularSize]}];
    
    NSAttributedString *firstString = reverse ? regString : boldString;
    [mutableString appendAttributedString:firstString];
    
    if (useSpace)
        mutableString = [self stringWithSpaceAtEnd:mutableString];
    
    NSAttributedString *secondString = reverse ? boldString : regString;
    [mutableString appendAttributedString:secondString];
    
    return mutableString;
}

+ (NSMutableAttributedString *)stringWithSpaceAtEnd:(NSMutableAttributedString *)mutableString {
    NSAttributedString *spaceString = [[NSAttributedString alloc] initWithString:@" "];
    [mutableString appendAttributedString:spaceString];
    return mutableString;
}

+ (NSAttributedString *)string:(NSAttributedString *)attributedString
               withInlineImage:(UIImage *)inlineImage
              inlineImageScale:(CGFloat)inlineImageScale {
    
    NSMutableAttributedString *mutableString = attributedString.mutableCopy;
    NSDictionary *attributes = [mutableString attributesAtIndex:mutableString.length-1 effectiveRange:nil];
    
    mutableString = [self stringWithSpaceAtEnd:mutableString];
    
    UIImage *imageMatchingFont = [inlineImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIFont *font = [attributes valueForKey:NSFontAttributeName];
    CGSize imageSizeMatchingFontSize = CGSizeMake(inlineImage.size.width * (font.capHeight / inlineImage.size.height), font.capHeight);
    
    CGFloat defaultScale = 1.4f;
    imageSizeMatchingFontSize = CGSizeMake(imageSizeMatchingFontSize.width * defaultScale,     imageSizeMatchingFontSize.height * defaultScale);
    imageSizeMatchingFontSize = CGSizeMake(imageSizeMatchingFontSize.width * inlineImageScale, imageSizeMatchingFontSize.height * inlineImageScale);
    imageSizeMatchingFontSize = CGSizeMake(ceilf(imageSizeMatchingFontSize.width), ceilf(imageSizeMatchingFontSize.height));
    
    UIColor *textColorForRange = [attributes valueForKey:NSForegroundColorAttributeName];
    
    UIGraphicsBeginImageContextWithOptions(imageSizeMatchingFontSize, NO, 0.0f);
    [textColorForRange set];
    [inlineImage drawInRect:CGRectMake(0 , 0, imageSizeMatchingFontSize.width, imageSizeMatchingFontSize.height)];
    imageMatchingFont = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSTextAttachment *textAttachment = [NSTextAttachment new];
    textAttachment.image = imageMatchingFont;
    NSAttributedString *imageString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [mutableString appendAttributedString:imageString];
    
    return mutableString.copy;
}

@end
