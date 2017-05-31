//
//  CTInsuranceTipView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 31/05/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTInsuranceTipView : UIView

- (instancetype)initWithImageAndTextView:(NSString *)imageName text:(NSString *)text;

- (void)setText:(NSString *)text;

@end
