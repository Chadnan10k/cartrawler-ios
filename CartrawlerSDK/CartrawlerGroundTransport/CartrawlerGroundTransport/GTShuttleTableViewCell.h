//
//  GTShuttleTableViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 08/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTGroundShuttle.h>
#import "InclusionCollectionViewDataSource.h"

@interface GTShuttleTableViewCell : UITableViewCell



- (void)setShuttle:(CTGroundShuttle *)shuttle;

@end
