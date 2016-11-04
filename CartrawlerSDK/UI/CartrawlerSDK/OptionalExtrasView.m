//
//  OptionalExtrasView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "OptionalExtrasView.h"
#import "OptionalExtraTableViewCell.h"
#import "CTTextView.h"

@interface OptionalExtrasView() <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIButton *expandButton;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CTTextView *textView;

@end

@implementation OptionalExtrasView
{
    BOOL isOpen;
}

+ (void)forceLinkerLoad_
{
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(drawerControl:)];
    [self addGestureRecognizer:tap];
    return self;
}

- (void)hideView:(BOOL)hide
{
    NSLayoutConstraint *heightConstraint;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            heightConstraint = constraint;
            break;
        }
    }
    
    if (hide) {
        heightConstraint.constant = 0;
        self.alpha = 0;
    } else {
        heightConstraint.constant = 50;
        self.alpha = 1;
    }
    
}

- (void)hideExpandbutton:(BOOL)hide
{
    if (hide) {
        self.expandButton.alpha = 0;
    } else {
        self.expandButton.alpha = 1;
    }
}

- (void)open:(BOOL)hideExpandButton
{
    
//    if (self.tableView && self.textView) {
//        [self close];
//    }
    
    if (hideExpandButton) {
        self.expandButton.alpha = 0;
    } else {
        self.expandButton.alpha = 1;
    }
    
    isOpen = YES;
    [self.expandButton setTitle:@"-" forState:UIControlStateNormal];
    _textView = [[CTTextView alloc] initWithFrame:CGRectZero];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.allowsSelection = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 75;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    [self.tableView registerNib:[UINib nibWithNibName:@"OptionalExtraTableViewCell" bundle:bundle] forCellReuseIdentifier:@"cell"];
    
    self.textView.scrollEnabled = NO;
    self.textView.selectable = NO;
    
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.textView];
    [self addSubview:self.tableView];
    
    //create textview
    
    NSString *extrasTitle = NSLocalizedString(@"Add a request for an additional driver, GPS, child seat or other extras. You will pay for these extras directly at the car rental supplier service desk on pick-up. Please note that availability of these extras is not always guaranteed", @"extras info");
    
    self.textView.text = extrasTitle;
    
    CGFloat textViewHeight = [self textViewHeightForAttributedText:self.textView.attributedText
                                                          andWidth:self.initialFrame.size.width - 10];
    
    NSLayoutConstraint *textviewTopConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:40];
    
    NSLayoutConstraint *textviewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:textViewHeight];
    
    NSLayoutConstraint *textviewLeftConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:5];
    
    NSLayoutConstraint *textviewRightConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:-5];
    [self addConstraints:@[textviewTopConstraint,
                            textviewHeightConstraint,
                            textviewLeftConstraint,
                            textviewRightConstraint]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];

    CGFloat tableViewHeight = self.tableView.contentSize.height;
    
    NSLayoutConstraint *tableviewTopConstraint = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.textView
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:8];
    
    NSLayoutConstraint *tableviewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:tableViewHeight];
    
    NSLayoutConstraint *tableviewLeftConstraint = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:5];
    
    NSLayoutConstraint *tableviewRightConstraint = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:-5];
    [self addConstraints:@[tableviewTopConstraint,
                           tableviewHeightConstraint,
                           tableviewLeftConstraint,
                           tableviewRightConstraint]];
    
    
    //create tableview
    
    NSLayoutConstraint *heightConstraint;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            heightConstraint = constraint;
            break;
        }
    }
    
    [self.tableView layoutIfNeeded];
    
    tableViewHeight = self.tableView.contentSize.height;

    
    heightConstraint.constant = textViewHeight + tableViewHeight + 56;
}

- (IBAction)drawerControl:(id)sender
{
    if (isOpen) {
        [self close];
    } else {
        [self open:!self.expandButton.alpha];
    }
}

- (CGFloat)textViewHeightForAttributedText:(NSAttributedString *)text andWidth:(CGFloat)width
{
    UITextView *textView = [[UITextView alloc] init];
    textView.attributedText = text;
    CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}

- (void)close
{
    if (!self.textView || !self.tableView) {
        return;
    }
    isOpen = NO;
    [self.expandButton setTitle:@"+" forState:UIControlStateNormal];
    [self removeConstraints:self.textView.constraints];
    [self removeConstraints:self.tableView.constraints];
    [self.tableView removeFromSuperview];
    [self.textView removeFromSuperview];
    
    NSLayoutConstraint *heightConstraint;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            heightConstraint = constraint;
            break;
        }
    }
    heightConstraint.constant = 50;

}

#pragma mark Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.extras.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionalExtraTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setData:self.extras[indexPath.row]];
    return cell;
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 65;
//}


@end
