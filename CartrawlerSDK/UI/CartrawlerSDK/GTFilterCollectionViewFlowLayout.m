//
//  GTFilterCollectionViewFlowLayout.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTFilterCollectionViewFlowLayout.h"

@implementation GTFilterCollectionViewFlowLayout

+ (void)forceLinkerLoad_ {}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        NSInteger itemCount = [self.collectionView.dataSource collectionView:self.collectionView
                                                      numberOfItemsInSection:attribute.indexPath.section];
        if (itemCount % 2 == 1 && attribute.indexPath.item == itemCount - 1) {
            CGRect originalFrame = attribute.frame;
            attribute.frame = CGRectMake(self.collectionView.bounds.size.width/2-originalFrame.size.width/2,
                                         originalFrame.origin.y,
                                         originalFrame.size.width,
                                         originalFrame.size.height);
        }
    }
    
    return attributes;
}

@end
