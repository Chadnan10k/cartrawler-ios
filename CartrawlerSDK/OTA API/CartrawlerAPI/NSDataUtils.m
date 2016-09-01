//
//  NSDateUtils.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 14/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "NSDataUtils.h"

@implementation NSDataUtils

+ (NSString *)hexadecimalString:(NSData *)data {
	unsigned char *bytes = (unsigned char *)data.bytes;
	NSMutableString *ret = [NSMutableString stringWithCapacity:data.length*2];
	for(int i = 0; i < data.length; i++) {
		[ret appendFormat:@"%02x", bytes[i]];
	}
	return ret;
}
@end
