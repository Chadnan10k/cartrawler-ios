//
//  PaymentCard.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 15/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentCard.h"

@implementation CTPaymentCard

- (instancetype)initWithCardType:(CardType)cardType
            cardNumber:(NSString *)cardNumber
            cardExpiry:(NSString *)cardExpiry
        cardHolderName:(NSString *)cardHolderName
               cardCvc:(NSString *)cardCvc
{
    NSString *card;
    
    switch (cardType) {
        case CardTypeVisa:
            card = @"VI";
            break;
        case CardTypeMasterCard:
            card = @"MC";
            break;
        case CardTypeAmericanExpresss:
            card = @"MC";
            break;
        default:
            break;
    }
    
    _type = card;
    _number = cardNumber;
    _expiry = cardExpiry;
    _holderName = cardHolderName;
    _cvc = cardCvc;
    return self;
}

+ (CardType)cardType:(CardType)cardType
{
    return cardType;
}

@end
