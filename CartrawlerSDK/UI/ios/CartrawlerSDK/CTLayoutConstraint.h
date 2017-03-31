//
//  CTLayoutConstraint.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTLayoutConstraint : NSLayoutConstraint

typedef NS_ENUM(NSUInteger, CTConstraintType) {
    CTConstraintTypeLeft = 0,
    CTConstraintTypeRight
};

@end
