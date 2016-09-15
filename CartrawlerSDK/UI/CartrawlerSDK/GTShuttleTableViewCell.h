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

+ (void)forceLinkerLoad_;

- (void)setShuttle:(CTGroundShuttle *)shuttle;

@property (weak, nonatomic) IBOutlet UICollectionView *inclusionsCollectionView;
@property (nonatomic, strong) InclusionCollectionViewDataSource *inclusionDataSource;
@property (nonatomic, strong) NSLayoutConstraint *inclusionHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *inclusionsTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

@end
