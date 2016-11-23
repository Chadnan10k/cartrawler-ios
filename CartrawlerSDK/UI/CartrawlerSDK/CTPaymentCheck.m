//
//  CTPaymentCheck.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 22/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentCheck.h"

@interface CTPaymentCheck()

typedef void (^ CTPaymentCheckResponse)(CTPaymentStatus response);

@property (nonatomic, strong) NSString *requestorId;
@property (nonatomic) BOOL sandboxMode;
@property (nonatomic, strong) NSDate *pickupDate;
@property (nonatomic, strong) NSString *email;
@property (nonatomic) BOOL shouldStop;

@end

@implementation CTPaymentCheck {
    BOOL performingRequest;
    NSURLSessionDataTask *task;
    NSDictionary *responseDict;
    NSURLSession *session;
}

- (instancetype)initWithRequestorId:(NSString *)requestorId
              sandboxMode:(BOOL)sandboxMode
               pickupDate:(NSDate *)pickupDate
                    email:(NSString *)email
{
    self = [super init];
    _requestorId = requestorId;
    _sandboxMode = sandboxMode;
    _email = email;
    _pickupDate = pickupDate;
    return self;
}

- (void)start
{
    _shouldStop = NO;
    //[self check];
}

- (void)stop
{
    _shouldStop = YES;
}

- (void)check
{
    __weak typeof (self) weakself = self;

    [self performRequest:self.sandboxMode
                jsonBody:[self buildJson:self.pickupDate email:self.email]
              completion:^(CTPaymentStatus response) {
                  if (!weakself.shouldStop) {
                      if (weakself.delegate) {
                          [weakself.delegate checkDidReceiveResponse:response];
                      }
                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                          [weakself check];
                      });
                  }
              }];
}

- (void)performRequest:(BOOL)sandboxMode
              jsonBody:(NSString *)jsonBody
            completion:(CTPaymentCheckResponse)completion
{
    NSLog(@"making check");
    NSString *endPoint = @"";
    
    if (sandboxMode) {
        endPoint = @"https://external-dev.cartrawler.com/cartrawlerota/json?type=OTA_VehRetResRQ";
    } else {
        endPoint = @"https://otageo.cartrawler.com/cartrawlerota/json?type=OTA_VehRetResRQ";
    }
    
    NSURL *url = [NSURL URLWithString: endPoint];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:Nil];
    
    if (jsonBody != nil && endPoint != nil && ![jsonBody isEqualToString:@""]) {
        
        NSData *processedData = [jsonBody dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        request.URL = url;
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        request.HTTPBody = processedData;
        request.timeoutInterval = 5;
        
        task = [session dataTaskWithRequest:request
                          completionHandler:
                ^(NSData *data, NSURLResponse *response, NSError *error) {
                    NSError *serializationError;
                    if (data != nil) {
                        responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
                        if (responseDict[@"Errors"] != nil || responseDict[@"@ErrorCode"] != nil || responseDict == nil) {
                            completion(CTPaymentStatusNotAvailable);
                        } else {
                            completion(CTPaymentStatusSuccess);//send booking ref here
                        }

                    } else {
                        completion(CTPaymentStatusError);
                    }
                }];
        [task resume];
        [session finishTasksAndInvalidate];
    } else {
        completion(CTPaymentStatusError);

    }
}


- (NSString *)buildJson:(NSDate *)date email:(NSString *)email
{
    NSString *endpoint = @"";
    if (self.sandboxMode) {
        endpoint = @"Test";
    } else {
        endpoint = @"Production";
    }
    
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [df stringFromDate:date];
    
    //json needs specific ordering
    NSString *json = [NSString stringWithFormat:
    @"{"
    "    \"@xmlns\": \"http://www.opentravel.org/OTA/2003/05\", "
    "    \"@xmlns:xsi\": \"http://www.w3.org/2001/XMLSchema-instance\", "
    "    \"@xsi:schemaLocation\": \"http://www.opentravel.org/OTA/2003/05 OTA_VehRetResRQ.xsd\", "
    "    \"@Target\": \"%@\", "
    "    \"@Version\": \"1.002\", "
    "    \"POS\": { "
    "        \"Source\": { "
    "            \"RequestorID\": { "
    "                \"@Type\": \"16\", "
    "                \"@ID\": \"%@\", "
    "                \"@ID_Context\": \"CARTRAWLER\" "
    "            } "
    "        } "
    "    }, "
    "    \"VehRetResRQCore\": { "
    "        \"TPA_Extensions\": { "
    "            \"PickupDate\": \"%@\", "
    "            \"Email\": \"%@\" "
    "        } "
    "    } "
    "} ", endpoint, self.requestorId, dateStr, email];
    
    return json;
}

@end
