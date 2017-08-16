//
//  CTPaymentSummaryCellModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 15/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTPaymentSummaryCellModel.h"

@implementation CTPaymentSummaryCellModel

+ (instancetype)viewModelForState:(id)state {
    return [CTPaymentSummaryCellModel new];
}

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail {
    self = [super init];
    if (self) {
        _title = title;
        _detail = detail;
    }
    return self;
}

@end
