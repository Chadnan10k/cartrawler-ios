//
//  CTExtrasCarouselView.h
//  CartrawlerRental
//
//  Created by Alan on 11/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTExtrasCollectionView.h"
#import "CTExtraEquipment.h"

@class CTExtrasCarouselView;

/**
 Delegate which is notified when View All is selected
 */
@protocol CTExtrasCarouselViewDelegate

/**
 Implement this to be notified when View All is selected

 @param extrasView the extras view
 */
- (void)extrasViewDidTapViewAll:(CTExtrasCarouselView *)extrasView;

/**
 Implement this to be notified when extras are added

 @param extrasView the extras view
 */
- (void)extrasViewDidAddExtra:(CTExtrasCarouselView *)extrasView;

@end

/**
 Container view for a CTExtrasCollectionView with horizontal scrolling
 
 Includes button to view all extras
 */
@interface CTExtrasCarouselView : UIView

/**
 Delegate to be notified of view all selection
 */
@property (nonatomic, weak) id <CTExtrasCarouselViewDelegate> delegate;

/**
 Use this to update the extras

 @param extras an array of CTExtraEquipment objects
 */
- (void)updateWithExtras:(NSArray<CTExtraEquipment *> *)extras;

@end
