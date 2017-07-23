//
//  CTViewModelProtocol.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CTViewModelProtocol <NSObject>

+ (instancetype)viewModelForState:(id)state;

@end
