//
//  CTRatingView.h
//  CartrawlerSDK
//
//  Created by Alan on 24/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTLabel.h"

/**
 View which displays a title label and a rating label with rounded background
 */
@interface CTRatingView : UIView

@property (nonatomic, strong) CTLabel *titleLabel;

@property (nonatomic, strong) CTLabel *ratingLabel;

@end
