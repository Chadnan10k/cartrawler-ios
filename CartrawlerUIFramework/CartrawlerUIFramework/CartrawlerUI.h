//
//  CartrawlerAPI.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 13/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CartrawlerUI : NSObject

- (id)initWithRequestorID:(NSString *)requestorID
             languageCode:(NSString *)languageCode
                  isDebug:(BOOL)isDebug;

- (void)presentCartrawlerView;

//experimental
- (void)overrideStepOne:(UIViewController *)viewController;



@end
