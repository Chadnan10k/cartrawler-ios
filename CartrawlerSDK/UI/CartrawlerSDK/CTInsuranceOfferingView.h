//
//  CTInsuranceOfferingView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 09/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTInsurance;

@interface CTInsuranceOfferingView : UIView

typedef void (^CTInsuranceAdd)(void);

@property (nonatomic) CTInsuranceAdd addAction;

- (instancetype)init:(CTInsurance *)insurance;

@end
