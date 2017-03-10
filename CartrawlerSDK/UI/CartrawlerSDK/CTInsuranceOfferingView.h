//
//  CTInsuranceOfferingView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 09/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTInsuranceOfferingView : UIView

typedef void (^CTInsuranceAdd)(void);

@property (nonatomic) CTInsuranceAdd addAction;

@end
