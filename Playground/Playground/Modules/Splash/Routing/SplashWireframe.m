//
//  SplashWireframe.m
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "SplashWireframe.h"
#import "LoginInteractor.h"
#import "LoginViewController.h"
#import "LoginWireframe.h"
#import "SignupInteractor.h"
#import "SignupViewController.h"
#import "SignupWireframe.h"
#import "SplashViewController.h"

@interface SplashWireframe ()

@property (nonatomic, weak) SplashViewController *splashViewController;
@property (nonatomic, weak) LoginViewController *loginViewController;
@property (nonatomic, weak) SignupViewController *signupViewController;

@end

@implementation SplashWireframe

+ (SplashWireframe*) sharedInstance {
    static SplashWireframe* sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    
    return sharedInstance;
}

- (void)presentLoginViewControllerInWindow {
    LoginViewController* loginViewController = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    self.loginViewController = loginViewController;
    self.loginViewController.interactor = [[LoginInteractor alloc] init];
    self.loginViewController.interactor.viewController = loginViewController;
    self.loginViewController.navigation = [[LoginWireframe alloc] init];

    return;
}

- (void)presentSignupViewControllerInWindow {
    SignupViewController* signupViewController = [[UIStoryboard storyboardWithName:@"Signup" bundle:nil] instantiateViewControllerWithIdentifier:@"SignupViewController"];
    self.signupViewController = signupViewController;
    self.signupViewController.interactor = [[SignupInteractor alloc] init];
    self.signupViewController.interactor.view = signupViewController;
    self.signupViewController.navigation = [[SignupWireframe alloc] init];
    self.signupViewController.navigation.signUpViewController = signupViewController;

    [self.splashViewController presentViewController:signupViewController animated:YES completion:nil];

    return;
}

- (void)presentSplashViewController {
    SplashViewController* splashViewController = [[UIStoryboard storyboardWithName:@"Splash" bundle:nil] instantiateViewControllerWithIdentifier:@"SplashViewController"];
    self.splashViewController = splashViewController;
    self.splashViewController.navigation = self;
    self.window.rootViewController = splashViewController;
    [self.window makeKeyAndVisible];
}

@end
