//
//  CTExtrasViewController.h
//  CartrawlerRental
//
//  Created by Alan on 11/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Container view controller for a CTExtrasCollectionView with vertical scrolling
 */
@interface CTExtrasViewController : UIViewController

/**
 Pass in an array of CTExtraEquipment objects to update the CTExtrasCollectionView

 @param extras an array of CTExtraEquipment objects
 @return a CTExtrasViewController instance
 */
- (instancetype)updateWithExtras:(NSArray *)extras;

@end
