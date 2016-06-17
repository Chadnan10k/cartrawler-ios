//
//  LocationSelectView.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 03/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTMatchedLocation.h>
@interface CTSelectView : UIView

typedef void (^CTSelectionCompletion)(void);

@property (nonatomic, strong) CTSelectionCompletion viewTapped;

- (id)initWithView:(UIView *)view placeholder:(NSString *)placeholder;

- (void)setTextFieldText:(NSString *)text;

@end
