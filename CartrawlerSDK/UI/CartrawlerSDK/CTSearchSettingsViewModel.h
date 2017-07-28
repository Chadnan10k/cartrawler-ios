//
//  CTSearchSettingsViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTAppState.h"
#import "CTViewModelProtocol.h"
#import "CTSearchSettingsSelectionViewModel.h"

@interface CTSearchSettingsViewModel : NSObject <CTViewModelProtocol>

@property (nonatomic, readonly) UIColor *navigationBarColor;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *closeButtonTitle;

@property (nonatomic, readonly) NSString *currencyLabelText;
@property (nonatomic, readonly) NSString *languageLabelText;
@property (nonatomic, readonly) NSString *countryLabelText;

@property (nonatomic, readonly) NSString *currency;
@property (nonatomic, readonly) NSString *language;
@property (nonatomic, readonly) NSString *country;

@property (nonatomic, readonly) CTSearchSearchSettings selectedSettings;

@property (nonatomic, readonly) CTSearchSettingsSelectionViewModel *selectedSettingsViewModel;

@end
