//
//  SplashViewController.m
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "SplashViewController.h"

@implementation SplashViewController

- (IBAction)loginTapped:(id)sender {
    [self.navigation presentLoginViewControllerInWindow];
}
- (IBAction)signUpTapped:(id)sender {
    // [self.navigation presentSignupViewControllerInWindow];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
