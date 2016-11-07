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

    if (self.textView) {
        [self.textView removeFromSuperview];
    }
    
    if (self.tableView) {
        [self.tableView removeFromSuperview];
    }
    
    if (hideExpandButton) {
        self.expandButton.alpha = 0;
    } else {
        self.expandButton.alpha = 1;
    }
    
    isOpen = YES;
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
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textView]-|" options:0
                                                                 metrics:nil
                                                                   views:@{ @"textView" : self.textView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[expand]-8-[textView(height)]" options:0
                                                                 metrics:@{ @"height" : [NSNumber numberWithFloat:textViewHeight] }
                                                                   views:@{ @"textView" : self.textView, @"expand" : self.expandButton }]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];

    CGFloat tableViewHeight = self.tableView.contentSize.height;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[table]-8-|" options:0
                                                                 metrics:nil
                                                                   views:@{ @"table" : self.tableView }]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[text]-8-[table]" options:0
                                                                 metrics:@{ @"height" : [NSNumber numberWithFloat:tableViewHeight] }
                                                                   views:@{ @"table" : self.tableView, @"text" : self.textView }]];
    
    [self.tableView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[table(height)]" options:0
                                                                 metrics:@{ @"height" : [NSNumber numberWithFloat:tableViewHeight] }
                                                                   views:@{ @"table" : self.tableView}]];
    
    
    //create tableview
    
    NSLayoutConstraint *heightConstraint;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            heightConstraint = constraint;
            break;
        }
    }
    
    [self.tableView layoutIfNeeded];
    
    NSLayoutConstraint *tableHeight;
    for (NSLayoutConstraint *constraint in self.tableView.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            tableHeight = constraint;
            break;
        }
    }
    
    tableViewHeight = self.tableView.contentSize.height;    
    heightConstraint.constant = textViewHeight + tableHeight.constant + 72;
}

- (IBAction)drawerControl:(id)sender
{
    if (!self.disableAccordion) {
        if (isOpen) {
            [UIView animateWithDuration:0.5
                                  delay:0
                 usingSpringWithDamping:0.2
                  initialSpringVelocity:0.2
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.expandButton.transform = CGAffineTransformMakeRotation(0);
                             } completion:nil];
            [self close];
        } else {
            [UIView animateWithDuration:0.5
                                  delay:0
                 usingSpringWithDamping:0.2
                  initialSpringVelocity:0.2
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.expandButton.transform = CGAffineTransformMakeRotation(M_PI_2);
                             } completion:nil];
            [self open:!self.expandButton.alpha];
        }
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

@end
