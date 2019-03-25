//
//  HomeWireframe.h
//  Playground
//
//  Created by Tom Belov on 15/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "HomeWireframeProtocol.h"
#import "SplashWireframeProtocol.h"

#ifndef HomeWireframe_h
#define HomeWireframe_h

@interface HomeWireframe : NSObject <HomeWireframeProtocol>

@property (weak, nonatomic) HomeViewController *homeViewController;
@property (weak, nonatomic) NSObject<SplashWireframeProtocol> *splashWireframeProtocol;

@end

#endif /* HomeWireframe_h */


