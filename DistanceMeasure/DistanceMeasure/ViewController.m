//
//  ViewController.m
//  DistanceMeasure
//
//  Created by Tom Belov on 06/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest *req;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;
@property (weak, nonatomic) IBOutlet UITextField *startLocation;
@property (weak, nonatomic) IBOutlet UITextField *endLocation1;
@property (weak, nonatomic) IBOutlet UILabel *distance1;
@property (weak, nonatomic) IBOutlet UITextField *endLocation2;
@property (weak, nonatomic) IBOutlet UILabel *distance2;
@property (weak, nonatomic) IBOutlet UITextField *endLocation3;
@property (weak, nonatomic) IBOutlet UILabel *distance3;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)calculateButtonTapped:(id)sender {
    self.calculateButton.enabled = NO;
    self.req = [DGDistanceRequest alloc];
    NSString *start = self.startLocation.text;
    NSString *end1 = self.endLocation1.text;
    NSString *end2 = self.endLocation2.text;
    NSString *end3 = self.endLocation3.text;
    NSArray *ends = @[end1, end2, end3];
    
    self.req = [self.req initWithLocationDescriptions:ends sourceDescription:start];
    
    __weak ViewController *weakSelf = self;
    
    self.req.callback = ^void(NSArray *responses){
        ViewController *strongSelf = weakSelf;
        
        if (!strongSelf) return;
        
        NSInteger index = strongSelf.segmentedController.selectedSegmentIndex;
        
        int divider = 0;
        NSString *label;
        if (index == 0) {
            divider = 1;
            label = @"m";
        } else if (index == 1) {
            divider = 1000;
            label = @"km";
        } else if (index == 2) {
            divider = 1609;
            label = @"miles";
        }
        
        NSNull *badResult = [NSNull null];
        
        if (responses[0] != badResult) {
            float num = ([responses[0] floatValue] / divider);
            NSString *x = [NSString stringWithFormat:@"%.2f %@", num, label];
            strongSelf.distance1.text = x;
        } else {
            strongSelf.distance1.text = @"Error";
        }
        
        if (responses[1] != badResult) {
            float num = ([responses[1] floatValue] / divider);
            NSString *x = [NSString stringWithFormat:@"%.2f %@", num, label];
            strongSelf.distance2.text = x;
        } else {
            strongSelf.distance2.text = @"Error";
        }
        
        if (responses[2] != badResult) {
            float num = ([responses[2] floatValue] / divider);
            NSString *x = [NSString stringWithFormat:@"%.2f %@", num, label];
            strongSelf.distance3.text = x;
        } else {
            strongSelf.distance3.text = @"Error";
        }
        
        strongSelf.calculateButton.enabled = YES;
        strongSelf.req = nil;
    };
    
    [self.req start];
}

@end
