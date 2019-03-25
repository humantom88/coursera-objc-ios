//
//  SignupWireframe.h
//  Playground
//
//  Created by Tom Belov on 12/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"
#import "SignupViewControllerProtocol.h"
#import "SignupWireframeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignupWireframe : NSObject <SignupWireframeProtocol>

@property (weak, nonatomic) UIViewController<SignupViewControllerProtocol> *signUpViewController;
@property (weak, nonatomic) HomeViewController *homeViewController;

@end

NS_ASSUME_NONNULL_END
