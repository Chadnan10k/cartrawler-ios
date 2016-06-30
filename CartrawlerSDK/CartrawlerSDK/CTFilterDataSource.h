//
//  CTFilterCarSizeDataSource.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CTFilterDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

typedef void (^CTFilterCompletion)(NSArray *selectedData);

@property (nonatomic, strong) CTFilterCompletion filterCompletion;

- (id)initWithData:(NSArray *)data selectedData:(NSMutableArray *)selectedData;

@end
