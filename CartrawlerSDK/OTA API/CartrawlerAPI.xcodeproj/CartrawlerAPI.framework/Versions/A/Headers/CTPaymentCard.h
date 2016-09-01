//
//  PaymentCard.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 15/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTPaymentCard : NSObject

extern NSString *const CTCardTypeVisa;
extern NSString *const CTCardTypeMasterCard;
extern NSString *const CTCardTypeAmericanExpress;

@property (nonatomic, strong, readonly) NSString *type;
@property (nonatomic, strong, readonly) NSString *number;
@property (nonatomic, strong, readonly) NSString *expiry;
@property (nonatomic, strong, readonly) NSString *holderName;
@property (nonatomic, strong, readonly) NSString *cvc;

- (id)initWithCardType:(NSString *)cardType
            cardNumber:(NSString *)cardNumber
            cardExpiry:(NSString *)cardExpiry
        cardHolderName:(NSString *)cardHolderName
               cardCvc:(NSString *)cardCvc;

@end
