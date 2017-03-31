//
//  CTErrorTag.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTErrorTag : NSObject

typedef NS_ENUM(NSUInteger, CTErrorLevel) {
    //For info errors, eg, date has passed
    CTErrorLevelInfo = 0,
    //For fatal errors, eg. date has the wrong format
    CTErrorLevelError
};

- (instancetype)init:(NSString *)version
                step:(NSString *)step
               event:(NSString *)event
             message:(NSString *)message
        engineLoadID:(NSString *)engineLoadID
            clientId:(NSString *)clientId
              target:(NSString *)target;

@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *step;
@property (nonatomic, strong) NSString *event;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *engineLoadID;
@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *target;
@property (nonatomic) CTErrorLevel level;

- (NSURL *)produceURL;

@end
