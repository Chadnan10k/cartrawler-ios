//
//  DCParams.h
//  DC Storm Tracking Library
//
//  Created by chris birch on 17/05/2012.
//  Copyright (c) 2012 Ocasta Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Represents tracking metrics. The number of metrics that can be stored are limited,
 * check maxParameterCount property if in doubt.
 */
@interface DCParams : NSObject

#pragma mark -
#pragma mark Properties

/**
 * Probably shouldn't be exposed to the public, but left in here for a while whilst we conduct tests
 */
@property (nonatomic, strong,readonly) NSMutableArray *params;
/**
 * The maximum number of parameters that can be stored in this object
 */
@property (nonatomic, readonly) unsigned long maxParameterCount;

/**
 * The letter that is used to prefix array indices, i.e prefix = "h", params 1..3 = h1, h2, h3
 */
@property (nonatomic,strong,readonly) NSString* fieldPrefix;

/**
 * Returns the Params instance represented as a NSMutableDictionary.
 */
@property (nonatomic,readonly) NSMutableDictionary* asDictionary;


/**
 * Returns the Params instance represented as by a JSON string
 */
@property (nonatomic,readonly) NSString* asJSON;

#pragma mark -
#pragma mark Public methods

/**
 * Sets the value for the parameter at the specified index within the array. This is 1 based.
 */
-(BOOL)setParamValueString: (NSString*) value atIndex: (unsigned long) parameterIndex;
/**
 * Gets the value for the parameter at the specified index within the array. This is 1 based.
 * Returns nil if parameter index falls outside of the allowed bounds of the parameter array
 */
-(NSString*)getParameterValueAtIndex: (unsigned long) parameterIndex;

/**
 * Returns YES if a value has been set for the parameter at the specified index
 */
-(BOOL) hasValueForParameterAtIndex: (unsigned long) parameterIndex; 


@end
