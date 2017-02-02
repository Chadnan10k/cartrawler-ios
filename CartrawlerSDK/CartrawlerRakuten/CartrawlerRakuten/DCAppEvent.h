//
//  DCAppEvent.h
//  DC Storm Tracking Library
//
//  Created by chris birch on 16/05/2012.
//  Copyright (c) 2012 Ocasta Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Represents an individual tracking event.
 * The event contains common properties such as name and type.
 * A collection of custom parameters can also me specified.
 */
@interface DCAppEvent : NSObject

#pragma mark -
#pragma mark Properties

/**
 * The name that describes this event
 */
@property (nonatomic, strong) NSString *name;
/**
 * The type of event
 */
@property (nonatomic, strong) NSString *type;

/**
 * Parameters associated with the event
 */
@property (nonatomic, strong,readonly) NSMutableDictionary *params;

/**
 * Returns the app event represented as a NSDictionary.
 */
@property(nonatomic,readonly) NSMutableDictionary* asDictionary;

/**
 * Returns the app event represnted as by a JSON string
 */
@property (nonatomic,readonly) NSString* asJSON;

#pragma mark -
#pragma mark Constructors

/**
 * Inits a new instance using defaults
 */
-(id)init;

/**
 * Inits a new instance by specifying the name, type and params
 * @param params Pass nil or empty dictionary if no params
 */
-(id)initWithName:(NSString*) name type:(NSString*) type andParams: (NSDictionary*) params;


#pragma mark -
#pragma mark Instance methods

/**
 * Logs the AppEvent. If succesful error will be nil
 */
-(BOOL)logWithError: (NSError**) error;

/**
 * Sets the value of the item with Key to Value. If item Key does not exist, it is added
 */
-(void)setParamValue: (NSString*) value forKey:(NSString*) key;



#pragma mark -
#pragma mark Static methods

/**
 * Convenience method to create an AppEvent and log it in one line of code.
 * If succesful error will be nil
 */
+(BOOL)logWithName:(NSString*) name type:(NSString*) type andParams: (NSDictionary*) params andError:(NSError**) error;

@end
