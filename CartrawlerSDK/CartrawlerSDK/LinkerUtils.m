//
//  LinkerUtils.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 17/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "LinkerUtils.h"
#import "VehicleSelectionViewController.h"
#import "SearchDetailsViewController.h"
#import "CTButton.h"
#import "JVFloatLabeledTextField.h"
#import "NSStringUtils.h"
#import "CTCheckbox.h"
#import "CTLabel.h"
#import "LocaleUtils.h"
#import "CTImageCache.h"
#import "CTPlaceholderView.h"
#import "DateUtils.h"
#import "StepOneViewController.h"
#import "StepTwoViewController.h"
#import "CTTimePickerView.h"
#import "LocationSearchViewController.h"
#import "LocationSearchDataSource.h"
#import "CTCalendarViewController.h"
#import "CTCalendarView.h"
#import "CTCalendarTableViewCell.h"
#import "CTDateCollectionViewCell.h"
#import "CalendarLogicController.h"
#import "CTMiddleDateCell.h"
#import "CTVehicleSelectionView.h"
#import "VehicleTableViewCell.h"
#import "CTNavigationBar.h"
#import "CTNavigationItem.h"
#import "CTNavigationController.h"
#import "CTView.h"
#import "CTTextField.h"
#import "LocationSearchTableViewCell.h"

@implementation LinkerUtils

+ (void)loadFiles
{
    [JVFloatLabeledTextField forceLinkerLoad_];
    [StepOneViewController forceLinkerLoad_];
    [StepTwoViewController forceLinkerLoad_];
    [SearchDetailsViewController forceLinkerLoad_];
    [CTButton forceLinkerLoad_];
    [VehicleSelectionViewController forceLinkerLoad_];
    [CTCheckbox forceLinkerLoad_];
    [CTLabel forceLinkerLoad_];
    [LocaleUtils forceLinkerLoad_];
    [CTImageCache forceLinkerLoad_];
    [CTPlaceholderView forceLinkerLoad_];
    [DateUtils forceLinkerLoad_];
    [CTTimePickerView forceLinkerLoad_];
    [LocationSearchViewController forceLinkerLoad_];
    [LocationSearchDataSource forceLinkerLoad_];
    [CTCalendarViewController forceLinkerLoad_];
    [CTCalendarView forceLinkerLoad_];
    [CTCalendarTableViewCell forceLinkerLoad_];
    [CTDateCollectionViewCell forceLinkerLoad_];
    [CalendarLogicController forceLinkerLoad_];
    [CTMiddleDateCell forceLinkerLoad_];
    [CTVehicleSelectionView forceLinkerLoad_];
    [VehicleTableViewCell forceLinkerLoad_];
    [CTNavigationBar forceLinkerLoad_];
    [CTNavigationItem forceLinkerLoad_];
    [CTNavigationController forceLinkerLoad_];
    [CTView forceLinkerLoad_];
    [CTTextField forceLinkerLoad_];
    [LocationSearchTableViewCell forceLinkerLoad_];
}

@end
