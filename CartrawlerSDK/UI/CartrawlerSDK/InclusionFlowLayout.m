//
//  InclusionFlowLayout.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 05/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "InclusionFlowLayout.h"
#import "InclusionCollectionViewCell.h"

@implementation InclusionFlowLayout

+ (void)forceLinkerLoad_ {}

static CGFloat const ITEM_SPACING = 10.0f;

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGRect contentRect = {CGPointZero, self.collectionViewContentSize};
    
    NSArray *attributesForElementsInRect = [super layoutAttributesForElementsInRect:contentRect];
    NSMutableArray *newAttributesForElementsInRect = [[NSMutableArray alloc] initWithCapacity:attributesForElementsInRect.count];
    
    CGFloat leftMargin = self.sectionInset.left; //initalized to silence compiler, and actaully safer, but not planning to use.
    NSMutableDictionary *leftMarginDictionary = [[NSMutableDictionary alloc] init];
    
    for (UICollectionViewLayoutAttributes *attributes in attributesForElementsInRect) {
        UICollectionViewLayoutAttributes *attr = attributes.copy;
        
        CGFloat lastLeftMargin = [[leftMarginDictionary valueForKey:[[NSNumber numberWithFloat:attributes.frame.origin.y] stringValue]] floatValue];
        if (lastLeftMargin == 0) lastLeftMargin = leftMargin;
        
        CGRect newLeftAlignedFrame = attr.frame;
        newLeftAlignedFrame.origin.x = lastLeftMargin;
        attr.frame = newLeftAlignedFrame;
        
        lastLeftMargin += attr.frame.size.width + ITEM_SPACING;
        [leftMarginDictionary setObject:@(lastLeftMargin) forKey:[[NSNumber numberWithFloat:attributes.frame.origin.y] stringValue]];
        [newAttributesForElementsInRect addObject:attr];
    }
    
    return newAttributesForElementsInRect;
}

@end
