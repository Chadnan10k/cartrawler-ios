//
//  VehAvailRSCore.m
//  CarTrawler
//
//

#import "CTVehicleAvailability.h"
#import "CTVendor.h"
#import "CTVehicle.h"

@implementation CTVehicleAvailability

- (id) initFromVehAvailRSCoreDictionary:(NSDictionary *)vehAvailRSCoreDictionary
{
    self = [super init];

    vehAvailRSCoreDictionary = vehAvailRSCoreDictionary[@"VehAvailRSCore"];
	_puDate = [[vehAvailRSCoreDictionary objectForKey:@"VehRentalCore"] objectForKey:@"@PickUpDateTime"];
	_doDate = [[vehAvailRSCoreDictionary objectForKey:@"VehRentalCore"] objectForKey:@"@ReturnDateTime"];
	_puLocationCode = [[[vehAvailRSCoreDictionary objectForKey:@"VehRentalCore"] objectForKey:@"PickUpLocation"] objectForKey:@"@LocationCode"];
	_puLocationName = [[[vehAvailRSCoreDictionary objectForKey:@"VehRentalCore"] objectForKey:@"PickUpLocation"] objectForKey:@"@Name"];
	_doLocationCode = [[[vehAvailRSCoreDictionary objectForKey:@"VehRentalCore"] objectForKey:@"ReturnLocation"] objectForKey:@"@LocationCode"];
	_doLocationName = [[[vehAvailRSCoreDictionary objectForKey:@"VehRentalCore"] objectForKey:@"ReturnLocation"] objectForKey:@"@Name"];
    
    NSMutableArray *tempItems = [[NSMutableArray alloc] init];
    
    if ([[vehAvailRSCoreDictionary objectForKey:@"VehVendorAvails"] isKindOfClass:[NSArray class]]) {
        NSArray *rawVendorArray = [vehAvailRSCoreDictionary objectForKey:@"VehVendorAvails"];

        for (int i = 0; i < [rawVendorArray count]; i++) {

            NSDictionary *vendorDict = rawVendorArray[i];

            CTVendor *vendor = [[CTVendor alloc] initWithVendorInfo:vendorDict];
            
            if ([vendorDict[@"VehAvails"] isKindOfClass:[NSArray class]]) {
                NSArray *vehArray = vendorDict[@"VehAvails"];
                for (int k = 0; k < vehArray.count; k++) {
                    CTVehicle *vehicle = [[CTVehicle alloc] initFromDictionary:vehArray[k]];
                    CTAvailabilityItem *item = [[CTAvailabilityItem alloc] initWithVendor:vendor vehicle:vehicle];
                    [tempItems addObject:item];
                }
            }
        }
        
    } else {
        //only one vendor
        NSDictionary *vendorDict = [vehAvailRSCoreDictionary objectForKey:@"VehVendorAvails"];
        
        CTVendor *vendor = [[CTVendor alloc] initWithVendorInfo:vendorDict];
        
        if ([vendorDict[@"VehAvails"] isKindOfClass:[NSArray class]]) {
            NSArray *vehArray = vendorDict[@"VehAvails"];
            for (int k = 0; k < vehArray.count; k++) {
                CTVehicle *vehicle = [[CTVehicle alloc] initFromDictionary:vehArray[k]];
                CTAvailabilityItem *item = [[CTAvailabilityItem alloc] initWithVendor:vendor vehicle:vehicle];
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
