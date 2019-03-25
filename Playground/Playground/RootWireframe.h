//
//  RootWireframe.h
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class SplashWireframe;
@class PGDApplicationAssembly;

NS_ASSUME_NONNULL_BEGIN

@interface RootWireframe : NSObject
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions window:(UIWindow *)window;
- (instancetype)initWithSplashWireframe:(SplashWireframe *)splashWireframe assembly:(PGDApplicationAssembly *)assembly;
@end

NS_ASSUME_NONNULL_END
