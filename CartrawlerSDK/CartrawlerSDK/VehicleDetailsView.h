//
//  VehicleDetailsView.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CartrawlerAPI.h>
#import <CartrawlerSDK/CTSearch.h>

@interface VehicleDetailsView : UIViewController

typedef void (^CTVehicleDetailsHeight)(CGFloat height);
@property (nonatomic) CTVehicleDetailsHeight heightChanged;

+ (void)forceLinkerLoad_;

- (void)setupView;

- (void)setData:(CTSearch *)search
            api:(CartrawlerAPI *)api
     pickupDate:(NSDate *)pickupDate
     returnDate:(NSDate *)returnDate
     pickupCode:(NSString *)pickupCode
     returnCode:(NSString *)returnCode
    homeCountry:(NSString *)homeCountry;

@end
