//
//  CTSearchState.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CartrawlerAPI/CTMatchedLocation.h>

typedef NS_ENUM(NSUInteger, CTSearchFormTextField) {
    CTSearchFormTextFieldNone,
    CTSearchFormSettingsButton,
    CTSearchFormTextFieldPickupLocation,
    CTSearchFormTextFieldDropoffLocation,
    CTSearchFormTextFieldSelectDates,
    CTSearchFormTextFieldPickupTime,
    CTSearchFormTextFieldDropoffTime,
    CTSearchFormTextFieldDriverAge,
};

typedef NS_ENUM(NSUInteger, CTSearchSearchSettings) {
    CTSearchSearchSettingsNone,
    CTSearchSearchSettingsCountry,
    CTSearchSearchSettingsLanguage,
    CTSearchSearchSettingsCurrency,
};

@interface CTSearchState : NSObject

@property (nonatomic) CTSearchFormTextField selectedTextField;

@property (nonatomic) CTSearchSearchSettings selectedSettings;

@property (nonatomic) NSString *searchBarText;

@property (nonatomic) CTMatchedLocation *selectedPickupLocation;

@property (nonatomic) CTMatchedLocation *selectedDropoffLocation;

@property (nonatomic) BOOL dropoffLocationRequired;

@property (nonatomic) NSDate *displayedPickupDate;

@property (nonatomic) NSDate *displayedDropoffDate;

@property (nonatomic) NSDate *selectedPickupDate;

@property (nonatomic) NSDate *selectedDropoffDate;

@property (nonatomic) NSDate *selectedPickupTime;

@property (nonatomic) NSDate *selectedDropoffTime;

@property (nonatomic) BOOL driverAgeRequired;

@property (nonatomic) NSString *displayedDriverAge;

@end
