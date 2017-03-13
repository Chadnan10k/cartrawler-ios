//
//  CTButton.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 07/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CTButton : UIButton

@property (nonatomic, strong) IBInspectable UIColor *overrideBackgroundColor;
@property (nonatomic, strong) IBInspectable UIColor *overrideTextColor;
@property (nonatomic) IBInspectable CGFloat overrideCornerRadius;
@property (nonatomic) IBInspectable BOOL disableShadow;
@property (nonatomic) IBInspectable BOOL useBoldFont;
@property (nonatomic) IBInspectable BOOL transparent;

- (void)shake;


/**
 Convienience Initialiser

 @param backgroundColor The background color of the button, nullable -> defaults to CTAppearance value if null
 @param fontColor The Font color of the button, nullable -> defaults to CTAppearance value if null
 @param boldFont Is the font bold or regular?
 @param borderColor The font border color, nullable -> defaults to CTAppearance value if null
 @return CTButton
 */
- (instancetype)init:(nullable UIColor *)backgroundColor
           fontColor:(nullable UIColor *)fontColor
            boldFont:(BOOL)boldFont
         borderColor:(nullable UIColor *)borderColor;

@end
