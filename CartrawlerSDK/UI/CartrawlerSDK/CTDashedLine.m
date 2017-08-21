//
//  CTDashedLine.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 20/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTDashedLine.h"

@implementation CTDashedLine

- (void)layoutSubviews {
    [self updateLineStartingAt:self.bounds.origin andEndPoint:CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height)];
}

- (void)updateLineStartingAt:(CGPoint)beginPoint andEndPoint:(CGPoint)endPoint {
    if ([[[self layer] sublayers] objectAtIndex:0]) {
        self.layer.sublayers = nil;
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(0, self.frame.size.height/2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:[UIColor whiteColor].CGColor];
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:@[@(6.0f), @(6.0f)]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, beginPoint.x, beginPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [[self layer] addSublayer:shapeLayer];
}

@end
