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
@property (nonatomic, readonly) NSString *pickupLocationName;
@property (nonatomic, readonly) NSString *returnToSameLocation;
@property (nonatomic, readonly) NSString *returnToSameLocationCheckboxText;
@property (nonatomic, readonly) NSString *dropoffLocationName;
@property (nonatomic, readonly) NSString *rentalDates;
@property (nonatomic, readonly) NSString *pickupTime;
@property (nonatomic, readonly) NSString *dropoffTime;
@property (nonatomic, readonly) NSDate *defaultPickerTime;
@property (nonatomic, readonly) CTSearchFormTextField selectedTextField;
@property (nonatomic, readonly) BOOL dropoffLocationTextfieldDisplayed;
@property (nonatomic, readonly) BOOL driverAgeTextfieldDisplayed;
@property (nonatomic, readonly) BOOL textfieldInputViewDisplayed;
@property (nonatomic, readonly) NSString *driverAgeCheckboxText;
@property (nonatomic, readonly) NSString *displayedDriverAge;

@property (nonatomic, readonly) BOOL shakeAnimations;
@property (nonatomic, readonly) BOOL shakePickupLocation;
@property (nonatomic, readonly) BOOL shakeDropoffLocation;
@property (nonatomic, readonly) BOOL shakeSelectDates;
@property (nonatomic, readonly) BOOL shakePickupTime;
@property (nonatomic, readonly) BOOL shakeDropoffTime;
@property (nonatomic, readonly) BOOL shakeDriverAge;

@end
