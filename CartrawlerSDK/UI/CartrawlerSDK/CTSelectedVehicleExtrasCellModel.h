//
//  CTSelectedVehicleExtrasCellModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTAppState.h"

@interface CTSelectedVehicleExtrasCellModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) UIColor *primaryColor;
@property (nonatomic, readonly) NSString *imageCharacter;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *detail;
@property (nonatomic, readonly) NSString *moreDetail;
@property (nonatomic, readonly) NSString *quantity;
@property (nonatomic, readonly) CTExtraEquipment *extra;
@property (nonatomic, readonly) BOOL incrementEnabled;
@property (nonatomic, readonly) BOOL decrementEnabled;
@property (nonatomic, readonly) UIColor *incrementButtonColor;
@property (nonatomic, readonly) UIColor *decrementButtonColor;
@property (nonatomic, readonly) BOOL flipped;

+ (instancetype)viewModelForState:(CTAppState *)state
                            extra:(CTExtraEquipment *)extra;

@end
