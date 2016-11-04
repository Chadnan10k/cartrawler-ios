//
//  CTPickerView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPickerView.h"

@interface CTPickerView() <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@property (nonatomic, strong) NSLayoutConstraint *leftConstraint;
@property (nonatomic, strong) NSLayoutConstraint *rightConstraint;
@property (nonatomic, strong) NSArray<CTInsuranceSelectorItem *> *data;
@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation CTPickerView


{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    
    self.backgroundColor = [UIColor whiteColor];
    
    return self;
}

- (void)presentInView:(UIView *)view data:(NSArray<CTInsuranceSelectorItem *> *)data
{
    _data = data;
    self.translatesAutoresizingMaskIntoConstraints = false;
    _parentView = view;
    [view addSubview:self];
    
    _topConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:view
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:0];
    
    _leftConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0];
    
    _rightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:view
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:0];
    [view addConstraints:@[self.topConstraint,
                                self.leftConstraint,
                                self.rightConstraint]
     ];
    
    _toolBar = [[UIToolbar alloc]initWithFrame:CGRectZero];
    self.toolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(removeFromView)];
    
    (self.toolBar).items = @[btn];
    [view addSubview:self.toolBar];
    
    self.toolBar.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint *toolbarTopConstraint = [NSLayoutConstraint constraintWithItem:self.toolBar
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1.0
                                                                                constant:-35];
    
    NSLayoutConstraint *toolbarLeftConstraint = [NSLayoutConstraint constraintWithItem:self.toolBar
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:view
                                                                             attribute:NSLayoutAttributeLeft
                                                                            multiplier:1.0
                                                                              constant:0];
    
    NSLayoutConstraint *toolbarRightConstraint = [NSLayoutConstraint constraintWithItem:self.toolBar
                                                                              attribute:NSLayoutAttributeRight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:view
                                                                              attribute:NSLayoutAttributeRight
                                                                             multiplier:1.0
                                                                               constant:0];
    
    NSLayoutConstraint *toolbarHeightConstraint = [NSLayoutConstraint constraintWithItem:self.toolBar
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeHeight
                                                                              multiplier:1.0
                                                                                constant:35];
    [self.superview addConstraints:@[toolbarTopConstraint,
                                     toolbarLeftConstraint,
                                     toolbarRightConstraint,
                                     toolbarHeightConstraint]];
    
    self.dataSource = self;
    self.delegate = self;
    self.isVisible = YES;

}

- (void)removeFromView
{
    [self removeFromSuperview];
    [self.parentView removeConstraints:@[self.topConstraint,
                                         self.leftConstraint,
                                         self.rightConstraint]];
    [self.toolBar removeFromSuperview];
    [self.toolBar removeConstraints:self.toolBar.constraints];
    
    self.isVisible = NO;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.data.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.data[row].name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.delegate && row != 0) {
        [self.pickerDelegate pickerViewDidSelectItem:self.data[row]];
    }
}

@end
