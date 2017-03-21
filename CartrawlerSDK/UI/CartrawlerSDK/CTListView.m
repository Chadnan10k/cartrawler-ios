//
//  CTListView.m
//  CartrawlerSDK
//
//  Created by Alan on 12/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTListView.h"

@interface CTListView ()
@property (nonatomic, strong) NSArray *views;
@end

@implementation CTListView

- (instancetype)initWithViews:(NSArray *)views {
    self = [super init];
    if (self) {
        _views = views;
        
        [views enumerateObjectsUsingBlock:^(UIView *row, NSUInteger idx, BOOL * _Nonnull stop) {
            row.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:row];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[row]|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:NSDictionaryOfVariableBindings(row)]];
            if (idx == 0) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[row]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(row)]];
            } else {
                UIView *divider = [UIView new];
                divider.backgroundColor = [UIColor lightGrayColor];
                divider.translatesAutoresizingMaskIntoConstraints = NO;
                [self addSubview:divider];
                
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[divider]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(divider)]];
                UIView *previousRow = views[idx - 1];
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previousRow][divider(1)][row]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(previousRow, divider, row)]];
            }
            
            if (idx == (views.count - 1)) {
                NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:row
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:0];
                // This constraint may be over-ridden if the superview sets a specific height on the list view
                constraint.priority = 750;
                [self addConstraint:constraint];
            }
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectRow:)];
            [row addGestureRecognizer:tap];
        }];
    }
    
    return self;
}

- (void)didSelectRow:(UIGestureRecognizer *)tap {
    if (self.delegate) {
        [self.delegate listView:self didSelectView:tap.view atIndex:[self.views indexOfObject:tap.view]];
    }
}

@end
