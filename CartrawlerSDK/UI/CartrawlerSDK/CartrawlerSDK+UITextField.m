//
//  CartrawlerSDK+UITextField.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CartrawlerSDK+UITextField.h"
#import "CTAppearance.h"

@implementation UITextField (CartrawlerSDK)

- (void)addDoneButton
{
    {
        UIToolbar* toolbar = [[UIToolbar alloc]initWithFrame:CGRectZero];
        [toolbar setBarStyle:UIBarStyleDefault];
        [toolbar setTranslucent:NO];
        
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:20.0]} forState:UIControlStateNormal];
        
        toolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneTapped)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
        
        [toolbar sizeToFit];
        self.inputAccessoryView = toolbar;
    }
}

@end
