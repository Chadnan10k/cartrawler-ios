//
//  CTTermAndCondition.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 19/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTTermAndCondition.h"

@implementation CTTermAndCondition

- (instancetype)initFromDictionary:(NSDictionary *)dict
{
    self = [super init];
    NSString *tempTitleText;
    NSMutableString *tempBodyText = [[NSMutableString alloc] init];
    
    tempTitleText = dict[@"@Title"];
    _titleNameId = dict[@"@TitleNameId"];
    
    if ([dict[@"Paragraph"] isKindOfClass:[NSArray class]])
    {
        NSMutableArray *tempArrayBodyText = [NSMutableArray arrayWithArray: dict[@"Paragraph"]];
        
        for (int x=0; x<tempArrayBodyText.count; x++)
        {
            tempBodyText = [[tempArrayBodyText componentsJoinedByString:@"\n\n"] mutableCopy];
        }
        
        _titleText = tempTitleText;
        _bodyText = tempBodyText;
    } else if ([dict[@"Paragraph"] isKindOfClass:[NSString class]]) {
        
        tempBodyText = dict[@"Paragraph"];
        
        _titleText = tempTitleText;
        _bodyText = tempBodyText;
        
    } else {
        _titleText = @"";
        _bodyText = @"";
        return nil;
    }
    
    return self;
}

@end
