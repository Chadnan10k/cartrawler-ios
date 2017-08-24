//
//  NSDateUtils.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 14/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerAPI+NSData.h"

@implementation NSData (CartrawlerAPI)

- (NSString *)hexadecimalString{
	unsigned char *bytes = (unsigned char *)self.bytes;
	NSMutableString *ret = [NSMutableString stringWithCapacity:self.length*2];
	for(int i = 0; i < self.length; i++) {
		[ret appendFormat:@"%02x", bytes[i]];
	}
	return ret;
}
@end
