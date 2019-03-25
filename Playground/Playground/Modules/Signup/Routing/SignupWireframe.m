//
//  SignupWireframe.m
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "SignupWireframe.h"
#import "HomeWireframe.h"

@interface SignupWireframe ()

@end

@implementation SignupWireframe

- (void)dismissSignupViewController { 
    [self.signUpViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentHomeScreen { 
    UIViewController* homeViewController = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
    self.homeViewController.navigation = [[HomeWireframe alloc]init];
    self.homeViewController.navigation.homeViewController = homeViewController;
    [self.signUpViewController presentViewController:self.homeViewController animated:YES completion:nil];
}

@end
