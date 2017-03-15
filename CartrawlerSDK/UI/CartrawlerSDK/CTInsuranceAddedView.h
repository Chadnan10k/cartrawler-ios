//
//  CTInsuranceAddedView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 09/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTInsuranceAddedView : UIView

typedef void (^CTInsuranceRemove)(void);

@property (nonatomic) CTInsuranceRemove removeAction;

@end
