//
//  CTFilterContainer.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTFilterTableView.h"

@interface CTFilterContainer : UIView

+ (void)forceLinkerLoad_;

- (void)setTableView:(CTFilterTableView *)tableView;
- (void)close;

@end
