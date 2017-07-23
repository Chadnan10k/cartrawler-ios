//
//  CTSearchViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTAppState.h"
#import "CTSearchFormViewModel.h"
#import "CTSearchLocationsViewModel.h"
#import "CTSearchCalendarViewModel.h"

typedef NS_ENUM(NSUInteger, CTSearchContentView) {
    CTSearchContentViewNone,
    CTSearchContentViewSplash,
    CTSearchContentViewForm,
};

typedef NS_ENUM(NSUInteger, CTSearchSupplementaryView) {
    CTSearchSupplementaryViewNone,
    CTSearchSupplementaryViewSearchLocations,
    CTSearchSupplementaryViewCalendar,
    CTSearchSupplementaryViewTimePicker,
};

@interface CTSearchViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) CTSearchContentView contentView;
@property (nonatomic, readonly) CTSearchSupplementaryView supplementaryView;
@property (nonatomic, readonly) CTSearchFormViewModel *searchFormViewModel;
@property (nonatomic, readonly) CTSearchLocationsViewModel *searchLocationsViewModel;
@property (nonatomic, readonly) CTSearchCalendarViewModel *searchCalendarViewModel;
@property (nonatomic, readonly) NSDate *defaultPickerTime;

@end
