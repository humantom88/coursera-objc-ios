//
//  SplashWireframe.h
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashWireframeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SplashWireframe : NSObject <SplashWireframeProtocol>

@property (nonatomic, weak) UIWindow* window;

+ (SplashWireframe*) sharedInstance;

@end

NS_ASSUME_NONNULL_END
