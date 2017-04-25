//
//  CTPaymentSummaryExpandedTableViewCell.m
//  CartrawlerSDK
//
//  Created by Alan on 29/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTPaymentSummaryExpandedTableViewCell.h"
#import <CartrawlerSDK/CTAppearance.h>

@implementation CTPaymentSummaryExpandedTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.titleLabel = [[CTLabel alloc] init:16.0 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft boldFont:NO];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
        self.detailLabel = [[CTLabel alloc] init:16.0 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentRight boldFont:NO];
        self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.detailLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.detailLabel];
        
        NSDictionary *viewDictionary = @{@"titleLabel" : self.titleLabel, @"detailLabel" : self.detailLabel};
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]-[detailLabel]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewDictionary]];
        [self.detailLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewDictionary]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[detailLabel]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewDictionary]];
        
    }
    return self;
}

- (void)setUseBoldFont:(BOOL)useBoldFont {
    self.titleLabel.font = useBoldFont ? [UIFont fontWithName:[CTAppearance instance].boldFontName size:self.titleLabel.font.pointSize] : [UIFont fontWithName:[CTAppearance instance].fontName size:self.titleLabel.font.pointSize];
    self.detailLabel.useBoldFont = useBoldFont ? [UIFont fontWithName:[CTAppearance instance].boldFontName size:self.titleLabel.font.pointSize] : [UIFont fontWithName:[CTAppearance instance].fontName size:self.titleLabel.font.pointSize];
}

@end
