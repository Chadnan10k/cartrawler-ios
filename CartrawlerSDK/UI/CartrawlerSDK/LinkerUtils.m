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
#import "CTTimePickerView.h"
#import "CTLocationSearchViewController.h"
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
#import "OptionalExtraTableViewCell.h"
#import "PaymentSummaryViewController.h"
#import "PaymentSummaryTableViewCell.h"
#import "BookingSummaryViewController.h"
#import "DriverDetailsViewController.h"
#import "BookingSummaryButton.h"
#import "AddressDetailsViewController.h"
#import "PaymentViewController.h"
#import "GroundTransportViewController.h"
#import "GroundServicesViewController.h"
#import "GTServiceTableViewCell.h"
#import "GTBookNowButton.h"
#import "SupplierRatingsViewController.h"
#import "SettingsViewController.h"
#import "SettingsSelectionViewController.h"
#import "CTTextView.h"
#import "CTPickerView.h"
#import "OptionalExtrasView.h"
#import "CTSegmentedControl.h"
#import "PaymentCompletionViewController.h"
#import "InclusionCollectionViewCell.h"
#import "InclusionFlowLayout.h"
#import "GTPaymentViewController.h"
#import "GTPaymentCompletionViewController.h"
#import "CTSelectView.h"
#import "GTShuttleTableViewCell.h"
#import "GTPassengerViewController.h"
#import "GTFilterCollectionViewCell.h"
#import "InclusionsTableViewCell.h"
#import "VehicleDetailsPageViewController.h"
#import "SupplierRatingCollectionViewCell.h"
#import "PageSelectionCollectionViewCell.h"
#import "PassengerSelectionViewController.h"
#import "CTStepper.h"
#import "CTNavigationView.h"
#import "GTFilterCollectionViewFlowLayout.h"
#import "CTInclusionTableViewCell.h"
#import "CTInterstitialViewController.h"
#import "CTFilterContainer.h"
#import "RentalBookingsViewController.h"
#import "RentalBookingCell.h"
#import "GTBookingsViewController.h"
#import "GTBookingTableViewCell.h"
#import "VehicleFeatureCollectionViewCell.h"

@implementation LinkerUtils

+ (void)loadFiles
{
    [JVFloatLabeledTextField forceLinkerLoad_];
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
    [CTLocationSearchViewController forceLinkerLoad_];
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
    [OptionalExtraTableViewCell forceLinkerLoad_];
    [PaymentSummaryViewController forceLinkerLoad_];
    [PaymentSummaryTableViewCell forceLinkerLoad_];
    [BookingSummaryViewController forceLinkerLoad_];
    [DriverDetailsViewController forceLinkerLoad_];
    [BookingSummaryButton forceLinkerLoad_];
    [AddressDetailsViewController forceLinkerLoad_];
    [PaymentViewController forceLinkerLoad_];
    [GroundTransportViewController forceLinkerLoad_];
    [GroundServicesViewController forceLinkerLoad_];
    [GTServiceTableViewCell forceLinkerLoad_];
    [GTBookNowButton forceLinkerLoad_];
    [SupplierRatingsViewController forceLinkerLoad_];
    [SettingsSelectionViewController forceLinkerLoad_];
    [SettingsViewController forceLinkerLoad_];
    [CTTextView forceLinkerLoad_];
    [CTPickerView forceLinkerLoad_];
    [OptionalExtrasView forceLinkerLoad_];
    [CTSegmentedControl forceLinkerLoad_];
    [PaymentCompletionViewController forceLinkerLoad_];
    [InclusionCollectionViewCell forceLinkerLoad_];
    [InclusionFlowLayout forceLinkerLoad_];
    [GTPaymentViewController forceLinkerLoad_];
    [GTPaymentCompletionViewController forceLinkerLoad_];
    [CTSelectView forceLinkerLoad_];
    [GTShuttleTableViewCell forceLinkerLoad_];
    [GTPassengerViewController forceLinkerLoad_];
    [GTFilterCollectionViewCell forceLinkerLoad_];
    [InclusionsTableViewCell forceLinkerLoad_];
    [VehicleDetailsPageViewController forceLinkerLoad_];
    [SupplierRatingCollectionViewCell forceLinkerLoad_];
    [PageSelectionCollectionViewCell forceLinkerLoad_];
    [PassengerSelectionViewController forceLinkerLoad_];
    [CTStepper forceLinkerLoad_];
    [CTNavigationView forceLinkerLoad_];
    [GTFilterCollectionViewFlowLayout forceLinkerLoad_];
    [CTInclusionTableViewCell forceLinkerLoad_];
    [CTInterstitialViewController forceLinkerLoad_];
    [CTFilterContainer forceLinkerLoad_];
    [RentalBookingsViewController forceLinkerLoad_];
    [RentalBookingCell forceLinkerLoad_];
    [GTBookingsViewController forceLinkerLoad_];
    [GTBookingTableViewCell forceLinkerLoad_];
    [VehicleFeatureCollectionViewCell forceLinkerLoad_];
}

@end
