//
//  CTCarouselFooterView.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 27/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCarouselFooterView.h"
#import <CartrawlerSDK/CTAppearance.h>

@implementation CTCarouselFooterView

- (instancetype)init
{
    self = [super init];
    
    UIView *thinSeperator = [UIView new];
    thinSeperator.translatesAutoresizingMaskIntoConstraints = NO;
    thinSeperator.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:thinSeperator];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view(0.5)]"
                                                                options:0
                                                                metrics:nil
                                                                  views:@{@"view" : thinSeperator}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|"
                                                                options:0
                                                                metrics:nil
                                                                  views:@{@"view" : thinSeperator}]];

    UILabel *priceLabel = [UILabel new];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:priceLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]-4-|"
                                                                options:0
                                                                metrics:nil
                                                                  views:@{@"view" : priceLabel}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|"
                                                                options:0
                                                                metrics:nil
                                                                  views:@{@"view" : priceLabel}]];
    
    UILabel *perDayLabel = [UILabel new];
    perDayLabel.textAlignment = NSTextAlignmentLeft;
    perDayLabel.translatesAutoresizingMaskIntoConstraints = NO;
    perDayLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:12];
    [self addSubview:perDayLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]-0-[priceLabel]"
                                                                options:0
                                                                metrics:nil
                                                                  views:@{@"view" : perDayLabel, @"priceLabel" : priceLabel}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|"
                                                                options:0
                                                                metrics:nil
                                                                  views:@{@"view" : perDayLabel}]];
    
    priceLabel.attributedText = [self attributedPriceString:@10.99 currency:@"EUR"];
    perDayLabel.text = @"per day";
    
    UILabel *fakeButton = [UILabel new];
    fakeButton.translatesAutoresizingMaskIntoConstraints = NO;
    fakeButton.backgroundColor = [UIColor clearColor];
    fakeButton.layer.borderWidth = 0.5;
    fakeButton.layer.borderColor = [CTAppearance instance].headerTitleColor.CGColor;
    fakeButton.layer.cornerRadius = 5;
    fakeButton.text = @"View";
    fakeButton.textColor = [CTAppearance instance].headerTitleColor;
    fakeButton.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:14];
    fakeButton.userInteractionEnabled = NO;
    fakeButton.textAlignment = NSTextAlignmentCenter;

    [self addSubview:fakeButton];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[button]-4-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"button" : fakeButton}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"button" : fakeButton}]];
    
    [fakeButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(0)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"button" : fakeButton}]];
    
    for (NSLayoutConstraint *c in fakeButton.constraints) {
        if (c.firstAttribute == NSLayoutAttributeWidth) {
            c.constant = fakeButton.intrinsicContentSize.width + 24;
        }
    }
    
    return self;
}

- (NSAttributedString *)attributedPriceString:(NSNumber *)price currency:(NSString *)currency
{
    NSMutableAttributedString *mutString = [NSMutableAttributedString new];
    
    NSAttributedString *priceStr = [[NSAttributedString alloc] initWithString:price.stringValue
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].boldFontName size:14],
                                                                                      NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    [mutString appendAttributedString:priceStr];
    
    NSAttributedString *newLine = [[NSAttributedString alloc] initWithString:@" "];
    [mutString appendAttributedString:newLine];
    
    NSAttributedString *currencyStr = [[NSAttributedString alloc] initWithString:currency
                                                                       attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].fontName size:12],
                                                                                    NSForegroundColorAttributeName: [UIColor grayColor]}];
    
    [mutString appendAttributedString:currencyStr];
    
    return mutString;
}


@end
