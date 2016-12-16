//
//  CTPaymentLocationTableViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTRentalSearch.h"

@interface CTPaymentLocationTableViewCell : UITableViewCell

- (void)setData:(CTMatchedLocation *)location date:(NSDate *)date;

@end
