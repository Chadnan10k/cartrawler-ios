//
//  GTServiceTableViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 14/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTGroundService.h>
#import <CartrawlerAPI/CTGroundShuttle.h>
@interface GTServiceTableViewCell : UITableViewCell

+ (void)forceLinkerLoad_;

- (void)setService:(CTGroundService *)service;
- (void)setShuttle:(CTGroundShuttle *)shuttle;

@property (weak, nonatomic) IBOutlet UICollectionView *inclusionsCollectionView;

@end
