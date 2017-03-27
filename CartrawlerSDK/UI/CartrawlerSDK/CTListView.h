//
//  CTListView.h
//  CartrawlerSDK
//
//  Created by Alan on 12/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTListView;

/**
 Implement this delegate to receive callbacks from the list view
 */
@protocol CTListViewDelegate <NSObject>

/**
 Called when a list view row is selected

 @param listView the list view
 @param view the selected view
 @param index the index of the row
 */
- (void)listView:(CTListView *)listView didSelectView:(UIView *)view atIndex:(NSInteger)index;

@end

/**
 List view with a callback to indicate when rows are selected
 */
@interface CTListView : UIView

/**
 Set this property to receive notifications of list view selections
 */
@property (nonatomic, weak) id <CTListViewDelegate> delegate;

/**
 Initialise with views to be displayed in vertical rows

 @param views the views to be added as rows
 @param separatorColor the separatorColor
 @return a list view instance
 */
- (instancetype)initWithViews:(NSArray *)views separatorColor:(UIColor *)separatorColor;

@end
