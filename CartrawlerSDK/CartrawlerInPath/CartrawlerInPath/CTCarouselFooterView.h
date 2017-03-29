//
//  CTCarouselFooterView.h
//  CartrawlerInPath
//
//  Created by Lee Maguire on 27/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTVehicle.h>

@protocol CTCarouselFooterDelegate <NSObject>

- (void)didTapFooterButton;

@end

@interface CTCarouselFooterView : UIView

@property (nonatomic, weak) id <CTCarouselFooterDelegate> delegate;

- (void)setVehicle:(CTVehicle *)vehicle
       buttonTitle:(NSString *)buttonTitle
     disableButton:(BOOL)disableButton
       perDayPrice:(BOOL)perDayPrice
        pickupDate:(NSDate *)pickupDate
       dropoffDate:(NSDate *)dropoffDate;

@end
