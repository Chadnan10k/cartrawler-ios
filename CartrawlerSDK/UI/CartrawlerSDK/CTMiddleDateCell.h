//
//  CTMiddleDateCell.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 09/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTDateCollectionViewCell.h"

@interface CTMiddleDateCell : NSObject

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSNumber *section;
@property (nonatomic, strong) CTDateCollectionViewCell *cell;



- (id)initWithCell:(CTDateCollectionViewCell *)cell section:(NSNumber *)section indexPath:(NSIndexPath *)indexPath;

@end
