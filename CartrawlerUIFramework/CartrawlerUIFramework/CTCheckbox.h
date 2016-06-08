//
//  CTCheckbox.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 07/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTCheckbox : UIView

typedef void (^SelectionCompletion)(BOOL selection);

@property (nonatomic, strong) SelectionCompletion viewTapped;

- (id)initEnabled:(BOOL)enabled containerView:(UIView *)containerView;

@end
