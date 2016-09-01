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
@property (nonatomic, readonly, nonnull) NSString *planID;
/**
 *  Name of the insurance plan
 */
@property (nonatomic, readonly, nonnull) NSString *name;
/**
 *  The url for the policy document
 */
@property (nonatomic, readonly, nonnull) NSURL *termsAndConditionsURL;
/**
 *  "Terms and condition"s localized string
 */
@property (nonatomic, readonly, nonnull) NSString *termsAndConditionsTitle;
/**
 *  The cost of the plan
 */
@property (nonatomic, readonly, nonnull) NSNumber *costAmount;
/**
 *  The cost currency code
 */
@property (nonatomic, readonly, nonnull) NSString *costCurrencyCode;
/**
 *  The premium amount
 */
@property (nonatomic, readonly, nonnull) NSNumber *premiumAmount;
/**
 *  The premium currency code
 */
@property (nonatomic, readonly, nonnull) NSString *premiumCurrencyCode;

@property (nonatomic, readonly, nonnull) NSString *title;

@property (nonatomic, readonly, nonnull) NSURL *imageURL;

@property (nonatomic, readonly, nullable) NSString *paragraphFooter;

@property (nonatomic, readonly, nullable) NSString *paragraphInfo;

@property (nonatomic, readonly, nullable) NSString *paragraphSubfooter;

@property (nonatomic, readonly, nullable) NSString *summary;

@property (nonatomic, readonly, nullable) NSString *listTitle;

@property (nonatomic, readonly, nullable) NSArray<NSString *> *listItems;

@property (nonatomic, readonly, nullable) NSString *functionalText;

@property (nonatomic, readonly, nullable) NSString *selectorTitle;
@property (nonatomic, readonly, nullable) NSArray <InsuranceSelectorItem *> *selectorItems;
@property (nonatomic, readonly, nullable) NSArray <InsuranceLink *> *links;

- (instancetype)initFromDict:(NSDictionary *)dict  ;

@end
NS_ASSUME_NONNULL_END
