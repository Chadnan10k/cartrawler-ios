//
//  CTBookingModalViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 21/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTBookingTableViewModel.h"

@interface CTBookingModalViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) CTBookingTableViewModel *bookingTableViewModel;
@property (nonatomic, readonly) UIColor *buttonContainerColor;
@property (nonatomic, readonly) UIColor *buttonColor;
@property (nonatomic, readonly) NSString *button;
@property (nonatomic, readonly) BOOL buttonEnabled;
@end
