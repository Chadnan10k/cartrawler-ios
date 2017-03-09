//
//  CTAlertView.m
//  CartrawlerSDK
//
//  Created by Alan on 09/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAlertView.h"
#import "CTAlertTextView.h"

@interface CTAlertView ()
@property (nonatomic) UIView *circleView;
@property (nonatomic) UIView *contentViewContainerView;
@property (nonatomic) UIView *actionButtonContainerView;
@end

@implementation CTAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        UIView *alertBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        [alertBackgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:alertBackgroundView];
        
        UIView *alertContainerView = [[UIView alloc] initWithFrame:CGRectZero];
        [alertContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
        alertContainerView.backgroundColor = [UIColor colorWithWhite:0.97f alpha:1.0f];
        alertContainerView.layer.cornerRadius = 6.0f;
        alertContainerView.clipsToBounds = YES;
        [alertContainerView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [alertBackgroundView addSubview:alertContainerView];
        
        _circleView = [[UIView alloc] initWithFrame:CGRectZero];
        _circleView.translatesAutoresizingMaskIntoConstraints = NO;
        _circleView.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:244.0/255.0 blue:253.0/255.0 alpha:1.0];
        _circleView.layer.masksToBounds = YES;
        _circleView.layer.borderColor = [UIColor colorWithRed:42.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0].CGColor;
        _circleView.layer.borderWidth = 2.0;
        [alertBackgroundView addSubview:_circleView];
        
        _iconView = [UIImageView new];
        _iconView.translatesAutoresizingMaskIntoConstraints = NO;
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        _iconView.image = [UIImage imageNamed:@"pencil" inBundle:bundle compatibleWithTraitCollection:nil];
        [_circleView addSubview:_iconView];
        
        UIView *decorationView = [[UIView alloc] initWithFrame:CGRectZero];
        decorationView.translatesAutoresizingMaskIntoConstraints = NO;
        decorationView.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
        [alertContainerView addSubview:decorationView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:34.0/255.0 green:76.0/255.0 blue:156.0/255.0 alpha:1.0];
        [alertContainerView addSubview:_titleLabel];
        
        _messageTextView = [[CTAlertTextView alloc] initWithFrame:CGRectZero];
        _messageTextView.translatesAutoresizingMaskIntoConstraints = NO;
        _messageTextView.backgroundColor = [UIColor clearColor];
        [_messageTextView setContentHuggingPriority:0 forAxis:UILayoutConstraintAxisVertical];
        [_messageTextView setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
        _messageTextView.editable = NO;
        _messageTextView.textAlignment = NSTextAlignmentCenter;
        _messageTextView.textColor = [UIColor darkGrayColor];
        _messageTextView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        [alertContainerView addSubview:_messageTextView];
        
        _contentViewContainerView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentViewContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        [_contentViewContainerView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [alertContainerView addSubview:_contentViewContainerView];
        
        _actionButtonContainerView = [[UIView alloc] initWithFrame:CGRectZero];
        _actionButtonContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        [_actionButtonContainerView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [alertContainerView addSubview:_actionButtonContainerView];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:alertBackgroundView
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:0.0f]];
        
        CGFloat alertBackgroundViewWidth = MIN(CGRectGetWidth([UIApplication sharedApplication].keyWindow.bounds),
                                               CGRectGetHeight([UIApplication sharedApplication].keyWindow.bounds)) * 0.8f;
        
        NSLayoutConstraint *alertBackgroundWidthConstraint = [NSLayoutConstraint constraintWithItem:alertBackgroundView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:0.0f
                                                                        constant:alertBackgroundViewWidth];
        
        [self addConstraint:alertBackgroundWidthConstraint];
        
        NSLayoutConstraint *backgroundViewVerticalCenteringConstraint = [NSLayoutConstraint constraintWithItem:alertBackgroundView
                                                                                  attribute:NSLayoutAttributeCenterY
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self
                                                                                  attribute:NSLayoutAttributeCenterY
                                                                                 multiplier:1.0f
                                                                                   constant:0.0f];
        
        [self addConstraint:backgroundViewVerticalCenteringConstraint];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:alertBackgroundView
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationLessThanOrEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:0.9f
                                                          constant:0.0f]];
        
        
        [alertBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[_circleView(60)]-(>=20)-|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(_circleView)]];
        [alertBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:_circleView
                                                                            attribute:NSLayoutAttributeCenterX
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:alertBackgroundView
                                                                            attribute:NSLayoutAttributeCenterX
                                                                           multiplier:1.f constant:0.f]];
        [_circleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_iconView]-15-|"
                                                                                        options:0
                                                                                        metrics:nil
                                                                                          views:NSDictionaryOfVariableBindings(_iconView)]];
        [_circleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_iconView]-15-|"
                                                                                        options:0
                                                                                        metrics:nil
                                                                                          views:NSDictionaryOfVariableBindings(_iconView)]];
        
        [alertBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_circleView(60)]"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(_circleView)]];
        
        [alertBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[alertContainerView]|"
                                                                                        options:0
                                                                                        metrics:nil
                                                                                          views:NSDictionaryOfVariableBindings(alertContainerView)]];
        [alertBackgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[alertContainerView]|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(alertContainerView)]];
        
        [alertContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[decorationView]|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(decorationView)]];
        
        [alertContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(_titleLabel)]];
        
        [alertContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_messageTextView]-|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(_messageTextView)]];
        
        [alertContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentViewContainerView]|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(_contentViewContainerView)]];
        
        [alertContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_actionButtonContainerView]|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(_actionButtonContainerView)]];
        
        [alertContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[decorationView(40)]-10-[_titleLabel]-10-[_messageTextView][_contentViewContainerView][_actionButtonContainerView(==10@500)]|"
                                                                                         options:0
                                                                                         metrics:nil
                                                                                           views:NSDictionaryOfVariableBindings(decorationView,
                                                                                                                                _titleLabel,
                                                                                                                                _messageTextView,
                                                                                                                                _contentViewContainerView,
                                                                                                                                _actionButtonContainerView)]];
        }
    
    return self;
}

