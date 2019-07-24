//
//  ViewController.m
//  AccelerometerDemo
//
//  Created by Tom Belov on 21/07/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

@import CoreMotion;
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *staticButton;
@property (weak, nonatomic) IBOutlet UIButton *dynamicStartButton;
@property (weak, nonatomic) IBOutlet UIButton *dynamicStopButton;
@property (weak, nonatomic) IBOutlet UILabel *staticLabel;
@property (weak, nonatomic) IBOutlet UILabel *dynamicLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) CMMotionManager *manager;

@property (assign, nonatomic) double x;
@property (assign, nonatomic) double y;
@property (assign, nonatomic) double z;
@end

@implementation ViewController

- (IBAction)staticRequest:(id)sender {
    CMAccelerometerData *aData = self.manager.accelerometerData;
    if (aData != nil) {
        CMAcceleration acceleration = aData.acceleration;
        self.staticLabel.text = [NSString stringWithFormat:@"x:%f\ny:%f\nz:%f",
                                 acceleration.x,
                                 acceleration.y,
                                 acceleration.z];
    }
}
- (IBAction)dynamicStart:(id)sender {
    self.dynamicStartButton.enabled = NO;
    self.dynamicStopButton.enabled = YES;
    
    self.manager.accelerometerUpdateInterval = 0.01;
    
    ViewController * __weak weakSelf = self;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [self.manager startAccelerometerUpdatesToQueue:queue
                                       withHandler:^(CMAccelerometerData * _Nullable data, NSError * _Nullable error) {
                                           self.x = .1 * data.acceleration.x + .9 * self.x;
                                           self.y = .1 * data.acceleration.y + .9 * self.y;
                                           self.z = .1 * data.acceleration.z + .9 * self.z;
                                           double rotation = -atan2(self.x, -self.y);
                                           [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                               weakSelf.imageView.transform = CGAffineTransformMakeRotation(rotation);
                                               weakSelf.dynamicLabel.text = [NSString stringWithFormat:@"rotation: %f\nx:%f\ny:%f\nz:%f", rotation, self.x, self.y, self.z];
                                           }];
                                       }
     ];
}
- (IBAction)dynamicStop:(id)sender {
    [self.manager stopAccelerometerUpdates];
    self.dynamicStartButton.enabled = YES;
    self.dynamicStopButton.enabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.staticLabel.text = @"No Data";
    self.dynamicLabel.text = @"No Data";
    self.staticButton.enabled = NO;
    self.dynamicStartButton.enabled = NO;
    self.dynamicStopButton.enabled = NO;
    
    self.manager = [CMMotionManager new];
    
    if (self.manager.accelerometerAvailable) {
        self.staticButton.enabled = YES;
        self.dynamicStartButton.enabled = YES;
        [self.manager startAccelerometerUpdates];
    } else {
        self.staticLabel.text = @"No Accelerometer Available";
        self.dynamicLabel.text = @"No Accelerometer Available";
    }
    
    self.imageView.image = [UIImage imageNamed:@"castle.jpg"];
    
    self.x = 0.0;
    self.y = 0.0;
    self.z = 0.0;
}


@end
