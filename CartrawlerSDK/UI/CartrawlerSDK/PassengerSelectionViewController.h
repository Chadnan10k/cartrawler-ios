//
//  PassengerSelectionViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroundTransportSearch.h"

@interface PassengerSelectionViewController : UIViewController

+ (void)forceLinkerLoad_;

typedef void (^PassengerSelectionUpdated)(NSString *text);

@property (nonatomic) PassengerSelectionUpdated updatedData;
@property (nonatomic, strong) GroundTransportSearch *groundSearch;

@end
