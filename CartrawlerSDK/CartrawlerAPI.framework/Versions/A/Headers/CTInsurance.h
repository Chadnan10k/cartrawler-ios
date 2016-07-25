#import <Foundation/Foundation.h>
#import "InsuranceSelectorItem.h"
#import "InsuranceLink.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  CTInsurance
 */
@interface CTInsurance : NSObject

/**
 *  ID of the insurance plan
 */
@property (nonatomic, strong, readonly, nonnull) NSString *planID;
/**
 *  Name of the insurance plan
 */
@property (nonatomic, strong, readonly, nonnull) NSString *name;
/**
 *  The url for the policy document
 */
@property (nonatomic, strong, readonly, nonnull) NSURL *termsAndConditionsURL;
/**
 *  "Terms and condition"s localized string
 */
@property (nonatomic, strong, readonly, nonnull) NSString *termsAndConditionsTitle;
/**
 *  The cost of the plan
 */
@property (nonatomic, strong, readonly, nonnull) NSNumber *costAmount;
/**
 *  The cost currency code
 */
@property (nonatomic, strong, readonly, nonnull) NSString *costCurrencyCode;
/**
 *  The premium amount
 */
@property (nonatomic, strong, readonly, nonnull) NSNumber *premiumAmount;
/**
 *  The premium currency code
 */
@property (nonatomic, strong, readonly, nonnull) NSString *premiumCurrencyCode;

@property (nonatomic, strong, readonly, nonnull) NSString *title;

@property (nonatomic, strong, readonly, nonnull) NSURL *imageURL;

@property (nonatomic, strong, readonly, nullable) NSString *paragraphFooter;

@property (nonatomic, strong, readonly, nullable) NSString *paragraphInfo;

@property (nonatomic, strong, readonly, nullable) NSString *paragraphSubfooter;

@property (nonatomic, strong, readonly, nullable) NSString *summary;

@property (nonatomic, strong, readonly, nullable) NSString *listTitle;

@property (nonatomic, strong, readonly, nullable) NSArray<NSString *> *listItems;

@property (nonatomic, strong, readonly, nullable) NSString *functionalText;

@property (nonatomic, strong, readonly, nullable) NSString *selectorTitle;
@property (nonatomic, strong, readonly, nullable) NSArray <InsuranceSelectorItem *> *selectorItems;
@property (nonatomic, strong, readonly, nullable) NSArray <InsuranceLink *> *links;

- (id)initFromDict:(NSDictionary *)dict;

@end
NS_ASSUME_NONNULL_END
