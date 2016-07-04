//
//  ExpandingInfoView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ExpandingInfoView.h"
#import <QuartzCore/QuartzCore.h>
@interface ExpandingInfoView()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ExpandingInfoView {
    BOOL expanded;
}

+ (void)forceLinkerLoad_ {}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.masksToBounds = YES;
    return self;
}

- (void)setTitle:(NSString *)title andImage:(UIImage *)image
{
    self.textView.alpha = 0;
    
    [self.textView scrollRangeToVisible:NSMakeRange(0, 0)];
    self.heightConstraint.constant = 50;
    [self layoutIfNeeded];
    expanded = NO;
}

- (IBAction)sizeViewTapped:(id)sender
{
    if (!expanded) {
        self.heightConstraint.constant = 300;

        [UIView animateWithDuration:0.3 animations:^{
            self.textView.alpha = 1;
            [self setNeedsUpdateConstraints];
            [self layoutIfNeeded];
        }];
        expanded = YES;

    } else {
        self.heightConstraint.constant = 50;
        self.textView.alpha = 0;

        [UIView animateWithDuration:0.3 animations:^{
            [self setNeedsUpdateConstraints];
            [self layoutIfNeeded];
        }];
        expanded = NO;
    }
}


@end
