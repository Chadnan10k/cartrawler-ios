//
//  DCSalesBasket.h
//  DC Storm Tracking Library
//
//  Created by chris birch on 16/05/2012.
//  Copyright (c) 2012 Ocasta Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCEnums.h"

@class DCBasketItem;
@class DCBasketParams;

/**
 * Represents a shopping basket. Contains a list of BasketItem and some
 * other important properties relating to shopping basket
 */
@interface DCSalesBasket : NSObject
{
    
}

#pragma mark -
#pragma mark Properties

/**
 * The total value of the sales basket
 */
@property (nonatomic, readonly) NSDecimalNumber *totalValue;
/**
 * User defined value:
 * The ID number of this order
 */
@property (nonatomic,strong) NSString* orderID;
/**
 * User defined value:
 * The type of sale
 */
@property (nonatomic, strong) NSString *saleType;
/**
 * A collection of metrics relating to this basket
 */
@property (nonatomic, strong,readonly) DCBasketParams* headerParameters;
/**
 * An array of DCSalesBasket pointers.
 * These items represents the contents of the basket
 */
@property (nonatomic, strong,readonly) NSMutableArray *items;
/**
 * Set to YES if the items in this basket were bought.
 */
@property (nonatomic, assign) BOOL converts;


/**
 * Returns the SalesBasket represented as a NSMutableDictionary.
 */
@property(nonatomic,readonly) NSMutableDictionary* asDictionary;

/**
 * Returns the SalesBasket represented as a JSON string
 */
@property(nonatomic,readonly) NSString* asJSON;

#pragma mark -
#pragma mark Constructors

- (id)init;


/**
 * Inits an instance by specifying the orderID and sale type. Nil parameters are ignored.
 */
- (id)initWithOrderID: (NSString*) orderID andSaleType:(NSString*) saleType;

#pragma mark -
#pragma mark Instance methods

///**
// * Convenience method for logging a DCSalesBasket without having to create an instance of DCSalesBasket.
// */
+(BOOL)logWithOrderID:(NSString *)orderID andSaleType:(NSString *)saleType withBasketItems:(NSArray *)basketItems andParams:(DCBasketParams*)params doesConvert:(BOOL) converts andError:(NSError**)error;

/**
 * Logs the AppEvent. If succesful error will be nil
 */
-(LogResult)logWithError: (NSError**) error;

/**
 * Discards any data associated with this shopping basket, so it may be reused
 * N.B This doesn't need to be called after a succesful call to log
 */
-(void)clear;

/**
 * Adds an item to the shopping basket
 */
-(void)addItem:(DCBasketItem*) item;

/**
 * Adds the items from the specified array to the shopping basket
 */
-(void)addItemsFromArray:(NSArray*) items;

/**
 * Returns item at the specified index within the array
 */
-(DCBasketItem*)getItem:(unsigned long) item;

/**
 * Removes the item at the specified index from the array
 */
-(void)removeItem:(unsigned long) item;

@end
