//
//  StepSevenViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface StepSevenViewController : UIViewController

typedef void (^StepOneCompletion)(BOOL success, NSString *errorMessage);


@property (nonatomic, strong) CartrawlerAPI *cartrawlerAPI;
@property (nonatomic, strong) CTVehicle *selectedVehicle;
@property (nonatomic, strong) CTMatchedLocation *pickupLocation;
@property (nonatomic, strong) CTMatchedLocation *dropoffLocation;
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSDate *dropoffDate;
@property (nonatomic, strong) NSNumber *driverAge;
@property (nonatomic, strong) NSNumber *passengerQty;
@property (nonatomic, strong) CTInsurance *insurance;
@property (nonatomic) BOOL isBuyingInsurance;
@property (nonatomic, strong) NSArray<CTExtraEquipment *> *extras;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *flightNumber;
@property (nonatomic, strong) NSString *addressLine1;
@property (nonatomic, strong) NSString *addressLine2;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *postcode;
@property (nonatomic, strong) NSString *country;

/*
 *  We end the booking journey here so the developer has freedom to either present a subview on completion or push to a new view controller.
 */
- (void)makeBooking:(CTPaymentCard *)paymentCard completion:(StepOneCompletion)completion;

@end
