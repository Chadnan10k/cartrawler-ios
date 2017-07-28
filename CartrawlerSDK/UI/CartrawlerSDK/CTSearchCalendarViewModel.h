//
//  CTSearchCalendarViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/22/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"

@interface CTSearchCalendarViewModel : NSObject <CTViewModelProtocol>

@property (nonatomic, readonly) UIColor *navigationBarColor;

@property (nonatomic, readonly) UIColor *buttonColor;

@property (nonatomic, readonly) NSString *displayedPickupDate;

@property (nonatomic, readonly) NSString *displayedDropoffDate;

@property (nonatomic, readonly) BOOL enableNextButton;

@end
