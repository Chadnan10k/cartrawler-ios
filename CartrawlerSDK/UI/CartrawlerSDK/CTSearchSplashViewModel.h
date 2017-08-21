//
//  CTSearchSplashViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTSearchReservationsCellModel.h"

@interface CTSearchSplashViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) UIColor *splashColor;
@property (nonatomic, readonly) UIColor *illustrationColor;
@property (nonatomic, readonly) NSString *splashText;
@property (nonatomic, readonly) NSString *searchBoxText;
@property (nonatomic, readonly) NSString *nextTrip;
@property (nonatomic, readonly) NSString *bookAnotherCar;
@property (nonatomic, readonly) NSArray <CTSearchReservationsCellModel *> *rowViewModels;
@end
