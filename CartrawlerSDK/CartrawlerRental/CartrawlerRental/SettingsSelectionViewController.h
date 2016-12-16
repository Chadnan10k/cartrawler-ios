//
//  SelectCountryViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCSVItem.h"

@interface SettingsSelectionViewController : UIViewController

typedef enum SettingsType : NSUInteger {
    SettingsTypeLanguage,
    SettingsTypeCurrency,
    SettingsTypeCountry
}SettingsType;

typedef void (^CTSettingsCompletion)(CTCSVItem *settingsItem);
@property (nonatomic, strong) CTSettingsCompletion settingsCompletion;

- (void)setSettingsType:(SettingsType)settingsType;

@end
