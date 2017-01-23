//
//  CTTermsDetailViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 05/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTTermsDetailViewController.h"

@interface CTTermsDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *navTitleLabel;
@property (strong, nonatomic) CTTermAndCondition *data;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation CTTermsDetailViewController

{}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.textView.layer.cornerRadius = 5;
//    self.textView.layer.masksToBounds = YES;
    self.textView.text = self.data.bodyText;
    self.textView.scrollEnabled = NO;

    self.navTitleLabel.text = self.data.titleText;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.textView.scrollEnabled = YES;
}

//
//- (void)viewDidLayoutSubviews {
//    [self.textView setContentOffset:CGPointZero animated:NO];
//}

- (void)setData:(CTTermAndCondition *)data
{
    _data = data;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
