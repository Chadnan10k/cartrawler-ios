//
//  CTExtrasCarouselView.h
//  CartrawlerRental
//
//  Created by Alan on 11/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTExtrasCollectionView.h"
#import <CartrawlerAPI/CTExtraEquipment.h>

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
 Designated Initialiser

 @param extras an array of CTExtraEquipment objects
 @return a CTExtrasCarouselView instance
 */
- (instancetype)initWithExtras:(NSArray<CTExtraEquipment *> *)extras;

@end
