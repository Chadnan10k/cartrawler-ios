//
//  CTHTMLParser.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHTMLParser : NSObject

+ (NSAttributedString *)htmlStringWithFontFamily:(NSString *)font
                                       pointSize:(float)pointSize
                                            text:(NSString *)text
                                   boldFontColor:(NSString *)color
                                       fontColor:(NSString *)fontColor;

@end
