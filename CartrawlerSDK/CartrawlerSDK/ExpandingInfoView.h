//
//  ExpandingInfoView.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandingInfoView : UIView

+ (void)forceLinkerLoad_;

- (void)setTitle:(NSString *)title text:(NSString *)text image:(UIImage *)image;

@end
