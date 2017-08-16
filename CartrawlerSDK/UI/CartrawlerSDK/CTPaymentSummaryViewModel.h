//
//  CTPaymentSummaryViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 15/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTPaymentSummaryCellModel.h"

@interface CTPaymentSummaryViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) NSArray <CTPaymentSummaryCellModel *> *payAtDeskRowViewModels;
@property (nonatomic, readonly) NSArray <CTPaymentSummaryCellModel *> *payNowRowViewModels;
@property (nonatomic, readonly) NSString *total;
@end
