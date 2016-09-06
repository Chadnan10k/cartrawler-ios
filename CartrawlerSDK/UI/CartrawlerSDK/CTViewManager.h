//
//  CTViewManager.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CarRentalSearch.h"
#import "GroundTransportSearch.h"
#import "CTViewController.h"

///Checks whether or not we can push to a certain view
@interface CTViewManager : NSObject

typedef void (^ValidationCompletion)(BOOL success, NSString *errorMessage);

+ (void)canTransitionToStep:(CTViewController *)step
            carRentalSearch:(CarRentalSearch *)carRentalSearch
      groundTransportSearch:(GroundTransportSearch *)groundTransportSearch
              cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
                 completion:(ValidationCompletion)completion;
@end
