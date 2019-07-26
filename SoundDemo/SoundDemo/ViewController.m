//
//  ViewController.m
//  SoundDemo
//
//  Created by Tom Belov on 21/07/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"
@import AudioToolbox;
@import AVFoundation.AVFAudio.AVAudioPlayer;

@interface ViewController ()

@property (assign, nonatomic) SystemSoundID beepA;
@property (assign, nonatomic) SystemSoundID beepB;
@property (assign, nonatomic) BOOL beepAGood;
@property (assign, nonatomic) BOOL beepBGood;
@property (assign, nonatomic) BOOL songGood;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *soundAPath = [[NSBundle mainBundle] pathForResource:@"soundA" ofType:@"aif"];
    NSURL *urlA = [NSURL fileURLWithPath:soundAPath];
    
    NSString *soundBPath = [[NSBundle mainBundle] pathForResource:@"soundB" ofType:@"aif"];
    NSURL *urlB = [NSURL fileURLWithPath:soundBPath];
    
    NSString *drumsTrackPath = [[NSBundle mainBundle] pathForResource:@"Drums" ofType:@"m4a"];
    NSURL *songUrl = [NSURL fileURLWithPath:drumsTrackPath];
    
    OSStatus statusReportA = AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlA, &_beepA);
    
    if (statusReportA == kAudioServicesNoError) {
        self.beepAGood = YES;
    } else {
        self.beepAGood = NO;
        UIAlertController *alertA = [UIAlertController alertControllerWithTitle:@"Couldn't load beep" message:@"BeepA problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertA animated:YES completion:nil];
    }
    
    OSStatus statusReportB = AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlB, &_beepB);
    
    if (statusReportB == kAudioServicesNoError) {
        self.beepBGood = YES;
    } else {
        self.beepBGood = NO;
        UIAlertController *alertB = [UIAlertController alertControllerWithTitle:@"Couldn't load beep" message:@"BeepB problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertB animated:YES completion:nil];
    }
    
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:songUrl error:&error];
    
    if (!self.audioPlayer) {
        self.songGood = NO;
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"Couldn't load file m4a" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:nil];
    } else {
        self.songGood = YES;
    }
}

- (IBAction)playSoundATapped:(id)sender {
    if (!self.beepAGood) {
        return;
    }
    AudioServicesPlaySystemSound(_beepA);
}

- (IBAction)playSoundBTapped:(id)sender {
    if (!self.beepBGood) {
        return;
    }
    AudioServicesPlaySystemSound(_beepB);
}

- (IBAction)playMediaTapped:(id)sender {
    if (self.songGood) {
        [self.audioPlayer play];
    }
}

- (IBAction)stopPlayingMediaTapped:(id)sender {
    if (self.songGood) {
        [self.audioPlayer stop];
    }
}

- (void)dealloc {
    if (self.beepAGood) {
        AudioServicesDisposeSystemSoundID(self.beepAGood);
    }
    
    if (self.beepBGood) {
        AudioServicesDisposeSystemSoundID(self.beepBGood);
    }
}

@end
