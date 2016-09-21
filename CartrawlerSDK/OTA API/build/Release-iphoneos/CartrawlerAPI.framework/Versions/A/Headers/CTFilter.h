//
//  Filter.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 23/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTVehicle.h"

@interface CTFilter : NSObject

typedef NS_ENUM(NSUInteger, FuelType) {
    FuelTypePetrol = 0,
    FuelTypeDiesel = 1,
    FuelTypeElectric = 2,
    FuelTypeAny = 3
};

typedef NS_ENUM(NSUInteger, TransmissionType) {
    TransmissionTypeManual = 0,
    TransmissionTypeAutomatic = 1,
    TransmissionTypeAny = 2
};

/**
 *  Use this to perform a filter on a CTVehicle array
 *
 *  @param passengers     The amount of passengers the vehicle can take
 *  @param fuelType       Use FuelType enum
 *  @param transmission   Use TransmissionType enum
 *  @param airconRequired Is aircon required?
 *  @param cars           The car array you want to filter
 *
 *  @return returns a filtered CTVehicle array
 */
+ (NSArray <CTVehicle *> *)performFilter:(NSNumber *)passengers
                            fuelType:(FuelType)fuelType
                        transmission:(TransmissionType)transmission
                      airconRequired:(BOOL)airconRequired
                                cars:(NSArray<CTVehicle *> *)cars;

/**
 *  Sort cars by price
 *
 *  @param ascending Sort by ascending or descending price
 *  @param cars      The cars you want to sort
 *
 *  @return The sorted CTVehicle array
 */
+ (NSArray <CTVehicle *> *)sortPrice:(BOOL)ascending cars:(NSArray<CTVehicle *> *)cars;

/**
 *  Convenience method for returning FuelType
 *
 *  @param fuelType Use FuelType enum
 *
 *  @return Returns a FuelType
 */
+ (FuelType)fuelType:(FuelType)fuelType;

/**
 *  Convenience method for returning TransmissionType
 *
 *  @param transmissionType Use TransmissionType enum
 *
 *  @return Returns TransmissionType
 */
+ (TransmissionType)transmissionType:(TransmissionType)transmissionType;

/**
 *  Convenience method for getting a FuelType from an Int value
 *
 *  @param fuelType Int represenation of the FuelType, see the FuelType enum
 *
 *  @return Returns the FuelType
 */
+ (FuelType)fuelTypeWithInt:(NSInteger)fuelType;

/**
 *  Convenience method for getting a TransmissionType from an Int value
 *
 *  @param transmissionType Int represenation of the TransmissionType, see the TransmissionType enum
 *
 *  @return Returns the TransmissionType
 */
+ (TransmissionType)transmissionTypeWithInt:(NSInteger)transmissionType;
@end