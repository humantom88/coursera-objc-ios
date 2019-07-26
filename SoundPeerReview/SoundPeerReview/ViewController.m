//
//  ViewController.m
//  SoundPeerReview
//
//  Created by Tom Belov on 25/07/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"
@import AudioToolbox;
@import AVFoundation.AVFAudio.AVAudioPlayer;

@interface ViewController ()

@property (strong, nonatomic) AVAudioPlayer *trackPlayer;
@property (strong, nonatomic) AVAudioPlayer *floorTomPlayer;
@property (strong, nonatomic) AVAudioPlayer *snarePlayer;
@property (strong, nonatomic) AVAudioPlayer *leftTomPlayer;
@property (strong, nonatomic) AVAudioPlayer *rightTomPlayer;
@property (strong, nonatomic) AVAudioPlayer *hatPlayer;
@property (strong, nonatomic) AVAudioPlayer *crashPlayer;

@property (assign, nonatomic) BOOL floorTomGood;
@property (assign, nonatomic) BOOL snareGood;
@property (assign, nonatomic) BOOL leftTomGood;
@property (assign, nonatomic) BOOL rightTomGood;
@property (assign, nonatomic) BOOL hatGood;
@property (assign, nonatomic) BOOL crashGood;

@end

@implementation ViewController

- (IBAction)trackTapped:(id)sender {
    [self.trackPlayer play];
}
- (IBAction)stopTrackTapped:(id)sender {
    [self.trackPlayer stop];
}
- (IBAction)floorTomTapped:(id)sender {
    [self.floorTomPlayer play];
}
- (IBAction)snareTapped:(id)sender {
    [self.snarePlayer play];
}
- (IBAction)leftTomTapped:(id)sender {
    [self.leftTomPlayer play];
}
- (IBAction)rightTomTapped:(id)sender {
    [self.rightTomPlayer play];
}
- (IBAction)hatTapped:(id)sender {
    [self.hatPlayer play];
}
- (IBAction)crashTapped:(id)sender {
    [self.crashPlayer play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *defaultExtension = @"mp3";
    
    self.trackPlayer = [self createAudioPlayerWithUrl:[self createUrlForResourceName:@"Track" andExtension:defaultExtension]];
    self.floorTomPlayer = [self createAudioPlayerWithUrl:[self createUrlForResourceName:@"FloorTom" andExtension:defaultExtension]];
    self.snarePlayer = [self createAudioPlayerWithUrl:[self createUrlForResourceName:@"Snare" andExtension:defaultExtension]];
    self.leftTomPlayer = [self createAudioPlayerWithUrl:[self createUrlForResourceName:@"LeftTom" andExtension:defaultExtension]];
    self.rightTomPlayer = [self createAudioPlayerWithUrl:[self createUrlForResourceName:@"RightTom" andExtension:defaultExtension]];
    self.hatPlayer = [self createAudioPlayerWithUrl:[self createUrlForResourceName:@"Hat" andExtension:defaultExtension]];
    self.crashPlayer = [self createAudioPlayerWithUrl:[self createUrlForResourceName:@"Crash" andExtension:defaultExtension]];
}

- (NSURL *)createUrlForResourceName:(NSString *)resourceName andExtension:(NSString *)extension {
    if (!resourceName || !extension) {
        return nil;
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:resourceName ofType:extension];
    return [NSURL fileURLWithPath:filePath];
}

- (AVAudioPlayer *)createAudioPlayerWithUrl:(NSURL *)url {
    NSError *error;
    
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (!audioPlayer) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"Couldn't load file m4a" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:nil];
        return nil;
    } else {
        return audioPlayer;
    }
}

@end
