//
//  CTExtrasListViewController.h
//  CartrawlerRental
//
//  Created by Alan on 11/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTExtraEquipment.h"

@protocol CTExtrasListDelegate <NSObject>

- (void)extrasDetailViewDidAddExtra;

@end
/**
 Container view controller for a CTExtrasCollectionView with vertical scrolling
 */
@interface CTExtrasListViewController : UIViewController

/**
 Pass in an array of CTExtraEquipment objects to update the CTExtrasCollectionView

 @param extras an array of CTExtraEquipment objects
 */
- (void)updateWithExtras:(NSArray<CTExtraEquipment *> *)extras;

@property (weak, nonatomic) id<CTExtrasListDelegate> delegate;

@end
