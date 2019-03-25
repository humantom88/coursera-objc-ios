//
//  HomeWireframe.m
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "HomeWireframe.h"
#import "HomeViewController.h"

@implementation HomeWireframe

- (void)dismissHomeViewController { 
    [self.homeViewController dismissViewControllerAnimated:YES completion:nil];
    [self.splashWireframe presentSplashViewController];
}

- (void)presentHomeViewController { 
    HomeViewController* homeViewController = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
    self.homeViewController = homeViewController;
    self.homeViewController.navigation = self;
    self.window.rootViewController = homeViewController;
    [self.window makeKeyAndVisible];
    NSUserDefaults *def = [[NSUserDefaults alloc]init];
    NSArray *arr = @[@1, @2];
    
}

@end
