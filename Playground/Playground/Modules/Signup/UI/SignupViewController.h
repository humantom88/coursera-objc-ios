//
//  HomeWireframe.h
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"
#import "SplashWireframeProtocol.h"
#import "HomeWireframeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeWireframe : NSObject <HomeWireframeProtocol>

@property (strong, nonatomic) HomeViewController* homeViewController;
@property (weak, nonatomic) id<SplashWireframeProtocol> splashWireframe;
@property (weak, nonatomic) UIWindow *window;

@end

NS_ASSUME_NONNULL_END
