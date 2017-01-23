//
//  VehAvailRSCore.m
//  CarTrawler
//
//

#import "CTVehicleAvailability.h"
#import "CTVendor.h"
#import "CTVehicle.h"
#import "CTEngineInfo.h"

@implementation CTVehicleAvailability

- (id) initFromVehAvailRSCoreDictionary:(NSDictionary *)vehAvailRSCoreDictionary
{
    self = [super init];

    vehAvailRSCoreDictionary = vehAvailRSCoreDictionary[@"VehAvailRSCore"];
	_puDate = vehAvailRSCoreDictionary[@"VehRentalCore"][@"@PickUpDateTime"];
	_doDate = vehAvailRSCoreDictionary[@"VehRentalCore"][@"@ReturnDateTime"];
	_puLocationCode = vehAvailRSCoreDictionary[@"VehRentalCore"][@"PickUpLocation"][@"@LocationCode"];
	_puLocationName = vehAvailRSCoreDictionary[@"VehRentalCore"][@"PickUpLocation"][@"@Name"];
	_doLocationCode = vehAvailRSCoreDictionary[@"VehRentalCore"][@"ReturnLocation"][@"@LocationCode"];
	_doLocationName = vehAvailRSCoreDictionary[@"VehRentalCore"][@"ReturnLocation"][@"@Name"];
    
    NSMutableArray *tempItems = [[NSMutableArray alloc] init];
    
    if ([[vehAvailRSCoreDictionary objectForKey:@"VehVendorAvails"] isKindOfClass:[NSArray class]]) {
        NSArray *rawVendorArray = [vehAvailRSCoreDictionary objectForKey:@"VehVendorAvails"];

        for (int i = 0; i < [rawVendorArray count]; i++) {
            NSDictionary *vendorDict = rawVendorArray[i];

            CTVendor *vendor = [[CTVendor alloc] initWithVendorInfo:vendorDict];
            CTEngineInfo *engineInfo = [[CTEngineInfo alloc] initFromDictionary:vendorDict];

            if ([vendorDict[@"VehAvails"] isKindOfClass:[NSArray class]]) {
                NSArray *vehArray = vendorDict[@"VehAvails"];
                for (int k = 0; k < vehArray.count; k++) {
                    CTVehicle *vehicle = [[CTVehicle alloc] initFromDictionary:vehArray[k]];
                    CTAvailabilityItem *item = [[CTAvailabilityItem alloc] initWithVendor:vendor vehicle:vehicle engineInfo:engineInfo];
                    [tempItems addObject:item];
                }
            }
        }
        
    } else {
        //only one vendor
        NSDictionary *vendorDict = [vehAvailRSCoreDictionary objectForKey:@"VehVendorAvails"][@"VehVendorAvail"];
        
        CTVendor *vendor = [[CTVendor alloc] initWithVendorInfo:vendorDict];
        CTEngineInfo *engineInfo = [[CTEngineInfo alloc] initFromDictionary:vendorDict];

        if ([vendorDict[@"VehAvails"] isKindOfClass:[NSArray class]]) {
            NSArray *vehArray = vendorDict[@"VehAvails"];
            for (int k = 0; k < vehArray.count; k++) {
                CTVehicle *vehicle = [[CTVehicle alloc] initFromDictionary:vehArray[k]];
                CTAvailabilityItem *item = [[CTAvailabilityItem alloc] initWithVendor:vendor vehicle:vehicle engineInfo:engineInfo];
                [tempItems addObject:item];
            }
        }
    }
    
    _items = tempItems;
    
    //order by order id
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"vehicle.orderIndex"
                                                                 ascending:YES];
    _items =  [self.items sortedArrayUsingDescriptors:@[descriptor]];

    return self;
}

@end
