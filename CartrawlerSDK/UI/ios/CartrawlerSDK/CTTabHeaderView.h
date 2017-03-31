//
//  CTTabHeaderView.h
//  CartrawlerSDK
//
//  Created by Alan on 22/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTTabHeaderView;

/**
 A delegate which receives updates when tabs are tapped
 */
@protocol CTTabHeaderViewDelegate

/**
 This is called when a tab is tapped

 @param tabHeaderView the tab header view
 @param index the selected index
 */
- (void)tabHeaderView:(CTTabHeaderView *)tabHeaderView didSelectTabAtIndex:(NSInteger)index;

@end

/**
 A view which contains tab views and monitors user interaction with the tabs
 */
@interface CTTabHeaderView : UIView

/**
 Set this delegate to receive updates when a tab is tapped
 */
@property (nonatomic, weak) id <CTTabHeaderViewDelegate> delegate;

/**
 Custom initialiser

 @param titles the tab titles
 @param selectedIndex the tab index to be initially selected
 @return a tab header view
 */
- (instancetype)initWithTitles:(NSArray *)titles selectedIndex:(NSInteger)selectedIndex;

@end
