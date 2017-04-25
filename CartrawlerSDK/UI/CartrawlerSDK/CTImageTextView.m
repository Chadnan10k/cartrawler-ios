//
//  CTImageTextView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 25/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTImageTextView.h"
#import "CTLayoutManager.h"
#import "CartrawlerSDK+UIView.h"
#import "CTLabel.h"

@interface CTImageTextView()

@property (nonatomic, strong) CTLayoutManager *layoutManager;
@property (nonatomic) NSUInteger index;

@end

@implementation CTImageTextView

- (instancetype)init
{
    self = [super init];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    _index = 0;
    _layoutManager = [CTLayoutManager layoutManagerWithContainer:self];
    return self;
}

- (void)insertImage:(UIImage *)image withText:(NSString *)text
{
    UIView *view = [self createImageTextView:image withText:text];
    
    [self.layoutManager insertViewAtIndex:self.index padding:UIEdgeInsetsMake(4, 0, 4, 0) view:view];
    self.index++;
}

- (UIView *)createImageTextView:(UIImage *)image withText:(NSString *)text
{
    UIView *view = [UIView new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view setHeightConstraint:@25 priority:@100];
    
    UIImageView *imageView = [UIImageView new];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    [imageView setHeightConstraint:@25 priority:@1000];
    [imageView setWidthConstraint:@25 priority:@1000];
    
    CTLabel *label = [[CTLabel alloc] init:15 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft boldFont:NO];
    label.text = text;
    label.numberOfLines = 0;
    [view addSubview:label];
    
    NSLayoutConstraint *imageYConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:view
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1
                                                                         constant:0];
    
    NSDictionary *viewDict = @{@"imageView" : imageView, @"label" : label};
    
    NSArray <NSLayoutConstraint *> *HConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[imageView]-8-[label]|"
                                                                                           options:0
                                                                                           metrics:nil
                                                                                             views:viewDict];
    
    NSArray <NSLayoutConstraint *> *VConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[label]-4-|"
                                                                                           options:0
                                                                                           metrics:nil
                                                                                             views:viewDict];
    
    [view addConstraint:imageYConstraint];
    [view addConstraints:HConstraints];
    [view addConstraints:VConstraints];

    return view;
}


@end
