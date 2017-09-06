//
//  CTSelectedVehicleInsuranceViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"

@interface CTSelectedVehicleInsuranceViewModel : NSObject <CTViewModelProtocol>

@property (nonatomic, readonly) UIColor *primaryColor;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *infoTip1;
@property (nonatomic, readonly) NSString *infoTip2;
@property (nonatomic, readonly) NSString *infoTip3;
@property (nonatomic, readonly) NSString *detailsTitle;
@property (nonatomic, readonly) NSString *logo;
@property (nonatomic, readonly) NSString *pricePerDay;
@property (nonatomic, readonly) NSString *total;
@property (nonatomic, readonly) NSAttributedString *addInsurance;
@property (nonatomic, readonly) UIColor *buttonColor;
@end
