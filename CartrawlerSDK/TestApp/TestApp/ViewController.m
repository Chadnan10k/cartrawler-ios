//
//  ViewController.m
//  TestApp
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ViewController.h"
#import <CartrawlerSDK/CartrawlerSDK.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (nonatomic) CartrawlerSDK *sdk;
@property (nonatomic) BOOL productionEnvironment;
@property (weak, nonatomic) IBOutlet UILabel *version;
@property (nonatomic) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UILabel *testApp;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIImageView *startEngine;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    NSString *build = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
    self.version.text = [NSString stringWithFormat:@"Version: %@ (%@)", version, build];
    self.segmentedControl.alpha = 0;
    self.startEngine.alpha = 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        self.testApp.frame = CGRectZero;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.segmentedControl.alpha = 1;
            self.startEngine.alpha = 1;
        }];
    }];
    
}

- (IBAction)startButtonTapped:(id)sender {
//    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"car+start3" ofType:@"mp3"]];
//    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//    [self.audioPlayer play];
    
    self.sdk = [[CartrawlerSDK alloc] initWithlanguageCode:@"en" sandboxMode:!self.productionEnvironment];
    [self.sdk setNewSession];
    [self.sdk presentInParentViewController:self];
}
- (IBAction)segmentedControlWasTapped:(UISegmentedControl *)sender {
    self.productionEnvironment = sender.selectedSegmentIndex;
}

@end
