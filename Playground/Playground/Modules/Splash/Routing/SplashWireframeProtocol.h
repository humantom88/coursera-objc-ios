//
//  SplashWireframeProtocol.h
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SplashWireframeProtocol <NSObject>

- (void)presentSplashViewController;
- (void)presentLoginViewControllerInWindow;
// - (void)presentSignupViewControllerInWindow;

@end

NS_ASSUME_NONNULL_END
