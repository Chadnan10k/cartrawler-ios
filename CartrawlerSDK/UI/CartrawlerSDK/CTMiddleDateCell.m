//
//  CTMiddleDateCell.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 09/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTMiddleDateCell.h"

@implementation CTMiddleDateCell

+ (void)forceLinkerLoad_
{
    
}

- (id)initWithCell:(CTDateCollectionViewCell *)cell section:(NSNumber *)section indexPath:(NSIndexPath *)indexPath
{
    self = [super init];
    
    _cell = cell;
    _section = section;
    _indexPath = indexPath;
    
    return self;
}

@end
