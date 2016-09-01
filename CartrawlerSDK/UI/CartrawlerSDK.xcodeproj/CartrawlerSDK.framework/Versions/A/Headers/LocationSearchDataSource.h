//
//  LocationSearchDataSource.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 08/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTMatchedLocation.h>

@interface LocationSearchDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

typedef void (^SelectedLocationCompletion)(CTMatchedLocation *location);

@property (nonatomic, strong) SelectedLocationCompletion selectedLocation;

- (void)updateData:(NSString *)partialText completion:(void (^)(BOOL didSucceed))completion;

@end
