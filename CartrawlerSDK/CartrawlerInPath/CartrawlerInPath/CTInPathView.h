//
//  CTInPathView.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTInPathVehicle.h"

@interface CTInPathView : UIView

- (void)renderVehicleDetails:(CTInPathVehicle *)vehicle animated:(BOOL)animated;
- (void)renderDefault:(BOOL)animated;

@end
