//
//  CTSearchInterstitialViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"

@interface CTSearchInterstitialViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) UIColor *navigationBarColor;
@property (nonatomic, readonly) NSString *navigationBarTitle;
@property (nonatomic, readonly) NSString *navigationBarDetail;
@end
