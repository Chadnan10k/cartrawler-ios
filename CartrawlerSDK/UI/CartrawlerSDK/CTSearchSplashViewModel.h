//
//  CTSearchSplashViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import <UIKit/UIKit.h>

@interface CTSearchSplashViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) UIColor *primaryColor;
@property (nonatomic, readonly) NSString *splashText;
@property (nonatomic, readonly) NSString *searchBoxText;
@end
