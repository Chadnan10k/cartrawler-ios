//
//  CTInsuranceView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 08/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CartrawlerAPI.h>
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
 Fires if user taps on terms and conditions

 @param termsURL The terms and conditions URL
 */
- (void)didTapTermsAndConditions:(NSURL *)termsURL;

@end

@interface CTInsuranceView : UIView

@property (nonatomic, weak) id<CTInsuranceDelegate> delegate;

- (void)retrieveInsurance:(CartrawlerAPI *)api search:(CTRentalSearch *)search;

@end
