//
//  CTInsuranceView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 08/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CTInsuranceDelegate <NSObject>

/**
 Fires if the user added insurance
 */
- (void)didAddInsurance;
/**
 Fires if the user removes insurance
 */
- (void)didRemoveInsurance;

@end

@interface CTInsuranceView : UIView

@end
