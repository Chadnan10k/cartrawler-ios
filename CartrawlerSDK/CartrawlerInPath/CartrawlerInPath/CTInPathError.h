//
//  CTInPathError.h
//  CartrawlerInPath
//
//  Created by Lee Maguire on 20/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTInPathError : NSError

typedef NS_ENUM(NSUInteger, CTInPathErrorType) {
    
    CTInPathErrorTypeNoPrimaryPassenger = 0,
    
    CTInPathErrorTypeUnknown

};

+ (NSError *)errorWithType:(CTInPathErrorType)type;

@end
