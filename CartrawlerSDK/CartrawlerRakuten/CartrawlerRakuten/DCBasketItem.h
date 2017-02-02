//
//  DCBasketItem.h
//  DC Storm Tracking Library
//
//  Created by chris birch on 16/05/2012.
//  Copyright (c) 2012 Ocasta Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCParams.h"

/**
 * Represents a single item in a DCSalesBasket.
 */
@interface DCBasketItem : NSObject

/**
 * The number of units of this item
 */
@property (nonatomic, assign) unsigned long itemCount;
/**
 * The cost of one unit of this item
 */
@property (nonatomic, strong) NSDecimalNumber *itemValue;

/**
 * A collection of metrics associated with this item.
 */
@property(nonatomic,strong) DCParams* metrics;
/**
 * The total value of this basket item.
 * i.e itemCount * itemValue
 */
@property(nonatomic,readonly) NSDecimalNumber* totalValue;

/**
 * Returns the SalesBasket represented as a NSMutableDictionary.
 */
@property(nonatomic,readonly) NSMutableDictionary* asDictionary;

/**
 * Returns the SalesBasket represented as a JSON string
 */
@property(nonatomic,readonly) NSString* asJSON;


/**
 * Inits a new instance with the value of the item and the quanity of units
 */
-(id) initWithItemValue: (float) itemValue andItemQuantity: (unsigned long) quantity;

@end
