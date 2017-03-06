//
//  CTSettingsViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTSettingsViewController : UIViewController

typedef void (^ChangedLanguage)(void);

@property (nonatomic) ChangedLanguage changedLanguage;

@end
