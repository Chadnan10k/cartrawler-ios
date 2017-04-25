#import "CTInsuranceAddedView.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTButton.h>
#import <CartrawlerSDK/CTAppearance.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTInsuranceAddedView()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *shieldImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) CTButton *removeButton;
@property (nonatomic, strong) CTLabel *headerLabel;
@property (nonatomic, strong) CTLabel *subheaderLabel;

@end

@implementation CTInsuranceAddedView

- (instancetype)init
{
    self = [super init];
    [self createBackgroundView];
    [self buildAddedState];
    return self;
}

- (void)createBackgroundView
{
    _backgroundView = [UIView new];
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.backgroundView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[backgroundView(0@100)]-0-|" options:0 metrics:nil views:@{@"backgroundView" : self.backgroundView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[backgroundView]-0-|" options:0 metrics:nil views:@{@"backgroundView" : self.backgroundView}]];
}

- (void)buildAddedState
{
    NSBundle *b = [NSBundle bundleForClass:[self class]];

    _backgroundImageView = [UIImageView new];
    UIImage *background = [UIImage imageNamed:@"insurance_background" inBundle:b compatibleWithTraitCollection:nil];
    self.backgroundImageView.image = background;
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundImageView.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:144.0/255.0 blue:228.0/255.0 alpha:1];
    [self.backgroundView addSubview:self.backgroundImageView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[backgroundImage(250)]-0-|" options:0 metrics:nil views:@{@"backgroundImage" : self.backgroundImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[backgroundImage]-0-|" options:0 metrics:nil views:@{@"backgroundImage" : self.backgroundImageView}]];
    
    _shieldImageView = [UIImageView new];
    self.shieldImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.shieldImageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *shield = [UIImage imageNamed:@"shield_added" inBundle:b compatibleWithTraitCollection:nil];
    self.shieldImageView.image = shield;
    [self.backgroundView addSubview:self.shieldImageView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[shieldImage(100)]" options:0 metrics:nil views:@{@"shieldImage" : self.shieldImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[shieldImage]-|" options:0 metrics:nil views:@{@"shieldImage" : self.shieldImageView}]];
    
    _headerLabel = [[CTLabel alloc] init:21 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter boldFont:YES];
    self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerLabel.text = CTLocalizedString(CTRentalInsuranceAddedHeader);
    [self.backgroundView addSubview:self.headerLabel];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[shieldImage]-[headerLabel]" options:0 metrics:nil views:@{@"headerLabel" : self.headerLabel, @"shieldImage" : self.shieldImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[headerLabel]-|" options:0 metrics:nil views:@{@"headerLabel" : self.headerLabel}]];
    
    _subheaderLabel = [[CTLabel alloc] init:17 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter boldFont:NO];
    self.subheaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subheaderLabel.text = CTLocalizedString(CTRentalInsuranceAddedSubheader);
    [self.backgroundView addSubview:self.subheaderLabel];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headerLabel]-[subheaderLabel]" options:0 metrics:nil views:@{@"subheaderLabel" : self.subheaderLabel, @"headerLabel" : self.headerLabel}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[subheaderLabel]-|" options:0 metrics:nil views:@{@"subheaderLabel" : self.subheaderLabel}]];
    
    _removeButton = [[CTButton alloc] init:[UIColor clearColor] fontColor:[UIColor whiteColor] boldFont:YES borderColor:[UIColor whiteColor]];
    [self.removeButton addTarget:self action:@selector(removeInsurance:) forControlEvents:UIControlEventTouchUpInside];
    self.removeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.removeButton setTitle:CTLocalizedString(CTRentalInsuranceRemoveButtonTitle) forState:UIControlStateNormal];
    [self.backgroundView addSubview:self.removeButton];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subheaderLabel]-8@100-[removeButton(40)]-|" options:0 metrics:nil views:@{@"subheaderLabel" : self.subheaderLabel, @"removeButton" : self.removeButton}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[removeButton]-|" options:0 metrics:nil views:@{@"removeButton" : self.removeButton}]];
}

- (void)removeInsurance:(id)sender
{
    if (self.removeAction) {
        self.removeAction();
    }
}

@end
