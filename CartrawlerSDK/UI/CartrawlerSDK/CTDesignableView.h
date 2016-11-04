//
//  CTDesignableView.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface CTDesignableView : UIView



@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable BOOL enableShadow;
@property (nonatomic) IBInspectable BOOL enableGradient;

@end
