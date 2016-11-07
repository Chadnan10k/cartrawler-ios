//
//  BookingSummaryButton.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "BookingSummaryButton.h"
#import "BookingSummaryViewController.h"
#import "CTLabel.h"

@interface BookingSummaryButton()

@property (strong, nonatomic) NSLayoutConstraint *topConstraint;
@property (strong, nonatomic) NSLayoutConstraint *bottomConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leftConstraint;
@property (strong, nonatomic) NSLayoutConstraint *rightConstraint;
@property (strong, nonatomic) BookingSummaryViewController *bookingSummaryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryHeight;

@property (strong, nonatomic) CTLabel *titleLabel;
@property (strong, nonatomic) UIButton *expandButton;

@end

@implementation BookingSummaryButton
{
    BOOL summaryVisible;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _titleLabel = [CTLabel new];
    _expandButton = [UIButton new];

    [self.expandButton setImage:[UIImage imageNamed:@"arrow"
                                           inBundle:[NSBundle bundleForClass:[self class]]
                      compatibleWithTraitCollection:nil]
                       forState:UIControlStateNormal];
    
    self.titleLabel.text = NSLocalizedString(@"Booking summary", @"Booking summary");
    
    self.expandButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.expandButton addTarget:self action:@selector(viewTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: self.expandButton];
    [self addSubview: self.titleLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[view]" options:0 metrics:nil views:@{@"view" : self.titleLabel }]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]" options:0 metrics:nil views:@{@"view" : self.titleLabel }]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[view(25)]" options:0 metrics:nil views:@{@"view" : self.expandButton }]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(25)]-8-|" options:0 metrics:nil views:@{@"view" : self.expandButton }]];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self addGestureRecognizer:tap];
    return self;
}

- (void)setDataWithVehicle:(CTAvailabilityItem *)vehicle
                pickupDate:(NSDate *)pickupDate
               dropoffDate:(NSDate *)dropoffDate
         isBuyingInsurance:(BOOL)isBuyingInsurance
{
    if (!self.bookingSummaryView) {

        NSBundle *b = [NSBundle bundleForClass:[self class]];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StepFive" bundle:b];
        _bookingSummaryView = [storyboard instantiateViewControllerWithIdentifier:@"BookingSummaryView"];
    }
    [self.bookingSummaryView setDataWithVehicle:vehicle
                                     pickupDate:pickupDate
                                    dropoffDate:dropoffDate
                              isBuyingInsurance:isBuyingInsurance];
}

- (void)closeIfOpen
{
    if (summaryVisible) {
        self.summaryHeight.constant = 50;
        
        [self removeConstraints:@[self.topConstraint,
                                  self.bottomConstraint,
                                  self.leftConstraint,
                                  self.rightConstraint]];
        
        [self.bookingSummaryView.view removeFromSuperview];
        summaryVisible = NO;
    }
}

- (void)closeView
{
    if (summaryVisible) {
        
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.2
              initialSpringVelocity:0.2
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.expandButton.transform = CGAffineTransformMakeRotation(0);
                         } completion:nil];
        
        self.summaryHeight.constant = 50;
        
        [self removeConstraints:@[self.topConstraint,
                                  self.bottomConstraint,
                                  self.leftConstraint,
                                  self.rightConstraint]];
        
        [self.bookingSummaryView.view removeFromSuperview];
        summaryVisible = NO;
    } else {
        
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.2
              initialSpringVelocity:0.2
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.expandButton.transform = CGAffineTransformMakeRotation(M_PI_2);
                         } completion:nil];
        
        self.summaryHeight.constant = 320;
        
        
        [self addSubview:self.bookingSummaryView.view];
        
        self.bookingSummaryView.view.translatesAutoresizingMaskIntoConstraints = false;
        self.translatesAutoresizingMaskIntoConstraints = false;
        
        self.topConstraint = [NSLayoutConstraint constraintWithItem:self.bookingSummaryView.view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:50];
        
        self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.bookingSummaryView.view
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0
                                                              constant:0];
        
        self.leftConstraint = [NSLayoutConstraint constraintWithItem:self.bookingSummaryView.view
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0
                                                            constant:5];
        
        self.rightConstraint = [NSLayoutConstraint constraintWithItem:self.bookingSummaryView.view
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0
                                                             constant:-5];
        [self addConstraints:@[self.topConstraint,
                               self.bottomConstraint,
                               self.leftConstraint,
                               self.rightConstraint]];
        
        summaryVisible = YES;
    }
}

- (IBAction)viewTapped:(id)sender
{
    [self closeView];
}

@end
