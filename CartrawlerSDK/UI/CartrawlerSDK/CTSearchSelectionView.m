//
//  CTSearchSelectionView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 29/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchSelectionView.h"
#import <CartrawlerSDK/CTLayoutManager.h>

@interface CTSearchSelectionView ()

@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation CTSearchSelectionView

- (instancetype)init
{
    self = [super init];
    
    _placeholderLabel = [UILabel new];
    self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _detailLabel = [UILabel new];
    self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.placeholderLabel.text = @"ddddd";
    self.detailLabel.text = @"aaaaaaa";

    [self layout];
    return self;
}

- (void)layout
{
    NSDictionary *viewDictionary = @{
                                     @"placeholderLabel" : self.placeholderLabel,
                                     @"detailLabel" : self.detailLabel
                                     };
    [self addSubview:self.placeholderLabel];
    [self addSubview:self.detailLabel];
    [CTLayoutManager pinView:self.placeholderLabel toSuperView:self];
    [CTLayoutManager pinView:self.detailLabel toSuperView:self];

}

- (void)setPlaceholder:(NSString *)placeholderText
{
    self.placeholderLabel.text = placeholderText;
}

- (void)setDetailText:(NSString *)detailText
{
    [self animate:(detailText && ![detailText isEqualToString:@""])];
    self.detailLabel.text = detailText;
}

- (void)animate:(BOOL)hideDetail
{
    
}

@end
