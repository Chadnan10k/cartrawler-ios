//
//  CTRentalScrollingLogic.m
//  CartrawlerRental
//
//  Created by Alan on 22/05/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTRentalScrollingLogic.h"

@interface CTRentalScrollingLogic ()
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat previousOffset;
@end

@implementation CTRentalScrollingLogic

- (instancetype)initWithTopViewHeight:(CGFloat)height {
    self = [super init];
    if (self) {
        _height = height;
    }
    return self;
}


- (CGFloat)offsetForDesiredOffset:(CGFloat)desiredOffset currentOffset:(CGFloat)currentOffset {
    CGFloat delta = self.previousOffset - desiredOffset;
    CGFloat newOffset = currentOffset + delta;
    newOffset = MIN(0, newOffset);
    newOffset = MAX(-self.height, newOffset);
    self.previousOffset = desiredOffset;
    return newOffset;
}

//- (CGFloat)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat verticalOffset = scrollView.contentOffset.y;
//    CGFloat delta = self.offset - verticalOffset;
//    CGFloat newOffset = self.totalViewTopConstraint.constant + delta;
//    newOffset = MIN(0, newOffset);
//    newOffset = MAX(-self.totalViewHeightConstraint.constant, newOffset);
//    
//    self.totalViewTopConstraint.constant = newOffset;
//    self.detailsViewOffset = verticalOffset;
//}

@end
