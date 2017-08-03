//
//  ViewController.m
//  TestApp
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ViewController.h"
#import "StandaloneViewController.h"
#import <CartrawlerSDK/CartrawlerSDK.h>
#import <AVFoundation/AVFoundation.h>


#import "RYRRentalManager.h"
#import "InPathViewController.h"

@interface ViewController ()
@property (nonatomic) CartrawlerSDK *sdk;
@property (nonatomic) AVAudioPlayer *audioPlayer;
@end

@implementation ViewController

- (IBAction)startButtonTapped:(id)sender {
//    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"car+start3" ofType:@"mp3"]];
//    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//    [self.audioPlayer play];
    
    self.sdk = [[CartrawlerSDK alloc] initWithlanguageCode:@"en" sandboxMode:YES];
    [self.sdk setNewSession];
    [self.sdk presentInParentViewController:self];
}

@end
