//
//  CTSearchView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 29/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CTSearchViewDelegate <NSObject>

- (void)didTapPresentLocationSearch;

@end

@interface CTSearchView : UIView

@property (nonatomic, weak) id<CTSearchViewDelegate> delegate;

- (void)updateDisplayWithSearch:(NSObject *)search;

@end
