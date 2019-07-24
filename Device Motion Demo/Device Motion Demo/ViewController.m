//
//  ViewController.m
//  Device Motion Demo
//
//  Created by Tom Belov on 21/07/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

@import CoreMotion;
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) CMMotionManager *manager;
@property (strong, nonatomic) NSArray *images;
@property (assign, nonatomic) NSInteger imageCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [CMMotionManager new];

    self.images = @[
                    [UIImage imageNamed:@"castle.jpg"],
                    [UIImage imageNamed:@"castle2.jpg"],
                    [UIImage imageNamed:@"castle3.jpg"],
                    [UIImage imageNamed:@"castl4.jpg"],
                    ];

    self.imageCount = 0;
    [self chooseImage:0.0];
    
    [self.manager startDeviceMotionUpdates];
    
    self.manager.accelerometerUpdateInterval = 0.01;
    
    
    CMAttitudeReferenceFrame frame = CMAttitudeReferenceFrameXArbitraryZVertical;
//    CMAttitudeReferenceFrame *frame = CMAttitudeReferenceFrameXArbitraryCorrectedZVertical;
//    CMAttitudeReferenceFrame *frame = CMAttitudeReferenceFrameXMagneticNorthZVertical;
//    CMAttitudeReferenceFrame *frame = CMAttitudeReferenceFrameXTrueNorthZVertical;
    
    ViewController * __weak weakSelf = self;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [self.manager startDeviceMotionUpdatesUsingReferenceFrame:frame
                                                      toQueue:queue
                                                  withHandler:^(CMDeviceMotion * _Nullable data, NSError * _Nullable error) {
                                                      double yaw = data.attitude.yaw;
                                                      
                                                      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                          weakSelf.imageView.transform = CGAffineTransformMakeRotation(yaw);
                                                          [self chooseImage:yaw];
                                                      }];
                                                  }
     ];
}

- (void)chooseImage:(double)yaw {
    if (yaw <= M_PI_4) {
        if (yaw >= -M_PI_4) {
            self.imageView.image = self.images[0];
        } else if (yaw >= -3.0 * M_PI_4) {
            self.imageView.image = self.images[1];
        } else {
            self.imageView.image = self.images[2];
        }
    }
    else {
        if (yaw <= 3.0 * M_PI_4) {
            self.imageView.image = self.images[3];
        } else {
            self.imageView.image = self.images[2];
        }
    }
}

@end
