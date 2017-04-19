//
//  CTCountryPickerView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 19/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTCountryPickerView;

@protocol CTCountryPickerDelegate <NSObject>

- (void)didChangeCountrySelection:(NSString *)countryCode;

@end

@interface CTCountryPickerView : UIView

@property (nonatomic, weak) id <CTCountryPickerDelegate> delegate;

@end
