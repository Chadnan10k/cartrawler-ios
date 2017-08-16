//
//  CTPaymentSummaryCell.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 15/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTPaymentSummaryCell.h"
#import "CTPaymentSummaryCellModel.h"

@interface CTPaymentSummaryCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@end

@implementation CTPaymentSummaryCell

+ (Class)viewModelClass {
    return CTPaymentSummaryCellModel.class;
}

- (void)updateWithViewModel:(CTPaymentSummaryCellModel *)viewModel {
    self.title.text = viewModel.title;
    self.detail.text = viewModel.detail;
}

@end
