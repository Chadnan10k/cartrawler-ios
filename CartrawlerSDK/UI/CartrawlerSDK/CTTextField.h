//
//  CTTextField.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerSDK.h"
#import "JVFloatLabeledTextField.h"

IB_DESIGNABLE
@interface CTTextField : JVFloatLabeledTextField

@property (nonatomic) IBInspectable BOOL enableShadow;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable UIColor *borderColor;

- (void)shakeAnimation;
- (BOOL)isValidEmail;

@end
