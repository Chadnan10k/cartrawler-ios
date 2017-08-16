//
//  CTPaymentSummaryCellModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 15/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"

@interface CTPaymentSummaryCellModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *detail;

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail;
@end
