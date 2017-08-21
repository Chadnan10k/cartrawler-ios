//
//  CTViewControllerProtocol.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CTViewModelProtocol.h>

@protocol CTViewControllerProtocol <NSObject>

@optional
+ (Class)viewModelClass;
- (void)updateWithViewModel:(id)viewModel;

@end
