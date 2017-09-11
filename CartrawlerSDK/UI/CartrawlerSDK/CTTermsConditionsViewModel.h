//
//  CTTermsConditionsViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 11/09/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTTermAndCondition.h"

@interface CTTermsConditionsViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) UIColor *primaryColor;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *close;
@property (nonatomic, readonly) NSArray <CTTermAndCondition *> *termsAndConditions;
@end
