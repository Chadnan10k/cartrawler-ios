#import <Foundation/Foundation.h>

/**
 *  CTInsurance
 */
@interface CTInsurance : NSObject

/**
 *  ID of the insurance plan
 */
@property (nonatomic, strong, readonly) NSString *planID;
/**
 *  Name of the insurance plan
 */
@property (nonatomic, strong, readonly) NSString *name;
/**
 *  The url for the policy document
 */
@property (nonatomic, strong, readonly) NSURL *termsAndConditionsURL;
/**
 *  "Terms and condition"s localized string
 */
@property (nonatomic, strong, readonly) NSString *termsAndConditionsTitle;
/**
 *  The cost of the plan
 */
@property (nonatomic, strong, readonly) NSNumber *costAmount;
/**
 *  The cost currency code
 */
@property (nonatomic, strong, readonly) NSString *costCurrencyCode;
/**
 *  The premium amount
 */
@property (nonatomic, strong, readonly) NSNumber *premiumAmount;
/**
 *  The premium currency code
 */
@property (nonatomic, strong, readonly) NSString *premiumCurrencyCode;

@property (nonatomic, strong, readonly) NSString *title;

@property (nonatomic, strong, readonly) NSURL *imageURL;

@property (nonatomic, strong, readonly) NSString *paragraphFooter;

@property (nonatomic, strong, readonly) NSString *paragraphInfo;

@property (nonatomic, strong, readonly) NSString *paragraphSubfooter;

@property (nonatomic, strong, readonly) NSString *summary;

@property (nonatomic, strong, readonly) NSString *listTitle;

@property (nonatomic, strong, readonly) NSArray<NSString *> *listItems;

@property (nonatomic, strong, readonly) NSString *functionalText;

- (id)initFromDict:(NSDictionary *)dict;

@end
