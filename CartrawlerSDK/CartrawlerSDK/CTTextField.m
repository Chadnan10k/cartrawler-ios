//
//  CTTextField.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTTextField.h"
#import "CTAppearance.h"
#import <QuartzCore/QuartzCore.h>

@interface CTTextField() <UITextFieldDelegate>

@end

@implementation CTTextField

+ (void)forceLinkerLoad_
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    self.backgroundColor = [CTAppearance instance].textFieldBackgroundColor;
    self.layer.cornerRadius = [CTAppearance instance].textFieldCornerRadius;
    self.layer.masksToBounds = YES;
    self.tintColor = [CTAppearance instance].textFieldTint;
    self.font = [UIFont fontWithName:[CTAppearance instance].fontName size:self.font.pointSize];
    self.delegate = self;
    self.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);

    if (self.keyboardType == UIKeyboardTypeNumberPad || self.keyboardType == UIKeyboardTypePhonePad) {

        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:20.0]} forState:UIControlStateNormal];
        numberToolbar.barStyle = UIBarStyleDefault;
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneTapped)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], nil];
        
        [numberToolbar sizeToFit];
        self.inputAccessoryView = numberToolbar;
    }
    return self;
}

- (void)doneTapped
{
    [self resignFirstResponder];
    [self endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self resignFirstResponder];
    [self endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string length] > 0) {
        self.layer.sublayerTransform = CATransform3DMakeTranslation(10, 3, 20);
    } else {
        self.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 20);
    }
    
    return YES;
}

- (void)shakeAnimation
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1 options:0 animations:^{
        self.transform = CGAffineTransformMakeScale(1.02, 1.02);
        self.backgroundColor = [UIColor redColor];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.backgroundColor = [UIColor whiteColor];
        }];
    }];
}

@end
