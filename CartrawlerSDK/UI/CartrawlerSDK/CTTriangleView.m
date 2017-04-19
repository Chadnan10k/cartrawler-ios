//
//  CTTriangleView.m
//  CartrawlerSDK
//
//  Created by Alan on 19/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTTriangleView.h"

@interface CTTriangleView ()
@property (nonatomic, strong) UIColor *color;
@end

@implementation CTTriangleView

- (instancetype)initWithColor:(UIColor *)color {
    self = [super init];
    if (self) {
        self.color = color;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat layerHeight = self.layer.frame.size.height;
    CGFloat layerWidth = self.layer.frame.size.width;
    
    UIBezierPath *bezierPath = [UIBezierPath new];
    
    [bezierPath moveToPoint:CGPointMake(0, layerHeight)];
    [bezierPath addLineToPoint:CGPointMake(layerWidth, layerHeight)];
    [bezierPath addLineToPoint:CGPointMake(layerWidth/2, 0)];
    [bezierPath addLineToPoint:CGPointMake(0, layerHeight)];
    [bezierPath closePath];
    
    [self.color setFill];
    [bezierPath fill];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer new];

    shapeLayer.path = bezierPath.CGPath;
    self.layer.mask = shapeLayer;
}

@end
