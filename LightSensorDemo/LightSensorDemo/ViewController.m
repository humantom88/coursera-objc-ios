//
//  ViewController.m
//  LightSensorDemo
//
//  Created by Tom Belov on 21/07/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(react) name:UIScreenBrightnessDidChangeNotification object:nil];
}

- (void)react {
    double brightness = [[UIScreen mainScreen] brightness];
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation((brightness * M_PI) - M_PI_2);
    self.arrowImage.transform = rotate;
}


@end
