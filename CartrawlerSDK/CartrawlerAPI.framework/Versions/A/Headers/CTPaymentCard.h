//
//  PaymentCard.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 15/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  CTPaymentCard
 */
@interface CTPaymentCard : NSObject

/**
 *  Card Type enum
 */
typedef NS_ENUM(NSUInteger, CardType) {
    /**
     *  For Visa cards
     */
    CardTypeVisa = 0,
    /**
     *  For MasterCard's
     */
    CardTypeMasterCard,
    /**
     *  For American Express cards
     */
    CardTypeAmericanExpresss
};

/**
 *  The card type in string form
 */
@property (nonatomic, strong, readonly) NSString *type;
/**
 *  The card number
 */
@property (nonatomic, strong, readonly) NSString *number;
/**
 *  The card expiry in string form
 */
@property (nonatomic, strong, readonly) NSString *expiry;
/**
 *  The card holder name
 */
@property (nonatomic, strong, readonly) NSString *holderName;
/**
 *  The cards security number
 */
@property (nonatomic, strong, readonly) NSString *cvc;

/**
 *  Creates a Payment Card Object
 *
 *  @param cardType       Must be: VI for Visa, MC for Mastercard, AX for Amex
 *  @param cardNumber     Payment card number
 *  @param cardExpiry     Payment card expiry
 *  @param cardHolderName Cardholder name
 *  @param cardCvc        Payment card security number
 *
 *  @return Initialized payment card object
 */
- (instancetype)initWithCardType:(CardType)cardType
            cardNumber:(NSString *)cardNumber
            cardExpiry:(NSString *)cardExpiry
        cardHolderName:(NSString *)cardHolderName
               cardCvc:(NSString *)cardCvc;

/**
 *  Convenience method for getting the CardType
 *
 *  @param cardType The card type
 *
 *  @return returns CardType
 */
+ (CardType)cardType:(CardType)cardType;
@end
