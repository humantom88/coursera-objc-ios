//
//  RootWireframe.m
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import "RootWireframe.h"
#import "Common/Data Store/DataStore.h"
#import "SplashWireframe.h"
#import "PGDApplicationAssembly.h"
// #import "HomeWireframe.h"

@interface RootWireframe ()
@property(nonatomic, strong) SplashWireframe* splashWireFrame;
// @property(nonatomic, strong) HomeWireframe* homeWireFrame;
@end

@implementation RootWireframe

- (instancetype)initWithSplashWireframe:(SplashWireframe *)splashWireframe assembly:(PGDApplicationAssembly *)assembly {
    self = [super init];
    
    _assembly = assembly;
    if (self) {
        self.splashWireFrame = SplashWireframe.sharedInstance;
    }
}

- (id)init
{
    return [self initWithSplashWireframe:nil assembly:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions window:(UIWindow *)window {
    self.splashWireFrame.window = window;
    // self.homeWireFrame.window = window;
    [self checkUserAvailability];
    return YES;
}

- (void)checkUserAvailability
{
    if([DataStore.defaultLocalDB checkAvailability]) {
        // Home
        // [self.homeWireFrame presentHomeViewController];
    } else {
        // Splash
        [self.splashWireFrame presentSplashViewController];
    }
}
@end
