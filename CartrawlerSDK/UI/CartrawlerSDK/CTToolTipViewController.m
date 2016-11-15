//
//  CTToolTipViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 15/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTToolTipViewController.h"
#import "CTLabel.h"
#import "CTTextView.h"
#import "CTAppearance.h"

@interface CTToolTipViewController ()
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet CTLabel *tipTitleLabel;
@property (weak, nonatomic) IBOutlet CTTextView *detailTextView;
@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) NSString *detailText;

@end

@implementation CTToolTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [CTAppearance instance].tooltipBackgroundColor;
    self.closeButton.tintColor = [UIColor whiteColor];
    
    self.tipTitleLabel.text = self.titleText ?: @"";
    self.detailTextView.text = self.detailText ?: @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTitle:(NSString *)title text:(NSString *)text
{
    _titleText = title;
    _detailText = text;
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
