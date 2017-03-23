//
//  CTTabContainerView.h
//  CartrawlerSDK
//
//  Created by Alan on 22/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 This view displays tabs across the top with the given titles and displays the relevant content views on tab selection
 */
@interface CTTabContainerView : UIView

/**
 Designated initialiser

 @param titles the titles to be displayed as tabs
 @param views the content views corresponding to the titles
 @param selectedIndex the index to be selected on first presentation
 @return a container view
 */
- (instancetype)initWithTabTitles:(NSArray *)titles views:(NSArray *)views selectedIndex:(NSInteger)selectedIndex;

@end
