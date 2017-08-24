//
//  CTInsuranceView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 08/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CartrawlerAPI.h"
#import <CartrawlerSDK/CTRentalSearch.h>

@protocol CTInsuranceDelegate <NSObject>

/**
 Fires if the user added insurance
 */
- (void)didAddInsurance:(CTInsurance *)insurance;
/**
 Fires if the user removes insurance
 */
- (void)didRemoveInsurance;

/**
 Fires if user taps on more detail

 */
- (void)didTapMoreInsuranceDetail;

@end

@interface CTInsuranceView : UIView

typedef void (^CTInsuranceRetrievalCompletion)(CTInsurance *insurance);

@property (nonatomic, weak) id<CTInsuranceDelegate> delegate;

- (void)retrieveInsurance:(CartrawlerAPI *)api search:(CTRentalSearch *)search completion:(CTInsuranceRetrievalCompletion)completion;

- (void)presentSelectedState;

@end
