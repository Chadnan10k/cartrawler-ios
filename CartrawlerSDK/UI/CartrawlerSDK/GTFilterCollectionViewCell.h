//
//  GTFilterCollectionViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTFilterCollectionViewCell : UICollectionViewCell

typedef NS_ENUM(NSUInteger, GTFilterType) {
    
    GTFilterTypeShuttle = 0,
    
    GTFilterTypeService,
    
    GTFilterTypeNone
};

@property (nonatomic) GTFilterType filterType;
@property (nonatomic, strong) NSString *price;

- (void)setFilterType:(GTFilterType)filterType price:(NSString *)price;
- (void)animate;

+ (void)forceLinkerLoad_;

@end
