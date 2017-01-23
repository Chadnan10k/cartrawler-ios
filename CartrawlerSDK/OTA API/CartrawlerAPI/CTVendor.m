//
//  Vendor.m
//  CarTrawler
//

#import "CTVendor.h"
#import "CTVehicle.h"
#import "CartrawlerAPI+NSURL.h"

@implementation CTVendor

- (instancetype)initWithVendorInfo:(NSDictionary *)vendorInfo
{
    self = [super init];
    _code     = vendorInfo[@"Vendor"][@"@Code"];
    _name     = vendorInfo[@"Vendor"][@"@CompanyShortName"];
    _division = vendorInfo[@"Vendor"][@"@Division"];
    _logoURL  = [NSURL vendor:vendorInfo[@"Info"][@"TPA_Extensions"][@"VendorPictureURL"][@"#text"] ?: @""];
    
    NSDictionary *ratingDict = vendorInfo[@"Info"][@"TPA_Extensions"][@"CustomerReviews"];
    if (ratingDict != nil) {
        _rating = [[CTVendorRating alloc] initFromDictionary: ratingDict];
    }
    
    if ([vendorInfo[@"Info"][@"LocationDetails"] isKindOfClass:[NSArray class]]) {
        _pickupLocation = [[CTVendorLocation alloc] initWithDictionary:vendorInfo[@"Info"][@"LocationDetails"][0]];
        _dropoffLocation = [[CTVendorLocation alloc] initWithDictionary:vendorInfo[@"Info"][@"LocationDetails"][1]];
    } else {
        CTVendorLocation *location = [[CTVendorLocation alloc] initWithDictionary:vendorInfo[@"Info"][@"LocationDetails"]];
        _pickupLocation = location;
        _dropoffLocation = location;
    }
    
    return self;
}

@end
