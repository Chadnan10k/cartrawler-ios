//
//  CTTabHeaderView.m
//  CartrawlerSDK
//
//  Created by Alan on 22/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTTabHeaderView.h"
#import "CTTabView.h"
#import "CTLayoutManager.h"

@interface CTTabHeaderView ()
@property (nonatomic, strong) CTLayoutManager *layoutManager;
@property (nonatomic, strong) NSArray *tabViews;
@end

@implementation CTTabHeaderView

- (instancetype)initWithTitles:(NSArray *)titles selectedIndex:(NSInteger)selectedIndex {
    self = [super init];
    if (self) {
        self.layoutManager = [CTLayoutManager layoutManagerWithContainer:self];
        self.layoutManager.orientation = CTLayoutManagerOrientationLeftToRight;
        self.layoutManager.justify = YES;
        
        NSMutableArray *mutableTabViews = [NSMutableArray new];
        [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
            CTTabView *tabView = [self tabViewWithTitle:title];
            tabView.selected = (idx == selectedIndex);
            [self.layoutManager insertView:UIEdgeInsetsZero view:tabView];
            [mutableTabViews addObject:tabView];
        }];
        
        [self.layoutManager layoutViews];
        self.tabViews = mutableTabViews.copy;
    }
    return self;
}

- (UILabel *)tabViewWithTitle:(NSString *)title {
    CTTabView *tabView = [CTTabView new];
    
    tabView.titleLabel.text = title;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabWasSelected:)];
    [tabView addGestureRecognizer:gestureRecognizer];
    
    return tabView;
}

- (void)tabWasSelected:(UITapGestureRecognizer *)gestureRecognizer {
    for (CTTabView *view in self.tabViews) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             view.selected = (view == gestureRecognizer.view);
                         }];
    }
    
    [self.delegate tabHeaderView:self didSelectTabAtIndex:[self.tabViews indexOfObject:gestureRecognizer.view]];
}

@end
