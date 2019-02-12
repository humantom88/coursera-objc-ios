//
//  ViewController.m
//  UnitConverter
//
//  Created by Tom Belov on 05/02/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "ViewController.h"


double convertKmHToMS(double userInput) {
    return userInput * 1000 / 3600;
}

double convertKmHToSmS(double userInput) {
    return userInput * 1000000 / 3600;
}

double convertKmHToMilesH(double userInput) {
    return userInput / 1.60934;
}

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;

@end

@implementation ViewController


- (IBAction)updateButtonTapped:(id)sender {
    NSMutableString *buf = [[NSMutableString alloc] init];
    
    double userInput = [self.inputField.text doubleValue];
    
    if(self.segmentController.selectedSegmentIndex == 0) {
        [buf appendString: [@(convertKmHToMS(userInput)) stringValue]];
    } else if (self.segmentController.selectedSegmentIndex == 1) {
        [buf appendString: [@(convertKmHToSmS(userInput)) stringValue]];
    } else if (self.segmentController.selectedSegmentIndex == 2) {
        [buf appendString: [@(convertKmHToMilesH(userInput)) stringValue]];
    }

    self.outputLabel.text = buf;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