// MARK: Touch Handling

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // Allows touches through to dimming view beneath
    for (UIView *subview in self.subviews) {
        if ([subview hitTest:[self convertPoint:point toView:subview] withEvent:event]) {
            return YES;
        }
    }
    return NO;
}

// MARK: Content View

- (void)setContentView:(UIView *)contentView {
    [self.contentView removeFromSuperview];
    
    _contentView = contentView;
    
    if (contentView) {
        [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentViewContainerView addSubview:self.contentView];
        
        [self.contentViewContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|"
                                                                                              options:0
                                                                                              metrics:nil
                                                                                                views:NSDictionaryOfVariableBindings(_contentView)]];
        
        [self.contentViewContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_contentView]-2-|"
                                                                                              options:0
                                                                                              metrics:nil
                                                                                                views:NSDictionaryOfVariableBindings(_contentView)]];
    }
}

// MARK: Action Buttons

- (void)setActionButtons:(NSArray *)actionButtons {
    if (actionButtons.count == 0) {
        return;
    }
    
    for (UIView *subview in self.actionButtonContainerView.subviews) {
        [subview removeFromSuperview];
    }
    
    _actionButtons = actionButtons;
    
    if ([actionButtons count] == 2) {
        UIButton *firstButton = actionButtons[0];
        UIButton *lastButton = actionButtons[1];
        
        [self.actionButtonContainerView addSubview:firstButton];
        [self.actionButtonContainerView addSubview:lastButton];
        
        UIView *topBorderLine = [UIView new];
        topBorderLine.translatesAutoresizingMaskIntoConstraints = NO;
        topBorderLine.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
        [self.actionButtonContainerView addSubview:topBorderLine];
        
        UIView *dividerLine = [UIView new];
        dividerLine.translatesAutoresizingMaskIntoConstraints = NO;
        dividerLine.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:147.0/255.0 blue:232.0/255.0 alpha:1.0];
        [self.actionButtonContainerView addSubview:dividerLine];
        
        [self.actionButtonContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[topBorderLine]|"
                                                                                               options:0
                                                                                               metrics:nil
                                                                                                 views:NSDictionaryOfVariableBindings(topBorderLine)]];
        
        [self.actionButtonContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[topBorderLine(1)]"
                                                                                               options:0
                                                                                               metrics:nil
                                                                                                 views:NSDictionaryOfVariableBindings(topBorderLine)]];
        
        [self.actionButtonContainerView addConstraint:[NSLayoutConstraint constraintWithItem:firstButton
                                                                                   attribute:NSLayoutAttributeWidth
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:lastButton
                                                                                   attribute:NSLayoutAttributeWidth
                                                                                  multiplier:1.0f
                                                                                    constant:0.0f]];
        
        [self.actionButtonContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[firstButton]-[lastButton]-|"
                                                                                               options:NSLayoutFormatAlignAllCenterY
                                                                                               metrics:nil
                                                                                                 views:NSDictionaryOfVariableBindings(firstButton, lastButton)]];
        
        [self.actionButtonContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[firstButton(40)]|"
                                                                                               options:0
                                                                                               metrics:nil
                                                                                                 views:NSDictionaryOfVariableBindings(_contentViewContainerView, firstButton)]];
        
        [self.actionButtonContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastButton(40)]"
                                                                                               options:0
                                                                                               metrics:nil
                                                                                                 views:NSDictionaryOfVariableBindings(lastButton)]];
        [self.actionButtonContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[dividerLine]|"
                                                                                               options:0
                                                                                               metrics:nil
                                                                                                 views:NSDictionaryOfVariableBindings(dividerLine)]];
        [self.actionButtonContainerView addConstraint:[NSLayoutConstraint constraintWithItem:dividerLine
                                                                                   attribute:NSLayoutAttributeWidth
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1.0
                                                                                    constant:1.0]];
        [self.actionButtonContainerView addConstraint:[NSLayoutConstraint constraintWithItem:dividerLine
                                                                                   attribute:NSLayoutAttributeCenterX
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.actionButtonContainerView
                                                                                   attribute:NSLayoutAttributeCenterX
                                                                                  multiplier:1.0
                                                                                    constant:0]];
    } else {
        for (int i = 0; i < [actionButtons count]; i++) {
            UIButton *actionButton = actionButtons[i];
            
            [self.actionButtonContainerView addSubview:actionButton];
            
            [self.actionButtonContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[actionButton]-|"
                                                                                                   options:0
                                                                                                   metrics:nil
                                                                                                     views:NSDictionaryOfVariableBindings(actionButton)]];
            
            [self.actionButtonContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[actionButton(40)]"
                                                                                                   options:0
                                                                                                   metrics:nil
                                                                                                     views:NSDictionaryOfVariableBindings(actionButton)]];
            
            if (i == 0) {
                [self.actionButtonContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[actionButton]"
                                                                                                       options:0
                                                                                                       metrics:nil
                                                                                                         views:NSDictionaryOfVariableBindings(_contentViewContainerView, actionButton)]];
            } else {
                UIButton *previousButton = actionButtons[i - 1];
                
                [self.actionButtonContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previousButton]-[actionButton]"
                                                                                                       options:0
                                                                                                       metrics:nil
                                                                                                         views:NSDictionaryOfVariableBindings(previousButton, actionButton)]];
            }
            
            if (i == ([actionButtons count] - 1)) {
                [self.actionButtonContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[actionButton]|"
                                                                                                       options:0
                                                                                                       metrics:nil
                                                                                                         views:NSDictionaryOfVariableBindings(actionButton)]];
            }
        }
    }
}

// MARK: Image Rounding

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutIfNeeded];
    self.circleView.layer.cornerRadius = self.circleView.frame.size.width / 2;
}

@end
