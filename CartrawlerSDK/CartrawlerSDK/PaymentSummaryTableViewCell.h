//
//  PaymentSummaryTableViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 11/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentSummaryTableViewCell : UITableViewCell

+ (void)forceLinkerLoad_;

- (void)setDetails:(NSString *)detail price:(NSString *)price;
- (void)setDetailsItalic:(NSString *)detail;

@end
