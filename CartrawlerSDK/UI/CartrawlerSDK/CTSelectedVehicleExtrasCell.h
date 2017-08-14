//
//  CTSelectedVehicleExtrasCell.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTViewControllerProtocol.h"
#import "CTSelectedVehicleExtrasCellModel.h"

@interface CTSelectedVehicleExtrasCell : UICollectionViewCell <CTViewControllerProtocol>

- (void)updateWithViewModel:(CTSelectedVehicleExtrasCellModel *)viewModel animated:(BOOL)animated;

@end
