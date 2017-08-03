//
//  CTSearchUSPDetailViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 02/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"

typedef NS_ENUM(NSUInteger, CTSearchUSPDetailType) {
    CTSearchUSPDetailTypeNone,
    CTSearchUSPDetailTypeCreditCard,
    CTSearchUSPDetailTypeHeadset,
    CTSearchUSPDetailTypeMap,
    CTSearchUSPDetailTypeSearch,
    CTSearchUSPDetailTypeLock,
};

@interface CTSearchUSPDetailViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) CTSearchUSPDetailType detailType;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *detail;

// TODO: Get rid of mutable property
@property (nonatomic, readwrite) UIColor *primaryColor;

@end
