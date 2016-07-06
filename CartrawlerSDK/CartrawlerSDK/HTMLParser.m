//
//  HTMLParser.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "HTMLParser.h"
#import <UIKit/UIKit.h>

@implementation HTMLParser


+ (NSAttributedString *)htmlStringWithFontFamily:(NSString *)font pointSize:(float)pointSize text:(NSString *)text
{
    NSString *string = [text stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>",
                                                      font,
                                                      pointSize]];
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding]
                                                                          options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                    NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                               documentAttributes:nil
                                                                            error:nil];
    return attributedText;
}

@end
