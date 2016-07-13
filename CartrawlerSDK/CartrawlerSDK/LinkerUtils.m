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
#import "CTFilterViewController.h"
#import "CTFilterTableViewCell.h"
#import "VehicleDetailsViewController.h"
#import "VehicleDetailsView.h"
#import "ExpandingInfoView.h"
#import "IncludedCollectionViewCell.h"
#import "CTDesignableView.h"
#import "UnderLinedButton.h"
#import "IncludedCollectionViewLayout.h"
#import "TermsViewController.h"
#import "TermsDetailViewController.h"
#import "TabButton.h"
#import "ExtrasViewController.h"
#import "ExpandExtrasButton.h"
#import "OptionalExtraTableViewCell.h"
#import "OptionalExtrasViewController.h"
#import "PaymentSummaryViewController.h"
#import "PaymentSummaryTableViewCell.h"
#import "BookingSummaryViewController.h"
#import "DriverDetailsViewController.h"
#import "BookingSummaryButton.h"
#import "AddressDetailsViewController.h"
#import "PaymentViewController.h"
#import "CompletionViewController.h"

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
    [CTFilterViewController forceLinkerLoad_];
    [CTFilterTableViewCell forceLinkerLoad_];
    [VehicleDetailsViewController forceLinkerLoad_];
    [VehicleDetailsView forceLinkerLoad_];
    [ExpandingInfoView forceLinkerLoad_];
    [IncludedCollectionViewCell forceLinkerLoad_];
    [CTDesignableView forceLinkerLoad_];
    [UnderLinedButton forceLinkerLoad_];
    [IncludedCollectionViewLayout forceLinkerLoad_];
    [TermsViewController forceLinkerLoad_];
    [TermsDetailViewController forceLinkerLoad_];
    [TabButton forceLinkerLoad_];
    [ExtrasViewController forceLinkerLoad_];
    [ExpandExtrasButton forceLinkerLoad_];
    [OptionalExtraTableViewCell forceLinkerLoad_];
    [OptionalExtrasViewController forceLinkerLoad_];
    [PaymentSummaryViewController forceLinkerLoad_];
    [PaymentSummaryTableViewCell forceLinkerLoad_];
    [BookingSummaryViewController forceLinkerLoad_];
    [DriverDetailsViewController forceLinkerLoad_];
    [BookingSummaryButton forceLinkerLoad_];
    [AddressDetailsViewController forceLinkerLoad_];
    [PaymentViewController forceLinkerLoad_];
    [CompletionViewController forceLinkerLoad_];

}

@end
