//
//  CTSearchSelectionView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 29/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectionView.h"
#import <CartrawlerSDK/CTLayoutManager.h>

@interface CTSelectionView () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UITextField *detailTextField;

@property (nonatomic, strong) NSArray<NSLayoutConstraint *> *noDetailTextConstraints;
@property (nonatomic, strong) NSArray<NSLayoutConstraint *> *detailTextConstraints;

@end

@implementation CTSelectionView

- (instancetype)initWithPlaceholder:(NSString *)placeholderText
{
    self = [super init];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self style];
    [self addGestureRecognizer:[self gesture]];
    
    _placeholderLabel = [UILabel new];
    self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _detailTextField = [UITextField new];
    self.detailTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailTextField.delegate = self;
    
    self.placeholderLabel.text = placeholderText;
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.minimumScaleFactor = 0.5;
    self.placeholderLabel.adjustsFontSizeToFitWidth = YES;
    self.placeholderLabel.textColor = [UIColor darkGrayColor];
    
    [self layout];
    return self;
}

- (void)style
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.masksToBounds = YES;
}

- (void)layout
{
    [self addSubview:self.placeholderLabel];
    [self addSubview:self.detailTextField];
    
    [self generateNoDetailConstraints];
    [self generateDetailConstraints];

    [self hideDetail:YES];
}

- (void)setPlaceholder:(NSString *)placeholderText
{
    self.placeholderLabel.text = placeholderText;
}

- (void)setDetailText:(NSString *)detailText
{
    BOOL hideDetail = [detailText isEqualToString:@""];
    [self hideDetail:hideDetail];
    self.detailTextField.text = detailText;
    self.detailTextField.userInteractionEnabled = !self.useAsButton;
}

- (void)hideDetail:(BOOL)hideDetail
{
    if (hideDetail) {
        [self removeOldAndAddNewConstraints:self.noDetailTextConstraints];
    } else {
        [self removeOldAndAddNewConstraints:self.detailTextConstraints];
    }
}

- (void)removeOldAndAddNewConstraints:(NSArray <NSLayoutConstraint *> *)constraints
{
    [self removeConstraints:self.noDetailTextConstraints];
    [self removeConstraints:self.detailTextConstraints];
    [self addConstraints:constraints];
}

- (void)generateNoDetailConstraints
{
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:0
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1
                                                                constant:0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:0
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0];
    
    NSArray *widthItems = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view]-|"
                                            options:0
                                            metrics:nil
                                              views:@{@"view" : self.placeholderLabel}];
    
    NSMutableArray *constraintArray = [NSMutableArray new];
    [constraintArray addObjectsFromArray:widthItems];
    [constraintArray addObject:centerY];
    [constraintArray addObject:centerX];
    
    _noDetailTextConstraints = [constraintArray copy];
}

- (void)generateDetailConstraints
{
    NSDictionary *viewDict = @{@"detail" : self.detailTextField,
                               @"placeholder" : self.placeholderLabel};
    
    NSArray *detailHItems = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[detail]-|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewDict];
    
    NSArray *placeholderHItems = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[placeholder]-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewDict];
    
    NSArray *placeholderVItems = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[placeholder(15)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewDict];
    
    NSArray *detailVItems = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[placeholder]-16@750-[detail(20)]-8-|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewDict];
    
    NSMutableArray *constraintArray = [NSMutableArray new];
    [constraintArray addObjectsFromArray:detailHItems];
    [constraintArray addObjectsFromArray:detailVItems];
    [constraintArray addObjectsFromArray:placeholderHItems];
    [constraintArray addObjectsFromArray:placeholderVItems];
    
    _detailTextConstraints = [constraintArray copy];
}

- (UITapGestureRecognizer *)gesture
{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(viewTapped:)];
    return gestureRecognizer;
}

- (void)viewTapped:(id)sender
{
    if (!self.useAsButton) {
        [self hideDetail:NO];
        [self.detailTextField becomeFirstResponder];
    } else {
        if ([self.detailTextField.text isEqualToString:@""]) {
            [self hideDetail:YES];
        } else {
            [self hideDetail:NO];
        }
        if (self.delegate) {
            [self.delegate selectionViewWasTapped:self];
        }
    }
}

- (void)animate
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.6;
    animation.values = @[@(-20), @(20), @(-20), @(20), @(-10), @(10), @(-5), @(5), @(0)];
    [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    self.detailTextField.keyboardType = self.keyboardType;
    if (self.keyboardType) {
        UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
        [keyboardDoneButtonView sizeToFit];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStyleDone target:self
                                                                      action:@selector(doneClicked:)];
        [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
        self.detailTextField.inputAccessoryView = keyboardDoneButtonView;
    }
}

- (void)doneClicked:(id)sender
{
    [self endEditing:YES];
}

- (NSString *)textFieldText
{
    return self.detailTextField.text;
}

//MARK: UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.delegate) {
        [self.delegate selectionViewShouldBeginEditing:self];
    }
    [self hideDetail:NO];
    return !self.useAsButton;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(selectionViewDidEndEditing:)]) {
        [self.delegate selectionViewDidEndEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.regex) {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:self.regex
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                            options:0
                                                              range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0) {
            return NO;
        } else {
            if ([self.delegate respondsToSelector:@selector(selectionViewChangedCharacters:)]) {
                [self.delegate selectionViewChangedCharacters:self];
            }
            return YES;
        }
    }
    
    return YES;
}

@end
