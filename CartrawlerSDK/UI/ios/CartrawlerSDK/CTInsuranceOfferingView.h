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

typedef void (^CTInsuranceTap)(void);

@property (nonatomic) CTInsuranceTap addAction;
@property (nonatomic) CTInsuranceTap termsAndConditionsAction;

- (void)updateInsurance:(CTInsurance *)insurance;

@end
