//
//  CTListView.h
//  CartrawlerSDK
//
//  Created by Alan on 12/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 List view with a callback to indicate when rows are selected
 */
@interface CTListView : UIView

/**
 Initialise with views to be displayed in vertical rows

 @param rows the views to be added as rows
 @param handler a handler that is called when a row is selected
 @return a list view instance
 */
- (instancetype)initWithRows:(NSArray *)rows selectionHandler:(void (^)(NSInteger rowIndex, UIView *row))handler;

@end
