//
//  NetworkUtils.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//
//  TAKEN FROM: http://stackoverflow.com/questions/3266428/accessing-ip-address-with-nshost/3301169#3301169
//

#import "CTNetworkUtils.h"

@implementation CTNetworkUtils

+ (NSString *)IPAddress {

    NSString *defaultIp = @"127.0.0.1";//default

    NSURL *ipUrl = [NSURL URLWithString:@"http://checkip.dyndns.com/"];
    
    if (ipUrl) {
        
        NSURLRequest*   request  = [NSURLRequest requestWithURL:ipUrl cachePolicy:0 timeoutInterval:5];
        NSURLResponse*  response = nil;
        NSError*        error    = nil;
        NSData*         data     = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString* html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (!error) {
            NSScanner *scanner;
            scanner = [NSScanner scannerWithString:html];
            
            while (scanner.atEnd == NO) {
                NSError *error = nil;
                NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<*)(>*)(:*)([a-zA-Z]*)(\\s*)(/*)" options:NSRegularExpressionCaseInsensitive error:&error];
                NSString *modifiedString = [regex stringByReplacingMatchesInString:html options:0 range:NSMakeRange(0, [html length]) withTemplate:@""];
                return modifiedString;
            }
            return defaultIp;
        } else {
            return defaultIp;
        }
    } else {
        return defaultIp;
    }
}

@end
