//
//  CTInsterstitialViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 29/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTLabel.h"

@interface CTInterstitialViewController : UIViewController

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *spinnerImageView;
@property (unsafe_unretained, nonatomic) IBOutlet CTLabel *loadingLabel;

+ (void)forceLinkerLoad_;

+ (void)present:(UIViewController *)viewController;
+ (void)dismiss;

@end
