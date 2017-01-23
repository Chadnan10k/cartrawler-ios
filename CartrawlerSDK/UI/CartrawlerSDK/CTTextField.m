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

- (void)awakeFromNib
{
    [super awakeFromNib];
    if (self.enableShadow || [CTAppearance instance].enableTextFieldShadows) {
        self.layer.masksToBounds = NO;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.1;
        self.layer.shadowRadius = 10;
    }
    
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
    
    self.floatingLabelTextColor = [UIColor lightGrayColor];
    self.floatingLabelActiveTextColor = [CTAppearance instance].navigationBarColor;
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

    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self resignFirstResponder];
    [self endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    if (string.length > 0) {
//        self.layer.sublayerTransform = CATransform3DMakeTranslation(10, 3, 20);
//    } else {
//        self.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 20);
//    }
    
    return YES;
}

- (void)shakeAnimation
{
    [super shakeAnimation];
}

- (BOOL)isValidEmail
{
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:self.text];
}

- (BOOL)containsOnlyWhitespace
{
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [self.text stringByTrimmingCharactersInSet:charSet];
    if ([trimmedString isEqualToString:@""]) {
        // it's empty or contains only white spaces
        return YES;
    }
    return NO;
}


@end
