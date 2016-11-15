//
//  CTNextButton.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTNextButton : UIView

typedef void (^CTToolTipButtonTapped)(void);

- (void)setText:(NSString *)text didTap:(CTToolTipButtonTapped)didTap;

@end
