//
//  CTSearchView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 29/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartrawlerAPI/CartrawlerAPI.h"
#import "CartrawlerSDK/CTRentalSearch.h"

@protocol CTSearchViewDelegate <NSObject>

- (void)didTapPresentViewController:(UIViewController *)viewController;

@end

@interface CTSearchView : UIView

@property (nonatomic, weak) id<CTSearchViewDelegate> delegate;

@property (nonatomic, weak) CartrawlerAPI *cartrawlerAPI;
@property (nonatomic, weak) CTRentalSearch *search;

/**
 For analytics tagging, the view needs to know if it is editing a previous search
 */
@property (nonatomic, assign) BOOL editMode;

- (void)updateDisplayWithSearch:(CTRentalSearch *)search;

- (BOOL)validateSearch;

@end
