//
//  CTSearchFormViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/20/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTSearchState.h"

@interface CTSearchFormViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) UIColor *backgroundColor;
@property (nonatomic, readonly) UIColor *driverAgeCursorColor;
@property (nonatomic, readonly) UIColor *nextButtonColor;
@property (nonatomic, readonly) UIColor *doneButtonColor;

@property (nonatomic, readonly) NSString *pickupLocationPlaceholder;
@property (nonatomic, readonly) NSString *returnToSameLocationText;
@property (nonatomic, readonly) NSString *dropoffLocationPlaceholder;
@property (nonatomic, readonly) NSString *datesPlaceholder;
@property (nonatomic, readonly) NSString *pickupTimePlaceholder;
@property (nonatomic, readonly) NSString *dropoffTimePlaceholder;
@property (nonatomic, readonly) NSString *driverAgePlaceholder;
@property (nonatomic, readonly) NSString *driverAgeText;

@property (nonatomic, readonly) NSString *pickupLocationName;
@property (nonatomic, readonly) NSString *returnToSameLocationCheckboxText;
@property (nonatomic, readonly) NSString *dropoffLocationName;
@property (nonatomic, readonly) NSString *rentalDates;
@property (nonatomic, readonly) NSString *pickupTime;
@property (nonatomic, readonly) NSString *dropoffTime;
@property (nonatomic, readonly) NSString *driverAgeCheckboxText;
@property (nonatomic, readonly) NSString *displayedDriverAge;

@property (nonatomic, readonly) CTSearchFormTextField selectedTextField;
@property (nonatomic, readonly) NSDate *defaultPickerTime;
@property (nonatomic, readonly) BOOL dropoffLocationTextfieldDisplayed;
@property (nonatomic, readonly) BOOL driverAgeTextfieldDisplayed;
@property (nonatomic, readonly) BOOL textfieldInputViewDisplayed;

@property (nonatomic, readonly) BOOL shakeAnimations;
@property (nonatomic, readonly) BOOL shakePickupLocation;
@property (nonatomic, readonly) BOOL shakeDropoffLocation;
@property (nonatomic, readonly) BOOL shakeSelectDates;
@property (nonatomic, readonly) BOOL shakePickupTime;
@property (nonatomic, readonly) BOOL shakeDropoffTime;
@property (nonatomic, readonly) BOOL shakeDriverAge;

@property (nonatomic, readonly) NSString *doneButtonTitle;
@property (nonatomic, readonly) NSString *nextButtonTitle;

@end
