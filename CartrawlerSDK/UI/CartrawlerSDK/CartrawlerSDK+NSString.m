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
    NSMutableAttributedString *mutableString = [NSMutableAttributedString new];
    
    NSAttributedString *boldString = [[NSAttributedString alloc] initWithString:boldText attributes:@{NSForegroundColorAttributeName : boldColor, NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].boldFontName size:boldSize]}];
    NSAttributedString *spaceString = [[NSAttributedString alloc] initWithString:@" "];
    NSAttributedString *regString = [[NSAttributedString alloc] initWithString:regularText attributes:@{NSForegroundColorAttributeName : regularColor, NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:regularSize]}];
    
    [mutableString appendAttributedString:boldString];
    
    if (useSpace)
        [mutableString appendAttributedString:spaceString];
    
    [mutableString appendAttributedString:regString];
    
    return mutableString;
}


@end
