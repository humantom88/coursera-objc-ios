//
//  LoginViewController.h
//  Playground
//
//  Created by Tom Belov on 11/03/2019.
//  Copyright © 2019 Tom Belov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginInteractorProtocol.h"
#import "LoginViewControllerProtocol.h"
#import "LoginWireframe.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController <LoginViewControllerProtocol>

@property (strong, nonatomic) NSObject<LoginInteractorProtocol>* interactor;
@property (strong, nonatomic) LoginWireframe* navigation;

@end

NS_ASSUME_NONNULL_END
